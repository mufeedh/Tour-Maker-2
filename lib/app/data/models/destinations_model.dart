class DestinationsModel {
  String? destination;

  DestinationsModel({this.destination});

  Map<String, dynamic> toJson() => {
        'destination': destination,
      };
  static DestinationsModel fromJson(Map<String, dynamic> json) =>
      DestinationsModel(
        destination: json['destination'],
      );
}
