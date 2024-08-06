class ShopChangeFavoritesModel {
  late bool status;
  late String message;

  ShopChangeFavoritesModel.fromJson(Map<String, dynamic> model) {
    status = model['status'];
    message = model['message'];
  }
}

class ShopFavoritesModel {
  late bool status;
  late FavoritesDetailsModel data;

  ShopFavoritesModel.fromJson(Map<String, dynamic> model) {
    status = model['status'];
    data = FavoritesDetailsModel.fromJson(model['data']);
  }
}

class FavoritesDetailsModel {
  late List<FavoritesDataModel> data = [];

  FavoritesDetailsModel.fromJson(Map<String, dynamic> model) {
    for (var element in model['data']) {
      data.add(FavoritesDataModel.fromJson(element));
    }
  }
}

class FavoritesDataModel {
  late int id;
  late FavoritesProductsDataModel products;

  FavoritesDataModel.fromJson(Map<String, dynamic> model) {
    id = model['id'];
    products = FavoritesProductsDataModel.fromJson(model['product']);
  }
}

class FavoritesProductsDataModel {
  late int id;
  late dynamic price, oldPrice, discount;
  late String image, name;

  FavoritesProductsDataModel.fromJson(Map<String, dynamic> model) {
    id = model['id'];
    price = model['price'];
    oldPrice = model['old_price'];
    discount = model['discount'];
    image = model['image'];
    name = model['name'];
  }
}
