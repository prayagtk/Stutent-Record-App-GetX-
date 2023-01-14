//import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/database/db_functions.dart';
import 'package:student/database/db_model.dart';
import 'package:student/views/home.dart';
import 'package:student/views/student_details.dart';

class UpdateScreen extends StatefulWidget {
  final id;
  final name;
  final age;
  final rollNum;
  final address;
  String image;
  //-------------------------------------------Fetching Datas---------------------------------------------
  UpdateScreen(
      {required this.id,
      required this.name,
      required this.age,
      required this.rollNum,
      required this.address,
      required this.image,
      super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  //------------------------------------------------------------------------------------------------------
  final UpdateName = TextEditingController();
  final UpdateAge = TextEditingController();
  final UpdateRollNum = TextEditingController();
  final updateAddress = TextEditingController();

  ImagePicker imgpicker = ImagePicker();
  var imageFile;
  var checkPrevImage;
  var prevImage;

  @override
  Widget build(BuildContext context) {
//---------------------------------------Set Defaultvalue-------------------------------------------------
    UpdateName.text = widget.name;
    UpdateAge.text = widget.age;
    UpdateRollNum.text = widget.rollNum;
    updateAddress.text = widget.address;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      //backgroundColor: const Color.fromARGB(255, 187, 184, 184),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 78, 75, 75),
        //automaticallyImplyLeading: false,
        elevation: 10,
        title: Text('Update Student Details'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              //----------------------------------------------Text Details-----------------------------------------------------
              Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 80.0,
                    backgroundImage: widget.image !=
                            'https://www.inforwaves.com/media/2021/04/dummy-profile-pic-300x300-1.png'
                        ? FileImage(File(widget.image)) as ImageProvider
                        : const NetworkImage(
                            'https://www.inforwaves.com/media/2021/04/dummy-profile-pic-300x300-1.png'),
                  ),
                  Positioned(
                      bottom: 20.0,
                      right: 20.0,
                      child: IconButton(
                          onPressed: _onClick,
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.teal,
                          )))
                ],
              ),
//---------------------------------------------------------space------------------------------------------------------
              const SizedBox(
                height: 20,
              ),
              //-------------------------------------------------Student Details field-----------------------------------------------
              Container(
                width: double.infinity,
                height: 500,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      //------------------------------------------------------Name-----------------------------------------------------------
                      TextField(
                        onChanged: ((value) {}),
                        controller: UpdateName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '${widget.name}',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //------------------------------------------------------Age-----------------------------------------------------------
                      TextField(
                        onChanged: ((value) {}),
                        controller: UpdateAge,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '${widget.age}',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //------------------------------------------------------RollNum-----------------------------------------------------------
                      TextField(
                        onChanged: ((value) {}),
                        controller: UpdateRollNum,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '${widget.rollNum}',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //------------------------------------------------------Address-----------------------------------------------------------
                      TextField(
                        onChanged: ((value) {}),
                        controller: updateAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '${widget.address}',
                        ),
                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: 5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //-----------------------------------------------------Submit Button--------------------------------------------------
                      ElevatedButton.icon(
                          onPressed: () {
                            onClick(widget.id, context);
                            // Navigator.of(context).pushReplacement(
                            //     MaterialPageRoute(builder: (ctx) {
                            //   return HomeScreen();
                            // }));

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (ctx) => HomeScreen()),
                                (route) => false);
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('Submit')),
                      //-------------------------------------------------------Sizebox-----------------------------------------------------
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
///////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////Functions////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

//---------------------------------------------------------/onClick/------------------------------------------------------------
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
                            _updateImage(ImageSource.gallery);
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.folder),
                          tooltip: 'folder',
                        ),
                      ),
//-------------------------------------------------------Camera Option---------------------------------------------------------------
                      IconButton(
                        onPressed: () {
                          _updateImage(ImageSource.camera);
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

  //-----------------------------------------------------_updateImage-------------------------------------------------------
  Future<void> _updateImage(ImageSource src) async {
    XFile? updateImage = await imgpicker.pickImage(source: src);

    if (updateImage == null) {
      imageFile = studentListNotifier.value[widget.id].image.toString();
      checkPrevImage = '_prev_img';
      widget.image = imageFile;
    } else {
      setState(() {
        imageFile = updateImage.path;
        widget.image = imageFile.toString();
      });
    }
  }

//---------------------------------------------------------------------------------------------------------------------------
  Future<void> onClick(int id, BuildContext context) async {
    final updatedName = UpdateName.text.trim();
    final updatedAge = UpdateAge.text.trim();
    final updatedRollNo = UpdateRollNum.text.trim();
    final updatedAddress = updateAddress.text.trim();
    String updatedImage = imageFile.toString();
    prevImage = studentListNotifier.value[widget.id].image.toString();
    if (imageFile == null) {
      updatedImage = prevImage;
    }
    if (updatedName.isEmpty ||
        updatedAge.isEmpty ||
        updatedRollNo.isEmpty ||
        updatedAddress.isEmpty) {
      return;
    } else {
      final values = StudentTable(
          name: updatedName,
          age: updatedAge,
          rollnum: updatedRollNo,
          address: updatedAddress,
          image: updatedImage);
      updateStudent(values, widget.id);
    }
  }
}
