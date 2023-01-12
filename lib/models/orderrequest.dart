import 'dart:convert';

class OrderRequest {
  final String? orderName;
  final String? buyersAddress;
  OrderRequest({
    this.orderName,
    this.buyersAddress,
  });


  OrderRequest copyWith({
    String? orderName,
    String? buyersAddress,
  }) {
    return OrderRequest(
      orderName: orderName ?? this.orderName,
      buyersAddress: buyersAddress ?? this.buyersAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderName': orderName,
      'buyersAddress': buyersAddress,
    };
  }

  factory OrderRequest.fromMap(Map<String, dynamic> map) {
    return OrderRequest(
      orderName: map['orderName'],
      buyersAddress: map['buyersAddress'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderRequest.fromJson(String source) => OrderRequest.fromMap(json.decode(source));

  @override
  String toString() => 'OrderRequest(orderName: $orderName, buyersAddress: $buyersAddress)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OrderRequest &&
      other.orderName == orderName &&
      other.buyersAddress == buyersAddress;
  }

  @override
  int get hashCode => orderName.hashCode ^ buyersAddress.hashCode;
}
