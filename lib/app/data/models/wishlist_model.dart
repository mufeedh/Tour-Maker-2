class WishListModel {
  WishListModel({this.id, this.packageId, this.userId});
  int? id;
  int? packageId;
  String? userId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'package_id': packageId,
        'user_id': userId,
      };

  static WishListModel fromJson(Map<String, dynamic> json) => WishListModel(
        id: json['id'] as int,
        packageId: json['package_id'] as int,
        userId: json['user_id'] as String,
      );
}
