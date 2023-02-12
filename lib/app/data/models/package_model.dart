class PackageModel {
  PackageModel(
      {this.iD,
      this.name,
      this.image,
      this.destination,
      this.trending,
      this.exclusiveTour,
      this.tourCode,
      this.category,
      this.travelType,
      this.region,
      this.tourId,
      this.description,
      this.days,
      this.nights,
      this.dateOfTravel,
      this.totalSeats,
      this.availableSeats,
      this.batchOrIndividual,
      this.amount,
      this.offerAmount,
      this.extraOffer,
      this.lastAmount,
      this.itinerary,
      this.advanceAmount,
      this.transportationMode});
  int? iD;
  String? name;
  String? image;
  String? destination;
  String? trending;
  String? exclusiveTour;
  String? tourCode;
  String? category;
  String? travelType;
  String? region;
  int? tourId;
  String? description;
  int? days;
  int? nights;
  String? dateOfTravel;
  int? totalSeats;
  int? availableSeats;
  String? batchOrIndividual;
  int? amount;
  int? offerAmount;
  bool? extraOffer;
  int? lastAmount;
  String? itinerary;
  int? advanceAmount;
  String? transportationMode;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'ID': iD,
        'name': name,
        'image': image,
        'destination': destination,
        'trending': trending,
        ' exclusive_tour': exclusiveTour,
        'tour_code': tourCode,
        'category': category,
        'travel_type': travelType,
        'region': region,
        'tour_id': tourId,
        'description': description,
        'days': days,
        'nights': nights,
        'date_of_travel': dateOfTravel,
        'total_seats': totalSeats,
        'available_seats': availableSeats,
        'batch_or_individual': batchOrIndividual,
        'Amount': amount,
        'offer_amount': offerAmount,
        'extra_offer': extraOffer,
        'last_amount': lastAmount,
        'itinerary': itinerary,
        'advance_amount': advanceAmount,
        'transportation_mode': transportationMode,
      };
  static PackageModel fromJson(Map<String, dynamic> json) => PackageModel(
        iD: json['ID'] as int,
        name: json['name'] as String,
        image: json['image'] as String,
        destination: json['destination'] as String,
        trending: json['trending'] as String,
        exclusiveTour: json[' exclusive_tour'] as String,
        tourCode: json['tour_code'] as String,
        category: json['category'] as String,
        travelType: json['travel_type'] as String,
        region: json['region'] as String,
        tourId: json['tour_id'] as int,
        description: json['description'] as String,
        days: json['days'] as int,
        nights: json['nights'] as int,
        dateOfTravel: json['date_of_travel'] as String,
        totalSeats: json['total_seats'] as int,
        availableSeats: json['available_seats'] as int,
        batchOrIndividual: json['batch_or_individual'] as String,
        amount: json['Amount'] as int,
        offerAmount: json['offer_amount'] as int,
        extraOffer: json['extra_offer'] as bool,
        lastAmount: json['last_amount'] as int,
        itinerary: json['itinerary'] as String,
        advanceAmount: json['advance_amount'] as int,
        transportationMode: json['transportation_mode'] as String,
      );
}
