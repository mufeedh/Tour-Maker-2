class RecentSearch {
  RecentSearch({required this.keyword});
  factory RecentSearch.fromJson(Map<String, dynamic> json) {
    return RecentSearch(keyword: json['keyword'] as String);
  }
  String keyword;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'keyword': keyword,
      };
}
