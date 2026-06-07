import 'package:dartz/dartz.dart';
import 'package:sms_gpt_app/core/errors/exceptions.dart';
import 'package:sms_gpt_app/core/errors/failures.dart';
import 'package:sms_gpt_app/features/students/data/datasources/student_local_datasource.dart';
import 'package:sms_gpt_app/features/students/data/datasources/student_remote_datasource.dart';
import 'package:sms_gpt_app/features/students/domain/entities/student.dart';
import 'package:sms_gpt_app/features/students/domain/repositories/student_repository.dart';

class StudentRepositoryImpl implements StudentRepository {
  final StudentRemoteDataSource remoteDataSource;
  final StudentLocalDataSource localDataSource;

  StudentRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Student>>> getStudents() async {
    try {
      final remoteStudents = await remoteDataSource.getStudents();
      await localDataSource.cacheStudents(remoteStudents);
      return Right(remoteStudents);
    } on ServerException catch (e) {
      try {
        final cachedStudents = await localDataSource.getCachedStudents();
        return Right(cachedStudents);
      } on CacheException {
        return Left(ServerFailure(e.message));
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, Student>> createStudent(Student student) {
    // TODO: implement createStudent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteStudent(String id) {
    // TODO: implement deleteStudent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Student>> getStudentById(String id) {
    // TODO: implement getStudentById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Student>> updateStudent(Student student) {
    // TODO: implement updateStudent
    throw UnimplementedError();
  }
}