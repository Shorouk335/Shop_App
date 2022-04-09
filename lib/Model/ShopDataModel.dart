class ShopDataModel {
  bool? status;
  Data? data;
  ShopDataModel.fromJson(Map<String, dynamic> shopdata) {
    status = shopdata["status"];
    data = Data.fromJson(shopdata["data"]);
  }
}

class Data {
  List <Banners> banners = [];
  List <Products> products = [];
  Data.fromJson(Map<String, dynamic> data) {
    data["banners"].forEach((element) {
      banners.add(Banners.fromJson(element));
    });
    data["products"].forEach((element) {
      products.add(Products.fromJson(element));
    });
  }
}

class Banners {
  dynamic id;
  String? image;
  Banners.fromJson(Map<String, dynamic> bannerdata) {
    id = bannerdata["id"];
    image = bannerdata["image"];
  }
}

class Products {
  dynamic id;
  String? name ;
  dynamic price;
  dynamic old_price ;
  String? image;
  String? description;
  dynamic discount;
  bool? in_favorites;
  bool? in_cart;


  Products.fromJson(Map<String, dynamic> productsdata) {
    id = productsdata["id"];
    name = productsdata["name"];
    price = productsdata["price"];
    old_price = productsdata["old_price"];
    image = productsdata["image"];
    description = productsdata["description"];
    discount = productsdata["discount"];
    in_favorites = productsdata["in_favorites"];
    in_cart = productsdata["in_cart"];
  }
}
