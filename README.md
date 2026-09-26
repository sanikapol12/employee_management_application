# flutter-developer-as-final-83628-sanika
##  Employee Management Application (Flutter Assignment) 

A responsive Employee Management Application built in Flutter for the **Flutter Developer Assignment (Deadline: 30th Sep 2026)**. Designed with a practical MVC pattern and clean, accessible college-student style code.

---

## Screens Built for Today's Task

### 1.  Splash Screen (`lib/view/splash_screen.dart`)
- Three people emoji 
- Title & Loading workspace indicator
- Smooth 3-second automatic navigation to Login Screen

### 2.  Authentication Screens
- **Login Screen (`lib/view/login_screen.dart`)**:
  - Email & Password input fields with visibility toggle
  - **Forgot Password?** link
  - **Login** button
  - **Sign in with Google** button
  - **New User? Register Here** button
- **Registration Screen (`lib/view/register_screen.dart`)**:
  - Complete form to create new user credentials and profile
- **Forgot Password Screen (`lib/view/forgot_password_screen.dart`)**:
  - Email input with password reset link notification

### 3.  Employee Management System Screen (`lib/view/home_screen.dart`)
Matches all assignment requirements:
- **View Employees**: Displays employee cards with **Name, Email, Mobile, Country, State, and District**.
- **Search Employees by ID**: Real-time ID search input (e.g. `EMP-101`).
- **Filter Dropdown & Input**: Filter by **Name, Email, Mobile, or Country**.
- **Add Employee**: Floating Action Button (+) opens the add form.
- **Edit Employee**: Pre-populates all existing employee details for editing.
- **View Employee**: Dedicated detail view with full profile information.
- **Delete Employee**: Confirmation `AlertDialog` before deletion.
- **Pull-to-Refresh**: `RefreshIndicator` simulating network refresh.
- **Empty & Loading States**: Clear feedback when no records are found or when loading.

### 4.  Add & Edit Employee Screen (`lib/view/add_edit_employee_screen.dart`)
- Handles both **Add** and **Edit** modes.
- Pre-populates data when editing existing employees.
- Complete form validation for all required fields: Name, Email, Mobile, Country, State, District.

### 5.  View Employee Details Screen (`lib/view/employee_detail_screen.dart`)
- Dedicated card view of employee with quick Edit and Delete actions.

### 6.  Navigation & Tabs (`lib/view/bottom_nav_bar.dart`)
Separate file containing the 4 primary tabs:
- **Home**: Employee Management System CRUD UI
- **Search**: Directory search & filter
- **Task**: Daily employee tasks with checklist
- **Profile (`lib/view/profile_screen.dart`)**: Displays logged-in user's profile photo, name, email, and employee details with a Logout option.

---

##  How to Run

Test directly in Chrome or Edge:
```bash
flutter run -d chrome
```
or
```bash
flutter run -d edge
```

Run test suite:
```bash
flutter test
```

