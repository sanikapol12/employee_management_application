class EmployeeModel {
  String id;
  String name;
  String email;
  String mobile;
  String country;
  String state;
  String district;
  String photoUrl;
  String createdAt;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.country,
    required this.state,
    required this.district,
    this.photoUrl = '',
    this.createdAt = '',
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    // Handling API variations where email can be 'email' or 'emailId'
    final resolvedEmail = json['email']?.toString().isNotEmpty == true
        ? json['email'].toString()
        : (json['emailId']?.toString() ?? '');

    // Handling photo URL variations ('avatar', 'photoUrl', 'profilePhoto')
    final resolvedAvatar = json['avatar']?.toString().isNotEmpty == true
        ? json['avatar'].toString()
        : (json['photoUrl']?.toString().isNotEmpty == true
            ? json['photoUrl'].toString()
            : (json['profilePhoto']?.toString() ?? ''));

    return EmployeeModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: resolvedEmail,
      mobile: json['mobile']?.toString() ?? '',
      country: json['country']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
      district: json['district']?.toString() ?? '',
      photoUrl: resolvedAvatar,
      createdAt: json['createdAt']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id.isNotEmpty) 'id': id,
      'name': name,
      'email': email,
      'emailId': email,
      'mobile': mobile,
      'country': country,
      'state': state,
      'district': district,
      'avatar': photoUrl,
      'photoUrl': photoUrl,
    };
  }

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
    String? createdAt,
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
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
