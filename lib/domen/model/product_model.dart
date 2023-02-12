class ProductModel {
  final String? name;
  final String? desc;
  final String? image;
  final num? price;
  final String? category;
  final String? id;
  bool isLike;

  ProductModel({
    required this.name,
    required this.desc,
    required this.image,
    required this.price,
    required this.category,
    required this.isLike,
    required this.id,
  });

  factory ProductModel.fromJson({Map? data, String? id}) {
    return ProductModel(
      name: data?["name"],
      desc: data?["desc"],
      image: data?["image"],
      price: data?["price"],
      category: data?["category"],
      isLike: data?["isLike"] ?? false,
      id: id,
    );
  }

  toJson() {
    return {
      "name": name,
      "desc": desc,
      "image": image,
      "price": price,
      "category": category,
      "isLike": isLike,
    };
  }
}
