class CountryModel {
  final String id;
  final String country;
  final String flag;
  final String createdAt;

  CountryModel({
    required this.id,
    required this.country,
    this.flag = '',
    this.createdAt = '',
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id']?.toString() ?? '',
      country: json['country']?.toString() ?? '',
      flag: json['flag']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'flag': flag,
      'createdAt': createdAt,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
