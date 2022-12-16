import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_data_base/Application/cred/cred_student_cubit.dart';
import 'package:student_data_base/Application/search/search_bloc.dart';
import 'package:student_data_base/Application/searchIcon/search_icon_cubit.dart';
import 'package:student_data_base/constants/constants.dart';
import 'package:student_data_base/model/d_b_functions.dart';
import 'package:student_data_base/model/db_model.dart';
import 'package:student_data_base/presentation/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentModelAdapter());
  await Hive.openBox<StudentModel>(kBoxkey);
  runApp(MyApp(searchBloc: SearchBloc()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.searchBloc}) : super(key: key);
  final SearchBloc searchBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => CrudCubitCubit(
                  list: DBFunctions.getStudents(), searchBloc: searchBloc)),
          BlocProvider(create: (context) => searchBloc),
          BlocProvider(create: (context) => SearchIconCubit())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme:
              new ThemeData(primaryColor: Color.fromARGB(255, 255, 255, 255)),
          home: HomeScreen(),
        ));
  }
}
