import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kirgu_employee/src/wta_event/wta_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wta_event_provider.g.dart';

/// This will create a provider named `activityProvider`
/// which will cache the result of this function.
@riverpod
Future<List<WtaEvent>> wtaEventList(WtaEventListRef ref) async {
  // Using package:http, we fetch a random activity from the Bored API.
  final response = await Dio(BaseOptions(responseType: ResponseType.plain))
      .get("http://192.168.1.111:8000/users/1/events/");
  // Using dart:convert, we then decode the JSON payload into a Map data structure.
  final events = (jsonDecode(response.data) as List)
      .map((e) => WtaEvent.fromJson(e))
      .toList();

  return events;
}
