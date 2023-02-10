class CategoryModel {
  String? category;

  CategoryModel({this.category});
  Map<String, dynamic> toJson() => {
        'category': category,
      };
  static CategoryModel fromJson(Map<String, dynamic> json) => CategoryModel(
        category: json['category'],
      );
}
