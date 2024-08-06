class ShopSearchModel {
  late bool status;
  late SearchDetailsModel data;

  ShopSearchModel.fromJson(Map<String, dynamic> model) {
    status = model['status'];
    data = SearchDetailsModel.fromJson(model['data']);
  }
}

class SearchDetailsModel {
  late List<SearchDataModel> data = [];

  SearchDetailsModel.fromJson(Map<String, dynamic> model) {
    for (var element in model['data']) {
      data.add(SearchDataModel.fromJson(element));
    }
  }
}

class SearchDataModel {
  late int id;
  late dynamic price;
  late String image, name;

  SearchDataModel.fromJson(Map<String, dynamic> model) {
    id = model['id'];
    price = model['price'];
    image = model['image'];
    name = model['name'];
  }
}
