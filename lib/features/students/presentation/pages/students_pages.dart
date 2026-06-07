import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_gpt_app/features/students/presentation/bloc/student_bloc.dart';
import 'package:sms_gpt_app/features/students/presentation/bloc/student_event.dart';
import 'package:sms_gpt_app/features/students/presentation/bloc/student_state.dart';

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Students')),
      body: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          if (state is StudentLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is StudentError) {
            return Center(child: Text(state.message));
          }

          if (state is StudentLoaded) {
            return ListView.builder(
              itemCount: state.students.length,
              itemBuilder: (context, index) {
                final student = state.students[index];
                return ListTile(
                  title: Text('${student.firstName} ${student.lastName}'),
                  subtitle: Text(student.admissionNumber),
                );
              },
            );
          }

          return const Center(child: Text('No students loaded'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<StudentBloc>().add(LoadStudents());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}