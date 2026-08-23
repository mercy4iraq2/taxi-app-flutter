import 'package:dio/dio.dart';
import '../config/app_constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late Dio _dio;

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    _initializeDio();
  }

  void _initializeDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.apiBaseUrl,
        connectTimeout: const Duration(milliseconds: AppConstants.requestTimeout),
        receiveTimeout: const Duration(milliseconds: AppConstants.requestTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('Response: ${response.statusCode} ${response.path}');
          return handler.next(response);
        },
        onError: (error, handler) {
          print('Error: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }

  // GET Request
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      if (fromJson != null) {
        return fromJson(response.data);
      }
      return response.data as T;
    } catch (e) {
      rethrow;
    }
  }

  // POST Request
  Future<T> post<T>(
    String path, {
    dynamic data,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
      );
      if (fromJson != null) {
        return fromJson(response.data);
      }
      return response.data as T;
    } catch (e) {
      rethrow;
    }
  }

  // PUT Request
  Future<T> put<T>(
    String path, {
    dynamic data,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
      );
      if (fromJson != null) {
        return fromJson(response.data);
      }
      return response.data as T;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE Request
  Future<T> delete<T>(
    String path, {
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.delete(path);
      if (fromJson != null) {
        return fromJson(response.data);
      }
      return response.data as T;
    } catch (e) {
      rethrow;
    }
  }

  // Set Authorization Header
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Remove Authorization Header
  void removeAuthToken() {
    _dio.options.headers.remove('Authorization');
  }
}
