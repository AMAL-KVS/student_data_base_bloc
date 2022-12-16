// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:student_data_base/Application/cred/cred_student_cubit.dart';
import 'package:student_data_base/model/d_b_functions.dart';
import 'package:student_data_base/model/db_model.dart';
import 'package:student_data_base/widgets/image_picker_widget.dart';

class EditScreen extends StatelessWidget {
  // final List<StudentDb> list;
  final int index;
  final StudentModel student;
  EditScreen({
    Key? key,
    required this.index,
    required this.student,
  }) : super(key: key);

  //  StudentDb student = DBFunction.getStudent(index);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: student.name);
    TextEditingController ageController =
        TextEditingController(text: student.age.toString());
    TextEditingController placeController =
        TextEditingController(text: student.location);
    TextEditingController qualificationController =
        TextEditingController(text: student.qualificcation);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
        elevation: 10,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (student.imagepath != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.file(
                      File(student.imagepath!),
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                      labelText: "Name",
                      hintText: 'Name',
                      enabledBorder: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                      labelText: 'Age',
                      hintText: 'Age',
                      enabledBorder: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: placeController,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                      labelText: "Place",
                      hintText: 'Place',
                      enabledBorder: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: qualificationController,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                      labelText: "Qualification",
                      hintText: 'Qualification',
                      enabledBorder: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          ImagePickerWidget.getimage(
                              source: ImageSource.gallery);
                        },
                        //  getImage(source: ImageSource.gallery),
                        child: const Text('Select New Image')),
                    ElevatedButton(
                        onPressed: () {
                          ImagePickerWidget.getimage(
                              source: ImageSource.camera);
                        },
                        child: const Text('Take New Image')),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      StudentModel student = StudentModel(
                        name: nameController.text,
                        age: ageController.text,
                        location: placeController.text,
                        qualificcation: qualificationController.text,
                        imagepath: imagepath,
                      );
                      BlocProvider.of<CrudCubitCubit>(context)
                          .editStudentListUpdate(
                              DBFunctions.getbox(), student, index);

                      Navigator.pop(context);
                    },
                    child: const Text('Submit changes'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
