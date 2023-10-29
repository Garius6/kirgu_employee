import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kirgu_employee/src/constants.dart';
import 'package:kirgu_employee/src/user/token.dart';
import 'package:kirgu_employee/src/user/user_provider.dart';
import 'package:kirgu_employee/src/wta_event/wta_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wta_event_provider.g.dart';

@riverpod
Future<List<WtaEvent>> wtaEventList(WtaEventListRef ref) async {
  final user = await ref.watch(userRepositoryProvider.future);
  final token = ref.watch(tokenProvider);
  final response = await Dio(BaseOptions(
          responseType: ResponseType.plain,
          headers: {"Authorization": "Bearer $token"}))
      .get("$baseUrl/users/${user!.id}/events/");
  final events = (jsonDecode(response.data) as List)
      .map((e) => WtaEvent.fromJson(e))
      .toList();

  return events;
}
