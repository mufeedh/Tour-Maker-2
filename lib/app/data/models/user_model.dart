class UserModel {
  UserModel(
      {this.userName,
      this.phoneNumber,
      this.address,
      this.state,
      this.category,
      this.district,
      this.email,
      this.enterpriseName,
      this.gender,
      this.paymentID,
      this.paymentStatus,
      this.tandcstatus});
  String? userName;
  String? address;
  String? phoneNumber;
  String? state;
  String? category;
  String? district;
  String? email;
  String? enterpriseName;
  String? gender;
  String? paymentID;
  String? paymentStatus;
  String? tandcstatus;

  Map<String, dynamic> tojson() => <String, dynamic>{
        'address': address,
        'category': category,
        'district': district,
        'email': email,
        'enterprise_name': enterpriseName,
        'gender': gender,
        'name': userName,
        'payment_id': paymentID,
        'payment_status': paymentStatus,
        'phone_number': phoneNumber,
        'state': state,
        't_and_c_status': tandcstatus,
      };
  static UserModel fromjson(Map<String, dynamic> json) => UserModel(
        address: json['address'] as String,
        category: json['category'] as String,
        district: json['district'] as String,
        email: json['email'] as String,
        enterpriseName: json['enterprise_name'] as String,
        gender: json['gender'] as String,
        userName: json['name'] as String,
        paymentID: json['payment_id'] as String,
        paymentStatus: json['payment_status'] as String,
        phoneNumber: json['phone_number'] as String,
        state: json['state'] as String,
        tandcstatus: json['tandc_status'] as String,
      );
}
