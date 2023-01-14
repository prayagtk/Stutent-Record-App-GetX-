import 'package:hive_flutter/hive_flutter.dart';
part 'db_model.g.dart';

@HiveType(typeId: 1)
class StudentTable {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String rollnum;

  @HiveField(4)
  final String address;

  @HiveField(5)
  final String image;

  StudentTable(
      {required this.name,
      required this.age,
      required this.rollnum,
      required this.address,
      required this.image,
      this.id});
}
