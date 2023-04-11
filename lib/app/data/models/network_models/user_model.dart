class UserModel {
  UserModel({
    this.address,
    this.category,
    this.district,
    this.email,
    this.enterpriseName,
    this.gender,
    this.name,
    this.paymentId,
    this.paymentStatus,
    this.phoneNumber,
    this.state,
    this.tAndCStatus,
    this.profileImage,
    this.country,
  });
  String? address;
  String? category;
  String? district;
  String? email;
  String? enterpriseName;
  String? gender;
  String? name;
  String? paymentId;
  String? paymentStatus;
  String? phoneNumber;
  String? state;
  String? tAndCStatus;
  String? profileImage;
  String? country;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'address': address,
        'category': category,
        'district': district,
        'email': email,
        'enterprise_name': enterpriseName,
        'gender': gender,
        'name': name,
        'payment_id': paymentId,
        'payment_status': paymentStatus,
        'phone_number': phoneNumber,
        'state': state,
        't_and_c_status': tAndCStatus,
        'country': country,
      };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        address: json['address'] as String,
        category: json['category'] as String,
        district: json['district'] as String,
        email: json['email'] as String,
        enterpriseName: json['enterprise_name'] as String,
        gender: json['gender'] as String,
        name: json['name'] as String,
        paymentId: json['payment_id'] as String,
        paymentStatus: json['payment_status'] as String,
        phoneNumber: json['phone_number'] as String,
        state: json['state'] as String,
        tAndCStatus: json['t_and_c_status'] as String,
        profileImage: json['profile_image'] as String,
        country: json['country'] as String,
      );
}
