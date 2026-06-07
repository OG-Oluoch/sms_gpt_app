import 'package:dio/dio.dart';
import 'package:sms_gpt_app/core/errors/exceptions.dart';
import 'package:sms_gpt_app/features/students/data/models/student_model.dart';

abstract class StudentRemoteDataSource {
  Future<List<StudentModel>> getStudents();
}

class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
  final Dio dio;

  StudentRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<StudentModel>> getStudents() async {
    try {
      final response = await dio.get('/students');

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((e) => StudentModel.fromJson(e)).toList();
      } else {
        throw ServerException('Failed to load students');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error');
    } catch (e) {
      throw ServerException('Unexpected error');
    }
  }
}