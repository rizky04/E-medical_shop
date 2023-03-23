class CatergoryWithProduct {
  final String idCategory;
  final String category;
  final String image;
  final String status;
  final List<ProductModel> product;

  const CatergoryWithProduct({
    required this.idCategory,
    required this.category,
    required this.image,
    required this.status,
    required this.product,
  });
  
  factory CatergoryWithProduct.fromJson(Map<String, dynamic> data) {
    var list = data['product'] as List;
    List<ProductModel> listProduct =
        list.map((e) => ProductModel.fromJson(e)).toList();
    return CatergoryWithProduct(
      idCategory: data['idCategory'],
      category: data['category'],
      image: data['image'],
      status: data['status'],
      product: listProduct,
    );
  }
}

class ProductModel {
  final String id_product;
  final String id_category;
  final String name;
  final String description;
  final String image;
  final String price;
  final String status;
  final String created_at;

  const ProductModel({
    required this.id_product,
    required this.id_category,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.status,
    required this.created_at,
  });
  factory ProductModel.fromJson(Map<String, dynamic> data) {
    return ProductModel(
        id_product: data['id_product'],
        id_category: data['id_category'],
        name: data['name'],
        description: data['description'],
        image: data['image'],
        price: data['price'],
        status: data['status'],
        created_at: data['created_at']);
  }
}
