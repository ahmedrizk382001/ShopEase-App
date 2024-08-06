class ShopBannersModel {
  late bool status;
  late List<BannersDataModel> data = [];

  ShopBannersModel.fromJson(Map<String, dynamic> model) {
    status = model['status'];
    for (var element in model['data']) {
      data.add(BannersDataModel.fromJson(element));
    }
  }
}

class BannersDataModel {
  late int id;
  late String image;

  BannersDataModel.fromJson(Map<String, dynamic> model) {
    id = model['id'];
    image = model['image'];
  }
}
