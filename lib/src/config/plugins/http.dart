//^ Implementacion del paquete [Dio]

import 'package:dio/dio.dart';

class HttpAdapter{

  final Dio dio;
  final String baseUrl;
  final Map<String, dynamic>? queryParameters;

  HttpAdapter({
    required this.baseUrl,
    this.queryParameters, 
  }): dio = Dio( BaseOptions(
    baseUrl: baseUrl,
    queryParameters: queryParameters
  ) );

  /// Peticion Get
  Future<Response> get({required String path, Map<String, dynamic>? queryParameters}) async {
    try {
      Response res = await dio.get(path, queryParameters: queryParameters );
      return res;
    } catch (e) {
      throw ("ERROR: $e");
    }
    
  }
  

}