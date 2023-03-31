class TourPassengersModel {
  int? id;
  int? orderId;
  String? userId;
  String? name;
  String? phoneNumber;
  String? dateOfBirth;
  String? address;

  TourPassengersModel(
      {this.id,
      this.orderId,
      this.userId,
      this.name,
      this.phoneNumber,
      this.dateOfBirth,
      this.address});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'order_id': orderId,
        'user_id': userId,
        'name': name,
        'phone_number': phoneNumber,
        'date_of_birth': dateOfBirth,
        'address': address,
      };

  static TourPassengersModel fromJson(Map<String, dynamic> json) =>
      TourPassengersModel(
        id: json['id'] as int,
        orderId: json['order_id'] as int,
        userId: json['user_id'] as String,
        name: json['name'] as String,
        phoneNumber: json['phone_number'] as String,
        dateOfBirth: json['date_of_birth'] as String,
        address: json['address'] as String,
      );
}
