import 'package:dio/dio.dart';
import 'package:shop_app/Shared/CashHelper/CashHelper.dart';

class DioHelper {
  static Dio? dio;

  static inti() {
    dio = Dio( BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true ,
    ));
  }

  static Future<Response> GetDate({
    required String path,
    String? token
  }) async {
    dio!.options.headers = {
      "Content-Type" :"application/json",
      "lang":"en",
      "Authorization" :token ,} ;
    return await dio!.get(
        path,
    );
  }

  static Future<Response> PostDate({
    required String path,
    required Map <String ,dynamic> data,
    String? token
  }) async {

    dio!.options.headers = {
      "Content-Type" :"application/json",
      "lang":"en" ,
      "Authorization" :token  ,} ;
    return await dio!.post(path,data:  data);

  }

  static Future<Response> PutDate({
    required String path,
    required Map <String ,dynamic> data,
    String? token
  }) async {
    dio!.options.headers = {
      "Content-Type" :"application/json",
      "lang":"en" ,
      "Authorization" :token  ,} ;
    return await dio!.put(path , data: data);

  }

}
