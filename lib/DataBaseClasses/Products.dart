import 'dart:convert';

Products clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Products.fromMap(jsonData);
}

String clientToJson(Products data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Products {
  late String name, details, price, quantity;
  int id;

  Products(
      {required this.id,
      required this.name,
      required this.details,
      required this.price,
      required this.quantity});

  factory Products.fromMap(Map<String, dynamic> json) => Products(
        id: json["id"],
        name: json["name"],
        details: json["details"],
        price: json["price"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "details": details,
        "price": price,
        "quantity": quantity,
      };
}
