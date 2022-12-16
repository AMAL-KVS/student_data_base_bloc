import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_data_base/Application/cred/cred_student_cubit.dart';
import 'package:student_data_base/Application/search/search_bloc.dart';
import 'package:student_data_base/Application/searchIcon/search_icon_cubit.dart';
import 'package:student_data_base/model/d_b_functions.dart';
import 'package:student_data_base/model/db_model.dart';
import 'package:student_data_base/presentation/Add_students/add_students.dart';
import 'package:student_data_base/presentation/Edit/edit.dart';
import 'package:student_data_base/presentation/view/Student_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  IconData? myIcon;
  Widget customSearchBar = const Text('Student Record');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: BlocBuilder<SearchIconCubit, SearchIconState>(
          builder: (context, state) {
            myIcon = state.props[0] as IconData;
            return AppBar(
              title: customSearchBar,
              centerTitle: true,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<SearchIconCubit>().changeIcon(myIcon!);
                    if (myIcon == Icons.search) {
                      customSearchBar = TextField(
                        onChanged: (value) {
                          context
                              .read<SearchBloc>()
                              .add(InputEvent(searchInput: value));
                        },
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          hintText: 'Search here',
                        ),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      );
                    } else {
                      context.read<SearchBloc>().add(ClearInputEvent());
                      customSearchBar = const Text('Student Record');
                    }
                  },
                  icon: Icon(myIcon),
                ),
              ],
            );
          },
        ),
      ),
      body: BlocBuilder<CrudCubitCubit, CrudCubitState>(
        builder: (context, state) {
          if (state is AllstudentState) {
            if (state.studentsList.isEmpty) {
              return const Center(
                child: Text('Empty Student List'),
              );
            } else {
              final List<StudentModel> data = state.studentsList;
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox.fromSize(
                    size: Size(0, 4),
                  );
                },
                itemBuilder: (context, index) {
                  // Student? data = value.getAt(index);
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ViewScreen(
                              index: data[index].key,
                            );
                          }));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        title: Text(data[index].name),
                        leading: data[index].imagepath == null
                            ? const CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/117-1176594_student-learning-education-college-student-vector-png-transparent.png'),
                                radius: 25,
                              )
                            : CircleAvatar(
                                radius: 25,
                                child: ClipOval(
                                  child: Image.file(
                                    File(data[index].imagepath!),
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           EditStudent(obj: data, index: index))),

                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return EditScreen(
                                    index: data[index].key,
                                    student: data[index],
                                  );
                                }));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.grey,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Are you sure? '),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('No')),
                                          TextButton(
                                              onPressed: () {
                                                context
                                                    .read<CrudCubitCubit>()
                                                    .deleteStudentListUpdate(
                                                        DBFunctions.getbox(),
                                                        data[index].key);
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Yes'))
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red.shade300,
                              ),
                            ),
                          ],
                        )),
                  );
                },

                itemCount: data.length,
                // separatorBuilder: Divider(),
              );
            }
          } else if (state is NoResultState) {
            return const Center(
              child: Text('No Result found'),
            );
          } else {
            return const Center(
              child: Text('Error while getting data'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddScreen()));
        },
      ),
    );
  }
}
