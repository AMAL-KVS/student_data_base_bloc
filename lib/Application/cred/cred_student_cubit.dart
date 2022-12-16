import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:student_data_base/Application/search/search_bloc.dart';
import 'package:student_data_base/model/d_b_functions.dart';
import 'package:student_data_base/model/db_model.dart';

part 'cred_student_state.dart';

class CrudCubitCubit extends Cubit<CrudCubitState> {
  final List<StudentModel> list;
  late StreamSubscription streamSubscription;
  final SearchBloc searchBloc;

  CrudCubitCubit({required this.list, required this.searchBloc})
      : super(CrudCubitInitial()) {
    emit(AllstudentState(studentsList: list));
    streamSubscription = searchBloc.stream.listen((state) {
      if (state is SearchResultState) {
        if (state.studentlist.isNotEmpty) {
          studentslistUpdate(state.studentlist);
        } else {
          emit(NoResultState());
        }
      }
    });
  }

  void studentslistUpdate(List<StudentModel> list) {
    emit(AllstudentState(studentsList: list));
  }

  void addStudentListUpdate(Box<StudentModel> box, StudentModel student) {
    DBFunctions.addstudent(student);
    emit(AllstudentState(studentsList: box.values.toList()));
  }

  void editStudentListUpdate(
      Box<StudentModel> box, StudentModel student, int key) {
    DBFunctions.updatestudent(student, key);
    emit(AllstudentState(studentsList: box.values.toList()));
  }

  void deleteStudentListUpdate(Box<StudentModel> box, int key) {
    DBFunctions.deletestudent(key);
    emit(AllstudentState(studentsList: box.values.toList()));
  }
}
