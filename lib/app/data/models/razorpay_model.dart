class RazorPayModel {
  RazorPayModel(
      {this.amount,
      this.currency,
      this.name,
      this.email,
      this.contact,
      this.packageId});
  int? amount;
  String? currency;
  String? name;
  String? email;
  String? contact;
  String? packageId;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'amount': amount,
        'currency': currency,
        'name': name,
        'email': email,
        'contact': contact,
      };
  static RazorPayModel fromJson(Map<String, dynamic> json) => RazorPayModel(
        packageId: json['id'] as String,
      );
}
