

import 'package:dio/dio.dart';

Dio dio(){

  Dio dio = new Dio();
  //dio.options.baseUrl = "http://127.0.0.1/arsipdian/public/api";
  dio.options.baseUrl = "http://10.0.2.2/arsipdian/public/api";

  dio.options.headers['accept'] = 'Application/Json';

  return dio;
}