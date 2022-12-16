import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_data_base/Application/cred/cred_student_cubit.dart';
import 'package:student_data_base/constants/constants.dart';
import 'package:student_data_base/model/d_b_functions.dart';
import 'package:student_data_base/model/db_model.dart';
import 'package:student_data_base/widgets/image_picker_widget.dart';

class AddScreen extends StatelessWidget {
  AddScreen({
    Key? key,
  }) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Student'),
      ),
      body: BlocBuilder<CrudCubitCubit, CrudCubitState>(
        builder: (context, state) {
          return Form(
            // key: widget.formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  imagepath == null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            kimage,
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.file(
                            File(imagepath!),
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        ImagePickerWidget.getimage(source: ImageSource.gallery);
                      },
                      child: const Text('Select Image')),
                  ElevatedButton(
                      onPressed: () {
                        ImagePickerWidget.getimage(source: ImageSource.camera);
                      },
                      child: const Text('Take an Image')),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                      style: const TextStyle(fontSize: 16),
                      controller: nameController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        labelText: 'Name',
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 16),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        labelText: 'Age',
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: placeController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      labelText: 'Place',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: qualificationController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      labelText: 'qualification',
                    ),
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
                            .addStudentListUpdate(
                                DBFunctions.getbox(), student);
                        Navigator.pop(context);
                      },
                      child: const Text('SAVE'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
