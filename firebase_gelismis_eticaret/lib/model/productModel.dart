class ProductModel {
  final String productId;
  final String productTitle;
  final int productPrice;
  final String productDescription;
  final String productImage;
  int adet;

  ProductModel({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productDescription,
    required this.productImage,
    this.adet=1,
  });

  factory ProductModel.fromMap(Map<String, dynamic> json, {dynamic key}) {
    return ProductModel(
      productId: key ?? json["productId"],
      productTitle: json["productTitle"],
      productPrice: json["productPrice"],
      productDescription: json["productDescription"],
      productImage: json["productImage"],
    );
  }

  Map<String, dynamic> toMap({dynamic key}) {
    return {
      "productId": key ?? productId,
      "productTitle": productTitle,
      "productPrice": productPrice,
      "productDescription": productDescription,
      "productImage": productImage,
    };
  }
}
