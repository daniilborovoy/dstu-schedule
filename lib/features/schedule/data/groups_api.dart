import 'package:dio/dio.dart';
import 'package:dstu_schedule/common/http_client.dart';

class GroupsApi {
  const GroupsApi();

  Future<Response<Map<String, dynamic>>> fetchGroupInfo(int groupId) {
    return httpClient.get("/UserInfo/GroupInfo", queryParameters: {
      "groupID": groupId,
    });
  }
}
