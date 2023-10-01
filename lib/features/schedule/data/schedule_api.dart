import 'package:dio/dio.dart';
import 'package:dstu_schedule/common/http_client.dart';

class ScheduleApi {
  const ScheduleApi();

  Future<Response<dynamic>> fetchListOfAllGroups() {
    return httpClient.get('/raspGrouplist');
  }

  Future<Response<dynamic>> fetchScheduleAtDate(int groupId, DateTime date) {
    final String formattedDate = '${date.year}-${date.month}-${date.day}';
    return httpClient.get('/Rasp', queryParameters: {
      'idGroup': groupId,
      'sdate': formattedDate,
    });
  }
}
