import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:student_data_base/constants/constants.dart';
import 'package:student_data_base/model/db_model.dart';

class DBFunctions {
  static Box<StudentModel> getbox() {
    return box;
  }

  static List<StudentModel> getStudents() {
    final List<StudentModel> studentlist = box.values.toList();
    return studentlist;
  }

  static void addstudent(StudentModel student) {
    box.add(student);
  }

  static StudentModel getstudebt(int Key) {
    StudentModel student = box.get(Key)!;
    return student;
  }

  static int updatestudent(StudentModel student, int key) {
    box.put(key, student);
    return key;
  }

  static int deletestudent(int key) {
    box.delete(key);
    return key;
  }
}
