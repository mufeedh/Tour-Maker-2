class BookingsModel {
  BookingsModel(
      {this.amountPaid,
      this.customTourId,
      this.dateOfTravel,
      this.id,
      this.isCustom,
      this.noOfAdults,
      this.noOfChildren,
      this.offerApplied,
      this.orderConfirmed,
      this.orderDate,
      this.orderStatus,
      this.packageId,
      this.payableAmount,
      this.totalAmount,
      this.tourCode,
      this.tourName,
      this.userId});
  int? amountPaid;
  int? customTourId;
  String? dateOfTravel;
  int? id;
  bool? isCustom;
  int? noOfAdults;
  int? noOfChildren;
  bool? offerApplied;
  bool? orderConfirmed;
  String? orderDate;
  String? orderStatus;
  int? packageId;
  int? payableAmount;
  int? totalAmount;
  String? tourCode;
  String? tourName;
  String? userId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'amount_paid': amountPaid,
        'custom_tour_id': customTourId,
        'date_of_travel': dateOfTravel,
        'id': id,
        'is_custom': isCustom,
        'no_of_adults': noOfAdults,
        'no_of_children': noOfChildren,
        'offer_applied': offerApplied,
        'order_confirmed': orderConfirmed,
        'order_date': orderDate,
        'order_status': orderStatus,
        'package_id': packageId,
        'payable_amount': payableAmount,
        'total_amount': totalAmount,
        'tour_code': tourCode,
        'tour_name': tourName,
        'user_id': userId,
      };

  static BookingsModel fromJson(Map<String, dynamic> json) => BookingsModel(
        amountPaid: json['amount_paid'] as int,
        customTourId: json['custom_tour_id'] as int,
        dateOfTravel: json['date_of_travel'] as String,
        id: json['id'] as int,
        isCustom: json['is_custom'] as bool,
        noOfAdults: json['no_of_adults'] as int,
        noOfChildren: json['no_of_children'] as int,
        offerApplied: json['offer_applied'] as bool,
        orderConfirmed: json['order_confirmed'] as bool,
        orderDate: json['order_date'] as String,
        orderStatus: json['order_status'] as String,
        packageId: json['package_id'] as int,
        payableAmount: json['payable_amount'] as int,
        totalAmount: json['total_amount'] as int,
        tourCode: json['tour_code'] as String,
        tourName: json['tour_name'] as String,
        userId: json['user_id'] as String,
      );
}
