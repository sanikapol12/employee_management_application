import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../core/app_logger.dart';
import '../model/user_model.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuth? _authInstance;
  final GoogleSignIn? _googleSignInInstance;

  FirebaseAuth get _auth => _authInstance ?? FirebaseAuth.instance;
  GoogleSignIn get _googleSignIn => _googleSignInInstance ?? GoogleSignIn();

  // Storing currently logged in employee
  UserModel? currentUser;
  bool isLoading = false;
  String errorMessage = '';

  AuthController({FirebaseAuth? auth, GoogleSignIn? googleSignIn})
      : _authInstance = auth,
        _googleSignInInstance = googleSignIn {
    _initCurrentUser();
  }

  void _initCurrentUser() {
    try {
      final fbUser = _auth.currentUser;
      if (fbUser != null) {
        currentUser = _userModelFromFirebase(fbUser);
        AppLogger.activity('Restored existing session', {'email': fbUser.email, 'uid': fbUser.uid});
      }
    } catch (_) {
      // Safe fallback for test environments or before Firebase initializeApp completes
    }
  }

  UserModel _userModelFromFirebase(User fbUser, [UserModel? extraDetails]) {
    final displayName = fbUser.displayName ?? '';
    final name = displayName.isNotEmpty
        ? displayName
        : (fbUser.email?.split('@')[0] ?? 'Employee');
    final empIdSuffix = fbUser.uid.length >= 6
        ? fbUser.uid.substring(0, 6).toUpperCase()
        : fbUser.uid.toUpperCase();

    return UserModel(
      empId: extraDetails != null && extraDetails.empId.isNotEmpty
          ? extraDetails.empId
          : 'EMP-$empIdSuffix',
      name: extraDetails != null && extraDetails.name.isNotEmpty
          ? extraDetails.name
          : name,
      email: fbUser.email ?? (extraDetails?.email ?? ''),
      phone: extraDetails != null && extraDetails.phone.isNotEmpty
          ? extraDetails.phone
          : (fbUser.phoneNumber ?? 'Not provided'),
      department: extraDetails != null && extraDetails.department.isNotEmpty
          ? extraDetails.department
          : 'Engineering',
      designation: extraDetails != null && extraDetails.designation.isNotEmpty
          ? extraDetails.designation
          : 'Employee',
      salary: extraDetails != null && extraDetails.salary.isNotEmpty
          ? extraDetails.salary
          : 'Standard',
      joiningDate: extraDetails != null && extraDetails.joiningDate.isNotEmpty
          ? extraDetails.joiningDate
          : 'Active',
      address: extraDetails != null && extraDetails.address.isNotEmpty
          ? extraDetails.address
          : 'Office Campus',
      imageUrl: extraDetails != null && extraDetails.imageUrl.isNotEmpty
          ? extraDetails.imageUrl
          : (fbUser.photoURL ?? ''),
    );
  }

  // Email/Password Login
  Future<bool> login(String email, String password) async {
    errorMessage = '';
    isLoading = true;
    notifyListeners();
    AppLogger.activity('Login attempt started', {'email': email.trim()});

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = userCredential.user;
      if (user != null) {
        currentUser = _userModelFromFirebase(user);
        isLoading = false;
        notifyListeners();
        AppLogger.activity('Login successful', {'email': user.email, 'uid': user.uid});
        return true;
      } else {
        errorMessage = 'Failed to retrieve user session.';
        isLoading = false;
        notifyListeners();
        AppLogger.error('Login', errorMessage);
        return false;
      }
    } on FirebaseAuthException catch (e) {
      errorMessage = _parseFirebaseAuthException(e);
      isLoading = false;
      notifyListeners();
      AppLogger.error('FirebaseAuth login (${e.code})', e.message);
      return false;
    } catch (e) {
      errorMessage = 'Login failed: ${e.toString()}';
      isLoading = false;
      notifyListeners();
      AppLogger.error('Unexpected login exception', e);
      return false;
    }
  }

  // Register new employee with Firebase Authentication
  Future<bool> registerEmployee(UserModel newEmployee, String password) async {
    errorMessage = '';
    isLoading = true;
    notifyListeners();
    AppLogger.activity('Registration attempt started', {'name': newEmployee.name, 'email': newEmployee.email});

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: newEmployee.email.trim(),
        password: password.trim(),
      );

      final user = userCredential.user;
      if (user != null) {
        // Update Firebase profile
        if (newEmployee.name.isNotEmpty) {
          await user.updateDisplayName(newEmployee.name);
        }
        if (newEmployee.imageUrl.isNotEmpty &&
            newEmployee.imageUrl.startsWith('http')) {
          await user.updatePhotoURL(newEmployee.imageUrl);
        }

        currentUser = _userModelFromFirebase(user, newEmployee);
        isLoading = false;
        notifyListeners();
        AppLogger.activity('Registration successful', {'name': newEmployee.name, 'uid': user.uid});
        return true;
      } else {
        errorMessage = 'Registration could not be completed.';
        isLoading = false;
        notifyListeners();
        AppLogger.error('Registration', errorMessage);
        return false;
      }
    } on FirebaseAuthException catch (e) {
      errorMessage = _parseFirebaseAuthException(e);
      isLoading = false;
      notifyListeners();
      AppLogger.error('FirebaseAuth register (${e.code})', e.message);
      return false;
    } catch (e) {
      errorMessage = 'Registration failed: ${e.toString()}';
      isLoading = false;
      notifyListeners();
      AppLogger.error('Unexpected register exception', e);
      return false;
    }
  }

  // Google Sign-In with Firebase
  Future<bool> signInWithGoogle() async {
    errorMessage = '';
    isLoading = true;
    notifyListeners();
    AppLogger.activity('Google Sign-In flow initiated');

    try {
      // Trigger the Google Authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        isLoading = false;
        notifyListeners();
        AppLogger.activity('Google Sign-In cancelled by user');
        return false;
      }

      AppLogger.activity('Google account selected', {'email': googleUser.email, 'displayName': googleUser.displayName});

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        currentUser = _userModelFromFirebase(user);
        isLoading = false;
        notifyListeners();
        AppLogger.activity('Google Sign-In with Firebase successful', {'email': user.email, 'uid': user.uid});
        return true;
      } else {
        errorMessage = 'Google Sign-In returned empty user profile.';
        isLoading = false;
        notifyListeners();
        AppLogger.error('Google Sign-In', errorMessage);
        return false;
      }
    } on FirebaseAuthException catch (e) {
      errorMessage = _parseFirebaseAuthException(e);
      isLoading = false;
      notifyListeners();
      AppLogger.error('FirebaseAuth Google Sign-In (${e.code})', e.message);
      return false;
    } catch (e) {
      errorMessage = 'Google Sign-In failed: ${e.toString()}';
      isLoading = false;
      notifyListeners();
      AppLogger.error('Unexpected Google Sign-In exception', e);
      return false;
    }
  }

  // Send Password Reset Email
  Future<bool> sendPasswordReset(String email) async {
    errorMessage = '';
    isLoading = true;
    notifyListeners();
    AppLogger.activity('Password reset requested', {'email': email.trim()});

    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      isLoading = false;
      notifyListeners();
      AppLogger.activity('Password reset email sent successfully', {'email': email.trim()});
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = _parseFirebaseAuthException(e);
      isLoading = false;
      notifyListeners();
      AppLogger.error('FirebaseAuth password reset (${e.code})', e.message);
      return false;
    } catch (e) {
      errorMessage = 'Failed to send reset email: ${e.toString()}';
      isLoading = false;
      notifyListeners();
      AppLogger.error('Unexpected password reset exception', e);
      return false;
    }
  }

  // Logout method
  Future<void> logout() async {
    final email = currentUser?.email ?? 'Unknown';
    AppLogger.activity('User logging out', {'email': email});
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      AppLogger.error('Logout signOut warning', e);
    }
    currentUser = null;
    errorMessage = '';
    notifyListeners();
    AppLogger.activity('User successfully logged out');
  }

  // User-friendly error message mapping
  String _parseFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password entered.';
      case 'invalid-credential':
        return 'Invalid email or password combination.';
      case 'email-already-in-use':
        return 'An account already exists for this email address.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'weak-password':
        return 'The password is too weak. Please use at least 6 characters.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled in Firebase Console.';
      case 'network-request-failed':
        return 'Network connection error. Please check your internet connection.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different sign-in credential.';
      default:
        return e.message ?? 'Authentication error (${e.code}).';
    }
  }
}
