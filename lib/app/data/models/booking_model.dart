class BookingsModel {
  BookingsModel(
      {this.amountPaid,
      this.dateOfTravel,
      this.gst,
      this.gstAmount,
      this.id,
      this.isCustom,
      this.noOfAdults,
      this.noOfKids,
      this.offerApplied,
      this.orderConfirmed,
      this.orderStatus,
      this.packageId,
      this.payableAmount,
      this.reward,
      this.totalAmount,
      this.tourCode,
      this.tourName,
      this.userId});
  num? amountPaid;
  String? dateOfTravel;
  num? gst;
  num? gstAmount;
  num? id;
  bool? isCustom;
  num? noOfAdults;
  num? noOfKids;
  bool? offerApplied;
  num? orderConfirmed;
  String? orderStatus;
  num? packageId;
  num? payableAmount;
  num? reward;
  num? totalAmount;
  String? tourCode;
  String? tourName;
  String? userId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'amount_paid': amountPaid,
        'date_of_travel': dateOfTravel,
        'gst': gst,
        'gst_amount': gstAmount,
        'id': id,
        'is_custom': isCustom,
        'no_of_adults': noOfAdults,
        'no_of_kids': noOfKids,
        'offer_applied': offerApplied,
        'order_confirmed': orderConfirmed,
        'order_status': orderStatus,
        'package_id': packageId,
        'payable_amount': payableAmount,
        'reward': reward,
        'total_amount': totalAmount,
        'tour_code': tourCode,
        'tour_name': tourName,
        'user_id': userId,
      };

  static BookingsModel fromJson(Map<String, dynamic> json) => BookingsModel(
        amountPaid: json['amount_paid'] as num,
        dateOfTravel: json['date_of_travel'] as String,
        gst: json['gst'] as num,
        gstAmount: json['gst_amount'] as num,
        id: json['id'] as num,
        isCustom: json['is_custom'] as bool,
        noOfAdults: json['no_of_adults'] as num,
        noOfKids: json['no_of_kids'] as num,
        offerApplied: json['offer_applied'] as bool,
        orderConfirmed: json['order_confirmed'] as num,
        orderStatus: json['order_status'] as String,
        packageId: json['package_id'] as num,
        payableAmount: json['payable_amount'] as num,
        reward: json['reward'] as num,
        totalAmount: json['total_amount'] as num,
        tourCode: json['tour_code'] as String,
        tourName: json['tour_name'] as String,
        userId: json['user_id'] as String,
      );
}
