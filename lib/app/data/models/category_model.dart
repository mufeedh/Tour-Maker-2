class CategoryModel {
  CategoryModel({this.category});
  String? category;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'category': category,
      };
  static CategoryModel fromJson(Map<String, String> json) => CategoryModel(
        category: json['category'],
      );
}
