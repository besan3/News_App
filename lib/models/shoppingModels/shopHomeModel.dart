
import 'dart:convert';

HomeModel welcomeFromJson(String str) => HomeModel.fromJson(json.decode(str));

String welcomeToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
   required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  dynamic message;
  DataModel data;

  HomeModel copyWith({
    bool? status,
    dynamic message,
    DataModel? data,
  }) =>
      HomeModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    status: json["status"],
    message: json["message"],
    data: DataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class DataModel {
  DataModel({
    required this.banners,
   required this.products,
    required this.ad,
  });

  List<Banner> banners;
  List<Product> products;
  String ad;

  DataModel copyWith({
    List<Banner>? banners,
    List<Product>? products,
    String? ad,
  }) =>
      DataModel(
        banners: banners ?? this.banners,
        products: products ?? this.products,
        ad: ad ?? this.ad,
      );

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    banners: List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    ad: json["ad"],
  );

  Map<String, dynamic> toJson() => {
    "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "ad": ad,
  };
}

class Banner {
  Banner({
    required this.id,
    required this.image,
    required this.category,
    required this.product,
  });

  int id;
  String image;
  dynamic category;
  dynamic product;

  Banner copyWith({
    int? id,
    String? image,
    dynamic category,
    dynamic product,
  }) =>
      Banner(
        id: id ?? this.id,
        image: image ?? this.image,
        category: category ?? this.category,
        product: product ?? this.product,
      );

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    id: json["id"],
    image: json["image"],
    category: json["category"],
    product: json["product"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "category": category,
    "product": product,
  };
}

class Product {
  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.images,
    required this.inFavorites,
    required this.inCart,
  });

  int id;
  double price;
  double oldPrice;
  int discount;
  String image;
  String name;
  String description;
  List<String> images;
  bool inFavorites;
  bool inCart;

  Product copyWith({
    int? id,
    double? price,
    double? oldPrice,
    int? discount,
    String? image,
    String ?name,
    String? description,
    List<String>? images,
    bool? inFavorites,
    bool? inCart,
  }) =>
      Product(
        id: id ?? this.id,
        price: price ?? this.price,
        oldPrice: oldPrice ?? this.oldPrice,
        discount: discount ?? this.discount,
        image: image ?? this.image,
        name: name ?? this.name,
        description: description ?? this.description,
        images: images ?? this.images,
        inFavorites: inFavorites ?? this.inFavorites,
        inCart: inCart ?? this.inCart,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    price: json["price"].toDouble(),
    oldPrice: json["old_price"].toDouble(),
    discount: json["discount"],
    image: json["image"],
    name: json["name"],
    description: json["description"],
    images: List<String>.from(json["images"].map((x) => x)),
    inFavorites: json["in_favorites"],
    inCart: json["in_cart"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "old_price": oldPrice,
    "discount": discount,
    "image": image,
    "name": name,
    "description": description,
    "images": List<dynamic>.from(images.map((x) => x)),
    "in_favorites": inFavorites,
    "in_cart": inCart,
  };
}
