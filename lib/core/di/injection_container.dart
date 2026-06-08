import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:sms_gpt_app/core/network/api_client.dart';
import 'package:sms_gpt_app/features/students/data/datasources/student_local_datasource.dart';
import 'package:sms_gpt_app/features/students/data/datasources/student_remote_datasource.dart';
import 'package:sms_gpt_app/features/students/data/repositories/student_repo_imp.dart';
import 'package:sms_gpt_app/features/students/domain/repositories/student_repository.dart';
import 'package:sms_gpt_app/features/students/domain/usecases/get_students.dart';
import 'package:sms_gpt_app/features/students/presentation/bloc/student_bloc.dart';

final s1 = GetIt.instance;

Future<void> init() async {
  // External
  s1.registerLazySingleton<Dio>(() => Dio());
  s1.registerLazySingleton<Box>(() => Hive.box('appBox'));

  // Core
  s1.registerLazySingleton<ApiClient>(() => ApiClient(s1()));

  // Students
  s1.registerLazySingleton<StudentRemoteDataSource>(
    () => StudentRemoteDataSourceImpl(dio: s1()),
  );
  s1.registerLazySingleton<StudentLocalDataSource>(
    () => StudentLocalDataSourceImpl(box: s1()),
  );
  s1.registerLazySingleton<StudentRepository>(
    () => StudentRepositoryImpl(
      remoteDataSource: s1(),
      localDataSource: s1(),
    ),
  );
  s1.registerLazySingleton(() => GetStudents(s1()));
  s1.registerFactory(() => StudentBloc(getStudents: s1()));
}
