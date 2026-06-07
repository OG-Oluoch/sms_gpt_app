import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_gpt_app/features/students/domain/usecases/get_students.dart';
import 'package:sms_gpt_app/features/students/presentation/bloc/student_event.dart';
import 'package:sms_gpt_app/features/students/presentation/bloc/student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final GetStudents getStudents;

  StudentBloc({required this.getStudents}) : super(StudentInitial()) {
    on<LoadStudents>((event, emit) async {
      emit(StudentLoading());

      final result = await getStudents();

      result.fold(
        (failure) => emit(StudentError(failure.message)),
        (students) => emit(StudentLoaded(students)),
      );
    });
  }
}