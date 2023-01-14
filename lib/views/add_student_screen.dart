import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:student/database/db_functions.dart';
import 'package:student/database/db_model.dart';

class AddStudentDetails extends StatefulWidget {
  AddStudentDetails({super.key});

  @override
  State<AddStudentDetails> createState() => _AddStudentDetailsState();
}

class _AddStudentDetailsState extends State<AddStudentDetails> {
  final nameController = TextEditingController();

  final ageController = TextEditingController();

  final rollNumController = TextEditingController();

  final addressController = TextEditingController();

  final rollnumController = TextEditingController();

  final addressControler = TextEditingController();

  File? imagefile;
  final ImagePicker imgPicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      //backgroundColor: const Color.fromARGB(255, 187, 184, 184),
      //appBar: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 78, 75, 75),
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
//-------------------------------------------------------Title-----------------------------------------------------------------------
            const Center(
                child: Text(
              'Enter Student Details',
              style: TextStyle(fontSize: 20, color: Colors.black),
            )),
            const SizedBox(
              height: 20,
            ),
//------------------------------------------------------Image---------------------------------------------------------------
            Stack(
              children: <Widget>[
                CircleAvatar(
                    radius: 80.0,
                    backgroundColor: Colors.grey,
                    backgroundImage: imagefile != null
                        ? FileImage(File(imagefile!.path)) as ImageProvider
                        : NetworkImage(
                            'https://www.inforwaves.com/media/2021/04/dummy-profile-pic-300x300-1.png')
//-------------------------------------Position widget for placing bottom icon over the image-------------------------------
                    ),
                Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: IconButton(
                        onPressed: _onClick,
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.teal,
                        )))
              ],
            ),

//-------------------------------------------------------space------------------------------------------------------------------
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 450,
              color: Colors.white,
              child: Padding(
//-------------------------------------------Padding of TextFormField-------------------------------------------------------
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
//------------------------------------------------TextFormField(NAME)--------------------------------------------------------
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Name',
                      ),
                    ),
//-------------------------------------------------------Divider-------------------------------------------------------------
                    const SizedBox(height: 20),
//---------------------------------------------------TextFormField(Age)------------------------------------------------------
                    TextFormField(
                      controller: ageController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Age'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
//-------------------------------------------------------Divider-------------------------------------------------------------
                    const SizedBox(height: 20),
//---------------------------------------------------TextFormField(Roll No.)------------------------------------------------------
                    TextFormField(
                      controller: rollNumController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Roll No.'),
                      keyboardType: TextInputType.number,
                    ),
//-------------------------------------------------------Divider-------------------------------------------------------------
                    const SizedBox(height: 20),
//------------------------------------------------TextFormField(Address)--------------------------------------------------------
                    TextFormField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Address',
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 2,
                      maxLines: 5,
                    ),
//-------------------------------------------------------Divider-------------------------------------------------------------
                    const SizedBox(height: 20),
//----------------------------------------------------SubmitButton-----------------------------------------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // submitButtonClicked(context);
                            // Navigator.of(context).pop();
                            Get.back();
                          },
                          child: const Text('Submit'),
                        ),
//---------------------------------------------------------------------------------------------------------------------------
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

//------------------------------------------------------Submint Button Fuunction---------------------------------------------
  Future<void> submitButtonClicked(BuildContext context) async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final rollNo = rollNumController.text.trim();
    final address = addressController.text.trim();
    String image;
    if (imagefile != null) {
      image = imagefile!.path.toString();
    } else {
      image =
          'https://www.inforwaves.com/media/2021/04/dummy-profile-pic-300x300-1.png';
    }
    if (name.isEmpty || age.isEmpty || rollNo.isEmpty || address.isEmpty) {
      return;
    } else {
//-----------------------------------------------Adding datas into database-----------------------------------------
      final student = StudentTable(
          name: name,
          age: age,
          rollnum: rollNo,
          address: address,
          image: image);

      addStudentTable(student);
    }
  }

//-------------------------------------------------------BottomSheet-----------------------------------------------------------
  Future<void> _onClick() async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
//-------------------------------------------------------Bottom Sheet Title--------------------------------------------------------
                  const Text(
                    'Profile photo',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
//-------------------------------------------------------Folder Option---------------------------------------------------------------
                        child: IconButton(
                          onPressed: () {
                            _getImageGallary(ImageSource.gallery);
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.folder),
                          tooltip: 'folder',
                        ),
                      ),
//-------------------------------------------------------Camera Option---------------------------------------------------------------
                      IconButton(
                        onPressed: () {
                          _getImageGallary(ImageSource.camera);
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.camera),
                        tooltip: 'camera',
                      )
//-----------------------------------------------------------------------------------------------------------------------------------
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

//------------------------------------------------------------------------------------------------------------------------------------
  Future<void> _getImageGallary(ImageSource src) async {
    XFile? file =
        await imgPicker.pickImage(source: src, maxHeight: 200, maxWidth: 200);
    if (file != null) {
      setState(() {
        imagefile = File(file.path);
      });
    }
  }
}
