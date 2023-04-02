// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleAdapter extends TypeAdapter<Schedule> {
  @override
  final int typeId = 1;

  @override
  Schedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Schedule(
      isCyclicalSchedule: fields[0] as bool,
      schedule: (fields[1] as List).cast<Lesson>(),
      scheduleInfo: fields[2] as ScheduleInfo,
    );
  }

  @override
  void write(BinaryWriter writer, Schedule obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj._isCyclicalSchedule)
      ..writeByte(1)
      ..write(obj._schedule)
      ..writeByte(2)
      ..write(obj._scheduleInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ScheduleInfoAdapter extends TypeAdapter<ScheduleInfo> {
  @override
  final int typeId = 2;

  @override
  ScheduleInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleInfo(
      group: fields[0] as ScheduleGroup,
      teacher: fields[1] as ScheduleTeacher,
      auditory: fields[2] as ScheduleAuditory,
      year: fields[3] as String,
      weekNumber: fields[4] as int,
      semesterNumber: fields[5] as int,
      date: fields[6] as DateTime,
      lastDate: fields[7] as DateTime,
      uploadDateTime: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleInfo obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj._group)
      ..writeByte(1)
      ..write(obj._teacher)
      ..writeByte(2)
      ..write(obj._auditory)
      ..writeByte(3)
      ..write(obj._year)
      ..writeByte(4)
      ..write(obj._weekNumber)
      ..writeByte(5)
      ..write(obj._semesterNumber)
      ..writeByte(6)
      ..write(obj._date)
      ..writeByte(7)
      ..write(obj._lastDate)
      ..writeByte(8)
      ..write(obj._uploadDateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ScheduleGroupAdapter extends TypeAdapter<ScheduleGroup> {
  @override
  final int typeId = 3;

  @override
  ScheduleGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleGroup(
      name: fields[0] as String,
      groupId: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleGroup obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._groupId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ScheduleTeacherAdapter extends TypeAdapter<ScheduleTeacher> {
  @override
  final int typeId = 5;

  @override
  ScheduleTeacher read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleTeacher(
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleTeacher obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj._name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleTeacherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ScheduleAuditoryAdapter extends TypeAdapter<ScheduleAuditory> {
  @override
  final int typeId = 6;

  @override
  ScheduleAuditory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleAuditory(
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleAuditory obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj._name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleAuditoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
