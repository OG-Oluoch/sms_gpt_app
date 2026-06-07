import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sms_gpt_app/core/network/api_client.dart';

final s1 = GetIt.instance;

Future<void> init() async {
  //external
  s1.registerLazySingleton<Dio>(()=>Dio());

  //core
  s1.registerLazySingleton<ApiClient>(()=>ApiClient(s1()));

  // register Dio
  // register Hive boxes
  // register data sources
  // register repositories
  // register use cases
  // register blocs
}
