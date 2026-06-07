import 'package:hive/hive.dart';
import 'package:sms_gpt_app/core/errors/exceptions.dart';
import 'package:sms_gpt_app/features/students/data/models/student_model.dart';

abstract class StudentLocalDataSource {
  Future<void> cacheStudents(List<StudentModel> students);
  Future<List<StudentModel>> getCachedStudents();
}

class StudentLocalDataSourceImpl implements StudentLocalDataSource {
  final Box box;

  StudentLocalDataSourceImpl({required this.box});

  @override
  Future<void> cacheStudents(List<StudentModel> students) async {
    await box.put(
      'cached_students',
      students.map((s) => s.toJson()).toList(),
    );
  }

  @override
  Future<List<StudentModel>> getCachedStudents() async {
    final data = box.get('cached_students');

    if (data == null) {
      throw CacheException('No cached students found');
    }

    return (data as List)
        .map((e) => StudentModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}