import 'package:btl_iot/api/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

class ConfigDI {
  static final ConfigDI _singleton = ConfigDI._internal();

  factory ConfigDI() {
    return _singleton;
  }

  ConfigDI._internal() {
    // Đăng ký ApiResponse với đối tượng Client
    injector.registerFactory<ApiResponse>(() => ApiResponse(injector.get<http.Client>()));

    // Đăng ký http.Client
    injector.registerFactory<http.Client>(() => http.Client());
  }

  GetIt injector = GetIt.instance;
}