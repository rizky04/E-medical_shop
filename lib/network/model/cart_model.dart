class CartModel {
  final String id_cart;
  final String quantity;
  final String name;
  final String image;
  final String price;

  CartModel({
    required this.id_cart,
    required this.quantity,
    required this.name,
    required this.image,
    required this.price,
  });
  factory CartModel.fromJson(json) {
    return CartModel(
        id_cart: json['id_cart'],
        quantity: json['quantity'],
        name: json['name'],
        image: json['image'],
        price: json['price']);
  }
}
