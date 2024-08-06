class ShopProductsModel {
  late bool status;
  late ProductsDetailsModel data;

  ShopProductsModel.fromJson(Map<String, dynamic> model) {
    status = model['status'];
    data = ProductsDetailsModel.fromJson(model['data']);
  }
}

class ProductsDetailsModel {
  late List<ProductsDataModel> data = [];

  ProductsDetailsModel.fromJson(Map<String, dynamic> model) {
    for (var element in model['data']) {
      data.add(ProductsDataModel.fromJson(element));
    }
  }
}

class ProductsDataModel {
  late int id;
  late dynamic price, oldPrice, discount;
  late String image, name;
  late bool inFavorites, inCart;

  ProductsDataModel.fromJson(Map<String, dynamic> model) {
    id = model['id'];
    price = model['price'];
    oldPrice = model['old_price'];
    discount = model['discount'];
    image = model['image'];
    name = model['name'];
    inFavorites = model['in_favorites'];
    inCart = model['in_cart'];
  }
}
