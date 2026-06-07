import 'package:dartz/dartz.dart';
import 'package:sms_gpt_app/core/errors/failures.dart';
import 'package:sms_gpt_app/features/students/domain/entities/student.dart';

abstract class StudentRepository {
  Future<Either<Failure, List<Student>>> getStudents();
  Future<Either<Failure, Student>> getStudentById(String id);
  Future<Either<Failure, Student>> createStudent(Student student);
  Future<Either<Failure, Student>> updateStudent(Student student);
  Future<Either<Failure, void>> deleteStudent(String id);
}