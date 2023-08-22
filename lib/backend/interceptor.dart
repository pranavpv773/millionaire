import 'dart:developer';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log("❌🌍❌ Error [${err.response?.statusCode}] => ${err.requestOptions.path} | Details: ${err.response?.data}");

    final isInvalidUser = err.response?.statusCode == 401 &&
        err.response?.data['error'].toString().toLowerCase() == "invalid user";

    // if (isInvalidUser && kIsWeb && Get.currentRoute != AppRoutes.login) {
    //   // AppPref().clear();
    //   // auth.signOut();
    //   // Get.offAllNamed(AppRoutes.login);

    //   handler.resolve(
    //       Response(statusCode: 200, requestOptions: err.requestOptions));
    // }
    handler.next(err);
  }
}
