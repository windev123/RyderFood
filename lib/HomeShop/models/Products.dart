import 'dart:convert';

class AllProducts {
  final String id;
  final String image;
  final String name;
  final String price;
  final String store;
  AllProducts({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.store,
  });

  AllProducts copyWith({
    String? id,
    String? image,
    String? name,
    String? price,
    String? store,
  }) {
    return AllProducts(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      store: store ?? this.store,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'image': image});
    result.addAll({'name': name});
    result.addAll({'price': price});
    result.addAll({'store': store});

    return result;
  }

  factory AllProducts.fromMap(Map<String, dynamic> map) {
    return AllProducts(
      id: map['id'] ?? '',
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      store: map['store'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AllProducts.fromJson(String source) =>
      AllProducts.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AiiProducts(id: $id, image: $image, name: $name, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AllProducts &&
        other.id == id &&
        other.image == image &&
        other.name == name &&
        other.price == price &&
        other.store == store;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        name.hashCode ^
        price.hashCode ^
        store.hashCode;
  }
}
