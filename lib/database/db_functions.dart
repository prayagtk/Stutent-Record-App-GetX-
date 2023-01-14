import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student/database/db_model.dart';

ValueNotifier<List<StudentTable>> studentListNotifier =
    ValueNotifier([]); //get Database

//-------------------------------------------Adding the value into Database-----------------------------------------------
Future<void> addStudentTable(StudentTable value) async {
  final studentDatabase = await Hive.openBox<StudentTable>('student_database');
  final id = await studentDatabase.add(value);
  value.id = id; //this id assigning a
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

//-------------------------------------------For getting the database-------------------------------------------------------
Future<void> getStudentTable() async {
  final studentDatabase = await Hive.openBox<StudentTable>('student_database');
  studentListNotifier.value.clear();

  studentListNotifier.value.addAll(studentDatabase.values);
  studentListNotifier.notifyListeners();
}

//--------------------------------------------------Update------------------------------------------------------------------
Future<void> updateStudent(StudentTable values, int id) async {
  final studentDatabase = await Hive.openBox<StudentTable>('student_database');
  final table_key = studentDatabase.keys;
  final element_key = table_key.elementAt(id);
  studentDatabase.put(element_key, values);
  studentListNotifier.notifyListeners();
  getStudentTable();
}

//--------------------------------------------------Delete-------------------------------------------------------------------
Future<void> deleteStudent(int id) async {
  final studentDatabase = await Hive.openBox<StudentTable>('student_database');
  studentDatabase.deleteAt(id);
  //studentListNotifier.notifyListeners();
  getStudentTable();
}
