import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper
{
  static late Dio dio;

  static init()
  {
    dio=Dio(
      BaseOptions(
        baseUrl: 'http://gradproj.atwebpages.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response>getData({
    required String url,
    Map<String , dynamic>? query,
    String lang='en',
    String? token,
  })async
  {
    dio.options.headers=
    {
      'Content-Type' : 'application/json',
    };
    return await dio.get(url,queryParameters:
    query,);
  }


  static Future<Response> postData({
    required url,
    required Map<String,dynamic>data
  })async
  {
    dio.options.headers=
    {
      'Content-Type' : 'application/json',
    };

    return await dio.post(
        url,
        data: data
    );

  }

  static Future<Response> putData({
    required String url,
    Map<String ,dynamic>?query,
    required Map<String ,dynamic>data,
    String lang='en',
    String? token,

  }) async
  {
    dio.options.headers=
    {
      'lang' : lang,
      'Authorization' : token
    };
    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
