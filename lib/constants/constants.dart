import 'package:hive/hive.dart';
import 'package:student_data_base/model/db_model.dart';

const kBoxkey = 'student';

final box = Hive.box<StudentModel>(kBoxkey);

const String kimage =
    'https://himhaldia.edu.in/wp-content/uploads/2017/10/graduate-student-avatar.png';
