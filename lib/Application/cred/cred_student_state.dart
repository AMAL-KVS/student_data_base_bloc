part of 'cred_student_cubit.dart';

@immutable
abstract class CrudCubitState extends Equatable {}

class CrudCubitInitial extends CrudCubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AllstudentState extends CrudCubitState {
  final List<StudentModel> studentsList;

  AllstudentState({required this.studentsList});

  @override
  List<Object> get props => [studentsList];
}

class ImageUpdateState extends CrudCubitState {
  final List<StudentModel> studentsList;
  final String? image;

  ImageUpdateState({required this.studentsList, this.image});

  @override
  List<Object> get props => [studentsList];
}

class NoResultState extends CrudCubitState {
  @override
  List<Object?> get props => [];
}
