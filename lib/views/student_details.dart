import 'dart:io';

import 'package:flutter/material.dart';

import 'package:student/views/update_student_table.dart';

class StudentDetails extends StatelessWidget {
  final int? id;
  final String name;
  final String age;
  final String rollNo;
  final String address;
  final String image;
  const StudentDetails(
      {required this.id,
      required this.name,
      required this.age,
      required this.rollNo,
      required this.address,
      required this.image,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 187, 184, 184),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 78, 75, 75),
        automaticallyImplyLeading: false,
        elevation: 10,
        //title: Text('Student Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
//----------------------------------------space between  AppBar and Text(Details)-----------------------------------------
              const SizedBox(
                height: 30,
              ),
//--------------------------------------------------------Title Image-------------------------------------------------------
              CircleAvatar(
                  radius: 80.0,
                  backgroundImage: image !=
                          'https://www.inforwaves.com/media/2021/04/dummy-profile-pic-300x300-1.png'
                      ? FileImage(File(image)) as ImageProvider
                      : NetworkImage(
                          'https://www.inforwaves.com/media/2021/04/dummy-profile-pic-300x300-1.png')),
//---------------------------------------space between Title Text and Container--------------------------------------------
              const SizedBox(
                height: 30,
              ),
//---------------------------------------space between Title Text and Container--------------------------------------------
              const SizedBox(
                height: 30,
              ),
//------------------------------------------------------Container----------------------------------------------------------
              Container(
                  //color: const Color.fromARGB(255, 187, 184, 184),
                  width: double.infinity,
                  //height: double.infinity,
//--------------------------------------------------Student Details----------------------------------------------------------
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
//-------------------------------------------------------Name------------------------------------------------------------------
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 70),
                            child: Text(
                              'Name',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Text(
                            ':$name',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
//-----------------------------------------------------Space-------------------------------------------------------------------
                      const SizedBox(
                        height: 20,
                      ),
//------------------------------------------------------Age--------------------------------------------------------------------
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 90),
                            child: Text(
                              'Age',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Text(
                            ':$age',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
//-----------------------------------------------------Space-------------------------------------------------------------------
                      const SizedBox(
                        height: 20,
                      ),
//------------------------------------------------------Roll Number--------------------------------------------------------------------
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 55),
                            child: Text(
                              'Roll No.',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Text(
                            ':$rollNo',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
//-----------------------------------------------------Space-------------------------------------------------------------------
                      const SizedBox(
                        height: 20,
                      ),
//------------------------------------------------------Address--------------------------------------------------------------------
                      const Text(
                        'Address :',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        address,
                        style: const TextStyle(fontSize: 20),
                      ),
//-------------------------------------------------------------space-----------------------------------------------------------
                      const SizedBox(
                        height: 50,
                      ),
//----------------------------------------------------------Edit Button---------------------------------------------------------
                      Padding(
                        padding: const EdgeInsets.only(left: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 180),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel')),
                            ),
                            ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (ctx) {
                                    return UpdateScreen(
                                      id: id,
                                      name: name,
                                      age: age,
                                      rollNum: rollNo,
                                      address: address,
                                      image: image,
                                    );
                                  }));
                                },
                                icon: const Icon(Icons.edit),
                                label: const Text('Edit')),
                          ],
                        ),
                      ),
//----------------------------------------------------------space-----------------------------------------------------------------
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
