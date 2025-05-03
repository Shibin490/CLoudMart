class Product {
  String? id;
  String name;
  double price;
  String imageUrl;
  String description;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

 
  factory Product.fromMap(Map<String, dynamic> map, {required String id}) {
    return Product(
      id: id, 
      name: map['name'],
      price:
          map['price']
              .toDouble(), 
      imageUrl: map['imageUrl'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
    };
  }
}
