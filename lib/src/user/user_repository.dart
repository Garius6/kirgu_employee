import 'package:dio/dio.dart';
import 'package:kirgu_employee/src/user/user.dart';
import 'package:kirgu_employee/src/constants.dart';

class UserRepository {
  UserRepository();

  final dio = Dio();

  String _token = "";

  bool get isLogged => (_token == "");

  Future<User?> signIn(String username, String password) async {
    final formData = FormData.fromMap({
      'username': username,
      'password': password,
    });
    final response = await dio.post("$BASE_URL/login", data: formData);
    print(response.data);
    return null;
  }
}
