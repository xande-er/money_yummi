// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelUserAdapter extends TypeAdapter<ModelUser> {
  @override
  final int typeId = 1;

  @override
  ModelUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelUser(
      id: fields[0] as int,
      money: fields[1] as int,
      username: fields[2] as String,
      tokenAuth: fields[4] as String,
      device: fields[5] as String,
      photo: fields[6] as String,
      registrationDate: fields[7] as DateTime,
      confirmationEmail: fields[8] as bool,
      pass: fields[9] as String,
      email: fields[3] as String,
      notificationDevice: fields[11] as bool,
      notificationEmail: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ModelUser obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.money)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.tokenAuth)
      ..writeByte(5)
      ..write(obj.device)
      ..writeByte(6)
      ..write(obj.photo)
      ..writeByte(7)
      ..write(obj.registrationDate)
      ..writeByte(8)
      ..write(obj.confirmationEmail)
      ..writeByte(9)
      ..write(obj.pass)
      ..writeByte(10)
      ..write(obj.notificationEmail)
      ..writeByte(11)
      ..write(obj.notificationDevice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
