class WishListModel {
  WishListModel({
    this.baseAmount,
    this.category,
    this.days,
    this.destination,
    this.exclusiveTour,
    this.id,
    this.image,
    this.itinerary,
    this.name,
    this.nights,
    this.priority,
    this.region,
    this.tourCode,
    this.tourId,
    this.travelType,
    this.trending,
  });
  int? baseAmount;
  String? category;
  int? days;
  String? destination;
  String? exclusiveTour;
  int? id;
  String? image;
  String? itinerary;
  String? name;
  int? nights;
  int? priority;
  String? region;
  String? tourCode;
  int? tourId;
  String? travelType;
  bool? trending;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'base_amount': baseAmount,
        'category': category,
        'days': days,
        'destination': destination,
        'exclusive_tour': exclusiveTour,
        'id': id,
        'image': image,
        'itinerary': itinerary,
        'name': name,
        'nights': nights,
        'priority': priority,
        'region': region,
        'tour_code': tourCode,
        'tour_id': tourId,
        'travel_type': travelType,
        'trending': trending,
      };
  static WishListModel fromJson(Map<String, dynamic> json) => WishListModel(
        baseAmount: json['base_amount'] as int,
        category: json['category'] as String,
        days: json['days'] as int,
        destination: json['destination'] as String,
        exclusiveTour: json['exclusive_tour'] as String,
        id: json['id'] as int,
        image: json['image'] as String,
        itinerary: json['itinerary'] as String,
        name: json['name'] as String,
        nights: json['nights'] as int,
        priority: json['priority'] as int,
        region: json['region'] as String,
        tourCode: json['tour_code'] as String,
        tourId: json['tour_id'] as int,
        travelType: json['travel_type'] as String,
        trending: json['trending'] as bool,
      );
}
