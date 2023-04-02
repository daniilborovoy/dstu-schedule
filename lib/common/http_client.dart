import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = dotenv.env['API_BASE_URL']!;

final httpClient = Dio(BaseOptions(
  baseUrl: baseUrl,
));
