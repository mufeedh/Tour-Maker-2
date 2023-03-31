class CheckOutModel {
  CheckOutModel(
      {this.tourName,
      this.tourCode,
      this.tourItinerary,
      this.dateOfTravel,
      this.amount,
      this.kidsAmount,
      this.offerAmount,
      this.kidsOfferAmount,
      this.adultCount,
      this.childrenCount,
      this.gst,
      this.sgst,
      this.commission,
      this.orderID,
      this.transportationMode,
      this.advanceAmount});
  String? tourName;
  String? tourCode;
  String? tourItinerary;
  String? dateOfTravel;
  int? amount;
  int? kidsAmount;
  int? offerAmount;
  int? kidsOfferAmount;
  int? adultCount;
  int? childrenCount;
  int? gst;
  int? sgst;
  int? commission;
  int? orderID;
  String? transportationMode;
  int? advanceAmount;
}
