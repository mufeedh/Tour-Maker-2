class SingleExclusiveTourModel {
  SingleExclusiveTourModel(
      {this.iD,
      this.name,
      this.image,
      this.destination,
      this.description,
      this.days,
      this.nights,
      this.priority,
      this.trending,
      this.exclusiveTour,
      this.tourCode,
      this.category,
      this.itinerary,
      this.travelType,
      this.region});
  int? iD;
  String? name;
  String? image;
  String? destination;
  String? description;
  int? days;
  int? nights;
  int? priority;
  String? trending;
  String? exclusiveTour;
  String? tourCode;
  String? category;
  String? itinerary;
  String? travelType;
  String? region;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'ID': iD,
        'name': name,
        'image': image,
        'destination': destination,
        'description': description,
        'days': days,
        'nights': nights,
        'priority': priority,
        'trending': trending,
        'exclusive_tour': exclusiveTour,
        'tour_code': tourCode,
        'category': category,
        'itinerary': itinerary,
        'travel_type': travelType,
        'region': region,
      };

  static SingleExclusiveTourModel fromJson(Map<String, dynamic> json) =>
      SingleExclusiveTourModel(
        iD: json['ID'] as int,
        name: json['name'] as String,
        image: json['image'] as String,
        destination: json['destination'] as String,
        description: json['description'] as String,
        days: json['days'] as int,
        nights: json['nights'] as int,
        priority: json['priority'] as int,
        trending: json['trending'] as String,
        exclusiveTour: json['exclusive_tour'] as String,
        tourCode: json['tour_code'] as String,
        category: json['category'] as String,
        itinerary: json['itinerary'] as String,
        travelType: json['travel_type'] as String,
        region: json['region'] as String,
      );
}
