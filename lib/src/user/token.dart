import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token.g.dart';

@riverpod
class Token extends _$Token {
  @override
  String build() {
    return "";
  }

  void setToken(String token) {
    state = token;
  }
}
