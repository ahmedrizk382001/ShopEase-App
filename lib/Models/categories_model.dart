class ShopCategoriesModel {
  late bool status;
  late CategoriesDetailsModel data;

  ShopCategoriesModel.fromJson(Map<String, dynamic> model) {
    status = model['status'];
    data = CategoriesDetailsModel.fromJson(model['data']);
  }
}

class CategoriesDetailsModel {
  late List<CategoriesDataModel> data = [];

  CategoriesDetailsModel.fromJson(Map<String, dynamic> model) {
    for (var element in model['data']) {
      data.add(CategoriesDataModel.fromJson(element));
    }
  }
}

class CategoriesDataModel {
  late int id;
  late String name, image;

  CategoriesDataModel.fromJson(Map<String, dynamic> model) {
    id = model['id'];
    name = model['name'];
    image = model['image'];
  }
}
