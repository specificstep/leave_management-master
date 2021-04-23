import 'package:dio/dio.dart';
import '../AllApiCall/ApiConstants.dart';

class NetworkUtil {
  Dio _dio;

  NetworkUtil() {
    ///Create Dio Object using baseOptions set receiveTimeout,connectTimeout
    BaseOptions options =
        BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    options.baseUrl = ApiConstants.BASE_URL;
    _dio = Dio(options);
    _dio.interceptors.add(LogInterceptor());
  }

  ///used for calling Get Request
  Future<Response> get(String url, Map<String, dynamic> params) async {
    Response response = await _dio.get(url,
        queryParameters: params,
        options: Options(responseType: ResponseType.json));
    return response;
  }

  ///used for calling post Request
  Future<Response> post(String url, Map<String, dynamic> params) async {
    Response response = await _dio.post(url,
        data: params, options: Options(
            contentType: "application/x-www-form-urlencoded",
            responseType: ResponseType.json));
    return response;
  }
  Future<Response> post2(String url, FormData params) async {
    Response response = await _dio.post(url,
        data: params, options: Options(
            contentType: "multipart/form-data",
            responseType: ResponseType.json));
    return response;
  }
}
