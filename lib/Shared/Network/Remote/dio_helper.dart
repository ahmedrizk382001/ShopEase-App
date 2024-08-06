import 'package:dio/dio.dart';
import 'package:shop_app/Shared/Components/constants.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> get(String method,
      {Map<String, dynamic>? query, String? token}) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token
    };
    return await dio.get(
      method,
      queryParameters: query,
    );
  }

  static Future<Response> post(String method, Map<String, dynamic> data,
      {Map<String, dynamic>? query, String? token}) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token
    };
    return await dio.post(
      method,
      data: data,
    );
  }

  static Future<Response> put(String method, Map<String, dynamic> data,
      {Map<String, dynamic>? query}) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return await dio.put(
      method,
      data: data,
    );
  }
}
