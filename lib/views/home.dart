import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student/controller/student_image_controller.dart';
import 'package:student/database/db_functions.dart';
import 'package:student/database/db_model.dart';
import 'package:student/views/add_student_screen.dart';
import 'package:student/views/student_details.dart';

final getxController = Get.put(StudentController());

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getStudentTable();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 78, 75, 75),
        elevation: 10,
        title: const Text(
          'Student Details',
          style: TextStyle(fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchStudents());
              },
              icon: Icon(Icons.search))
        ],
        //centerTitle: true,

        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        //color: const Color.fromARGB(255, 187, 184, 184),
//----------------------------------------------------Student ListView--------------------------------------------------------
        child: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (BuildContext context, List<StudentTable> studentList,
              Widget? child) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  final data = studentList[index];
                  return ListTile(
//----------------------------------------------------------Name--------------------------------------------------------------
                    title: Text(data.name),
//----------------------------------------------------------Age---------------------------------------------------------------
                    subtitle: Text(data.age),
//--------------------------------------------------------Display Picture-----------------------------------------------------
                    leading: CircleAvatar(
                      radius: 32,
                      backgroundImage: data.image !=
                              'https://www.inforwaves.com/media/2021/04/dummy-profile-pic-300x300-1.png'
                          ? FileImage(File(data.image)) as ImageProvider
                          : NetworkImage(
                              'https://www.inforwaves.com/media/2021/04/dummy-profile-pic-300x300-1.png'),
                    ),
//---------------------------------------------------------Delete Button-------------------------------------------------------------
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: const Center(
                                  child: Text(
                                    'Delete',
                                  ),
                                ),
                                content: const Text(
                                  'Are you sure?',
                                  textAlign: TextAlign.center,
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deleteStudent(index);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            });
                      },
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    ),
//--------------------------------------------------------On Tap(List)--------------------------------------------------------
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return StudentDetails(
                          id: index,
                          name: data.name,
                          age: data.age,
                          rollNo: data.rollnum,
                          address: data.address,
                          image: data.image,
                        );
                      }));
                    },
                  );
                },
//----------------------------------------------------------------------------------------------------------------------------
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Color.fromARGB(255, 78, 75, 75),
                    thickness: 1.0,
                  );
                },
                itemCount: studentList.length);
          },
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          //   return AddStudentDetails();
          // }));
          Get.to(() => AddStudentDetails());
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}

class SearchStudents extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final studentList = query.isEmpty
        ? studentListNotifier.value
        : studentListNotifier.value
            .where((element) => element.name
                .toLowerCase()
                .startsWith(query.toLowerCase().toString()))
            .toList();

    return studentList.isEmpty
        ? const Center(child: Text("No Data Found!"))
        : ListView.builder(
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              final dtatas = studentList[index];
              var img = dtatas.image;
              return Padding(
                  padding: const EdgeInsets.only(left: 15.00, right: 15.00),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 32,
                          backgroundImage: img !=
                                  'https://www.inforwaves.com/media/2021/04/dummy-profile-pic-300x300-1.png'
                              ? FileImage(File(img)) as ImageProvider
                              : NetworkImage(
                                  'https://www.inforwaves.com/media/2021/04/dummy-profile-pic-300x300-1.png'),
                        ),
                        title: Text(studentList[index].name),
                        subtitle: Text(
                            "Age : ${(studentList[index].age.toString())}"),
                        onTap: () {
                          final data = studentList[index];
                          //int? id = studentListNotifier.value[index];
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => StudentDetails(
                                    id: data.id,
                                    name: data.name,
                                    age: data.age,
                                    rollNo: data.rollnum,
                                    address: data.address,
                                    image: data.image,
                                  )));
                        },
                      ),
                      const Divider(
                        thickness: 3,
                        color: Colors.grey,
                      ),
                    ],
                  ));
            });
  }
}
