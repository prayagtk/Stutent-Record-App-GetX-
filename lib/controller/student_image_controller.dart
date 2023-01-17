import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/database/db_model.dart';
import 'package:student/main.dart';

class StudentController extends GetxController {
  var studentList = <StudentTable>[].obs;

  final ImagePicker imgPicker = ImagePicker();

  File? imagefile;

  Future<void> getGallery(var src) async {
    XFile? file =
        await imgPicker.pickImage(source: src, maxHeight: 200, maxWidth: 200);

    imagefile = File(file!.path);

    update();
  }

  Future<void> getCamera(var src) async {
    XFile? file =
        await imgPicker.pickImage(source: src, maxHeight: 200, maxWidth: 200);
    imagefile = File(file!.path);
    update();
  }

  addStudent(StudentTable studentDetails) {
    studentdb.add(studentDetails);
    studentList.add(studentDetails);
    update();
  }
}
