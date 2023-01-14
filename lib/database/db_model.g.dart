// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentTableAdapter extends TypeAdapter<StudentTable> {
  @override
  final int typeId = 1;

  @override
  StudentTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentTable(
      name: fields[1] as String,
      age: fields[2] as String,
      rollnum: fields[3] as String,
      address: fields[4] as String,
      image: fields[5] as String,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, StudentTable obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.rollnum)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
