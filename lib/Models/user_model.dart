class ShopUserModel {
  late bool status;
  late String message;
  UserDataModel? data;

  ShopUserModel.fromJson(Map<String, dynamic> model) {
    status = model['status'];
    message = model['message'] ?? '';
    data = model['data'] != null ? UserDataModel.fromJson(model['data']) : null;
  }
}

class UserDataModel {
  late int id;
  late String name, email, phone, token;

  UserDataModel.fromJson(Map<String, dynamic> model) {
    id = model['id'];
    name = model['name'];
    email = model['email'];
    phone = model['phone'];
    token = model['token'];
  }
}
