import 'dart:convert';

class ProductModels {
  final String? url;
  final String? productName;
  final double? cost;
  final int? discount;
  final String? uid;
  final String? sellerName;
  final String? sellerUid;
  final int? rating;
  final int? numberOfRating;
  ProductModels({
    required this.url,
    required this.productName,
    required this.cost,
    required this.discount,
    required this.uid,
    required this.sellerName,
    required this.sellerUid,
    required this.rating,
    required this.numberOfRating,
  });

  ProductModels copyWith({
    String? url,
    String? productName,
    double? cost,
    int? discount,
    String? uid,
    String? sellerName,
    String? sellerUid,
    int? rating,
    int? numberOfRating,
  }) {
    return ProductModels(
      url: url ?? this.url,
      productName: productName ?? this.productName,
      cost: cost ?? this.cost,
      discount: discount ?? this.discount,
      uid: uid ?? this.uid,
      sellerName: sellerName ?? this.sellerName,
      sellerUid: sellerUid ?? this.sellerUid,
      rating: rating ?? this.rating,
      numberOfRating: numberOfRating ?? this.numberOfRating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'productName': productName,
      'cost': cost,
      'discount': discount,
      'uid': uid,
      'sellerName': sellerName,
      'sellerUid': sellerUid,
      'rating': rating,
      'numberOfRating': numberOfRating,
    };
  }

  factory ProductModels.fromMap(Map<String, dynamic> map) {
    return ProductModels(
      url: map['url'],
      productName: map['productName'],
      cost: map['cost']?.toDouble(),
      discount: map['discount']?.toInt(),
      uid: map['uid'],
      sellerName: map['sellerName'],
      sellerUid: map['sellerUid'],
      rating: map['rating']?.toInt(),
      numberOfRating: map['numberOfRating']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModels.fromJson(String source) =>
      ProductModels.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModels(url: $url, productName: $productName, cost: $cost, discount: $discount, uid: $uid, sellerName: $sellerName, sellerUid: $sellerUid, rating: $rating, numberOfRating: $numberOfRating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModels &&
        other.url == url &&
        other.productName == productName &&
        other.cost == cost &&
        other.discount == discount &&
        other.uid == uid &&
        other.sellerName == sellerName &&
        other.sellerUid == sellerUid &&
        other.rating == rating &&
        other.numberOfRating == numberOfRating;
  }

  @override
  int get hashCode {
    return url.hashCode ^
        productName.hashCode ^
        cost.hashCode ^
        discount.hashCode ^
        uid.hashCode ^
        sellerName.hashCode ^
        sellerUid.hashCode ^
        rating.hashCode ^
        numberOfRating.hashCode;
  }

  Map<String, dynamic> getjson() {
    return {
      "url": url,
      "productName": productName,
      "cost": cost,
      "discount": discount,
      "uid": uid,
      "sellerUid": sellerUid,
      "rating": rating,
      "numberOfRating": numberOfRating,
    };
  }

  factory ProductModels.getModelFromJson({required Map<String, dynamic> json}) {
    return ProductModels(
      url: json["url"],
      productName: json["productName"],
      cost: json["cost"],
      discount: json["discount"],
      uid: json["uid"],
      sellerName: json["sellerName"],
      sellerUid: json["sellerUid"],
      rating: json["rating"],
      numberOfRating: json["numberOfRating"],
    );
  }
}
