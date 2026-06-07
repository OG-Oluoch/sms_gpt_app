import 'package:dartz/dartz.dart';
import 'package:sms_gpt_app/core/errors/failures.dart';
import 'package:sms_gpt_app/features/students/domain/entities/student.dart';
import 'package:sms_gpt_app/features/students/domain/repositories/student_repository.dart';

class GetStudents {
  final StudentRepository repository;

  GetStudents(this.repository);

  Future<Either<Failure, List<Student>>> call() {
    return repository.getStudents();
  }
}