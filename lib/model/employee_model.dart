

class EmployeeModel {
  String id;
  String name;
  String email;
  String mobile;
  String country;
  String state;
  String district;
  String photoUrl;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.country,
    required this.state,
    required this.district,
    this.photoUrl = '',
  });

  // Simple copyWith method to make editing easy
  EmployeeModel copyWith({
    String? id,
    String? name,
    String? email,
    String? mobile,
    String? country,
    String? state,
    String? district,
    String? photoUrl,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      country: country ?? this.country,
      state: state ?? this.state,
      district: district ?? this.district,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
