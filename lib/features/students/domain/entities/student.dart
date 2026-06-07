import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String admissionNumber;

  const Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.admissionNumber,
  });

  @override
  List<Object?> get props => [id, firstName, lastName,admissionNumber];
}