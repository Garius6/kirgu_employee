import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:kirgu_employee/src/constants.dart';
import 'package:kirgu_employee/src/user/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
class UserRepository extends _$UserRepository {
  @override
  FutureOr<User?> build() async {
    return null;
  }

  Future<void> signIn(String username, String password) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      return await _fetchUser(username, password);
    });
  }

  Future<User> _fetchUser(String username, String password) async {
    final formData = FormData.fromMap({
      'username': username,
      'password': password,
    });
    final dio = Dio(BaseOptions(responseType: ResponseType.plain));
    final response = await dio.post("$baseUrl/login", data: formData);
    final tokenJson = jsonDecode(response.data);
    var parts = tokenJson["access_token"].split('.');
    var decoded = B64urlEncRfc7515.decodeUtf8(parts[1]);
    var tokenSub = jsonDecode(decoded)["sub"];
    return User(tokenSub["username"], tokenSub["id"]);
  }
}