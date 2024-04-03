// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imc_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImcModelAdapter extends TypeAdapter<ImcModel> {
  @override
  final int typeId = 1;

  @override
  ImcModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImcModel()
      .._peso = fields[1] as double
      .._altura = fields[2] as double
      .._imc = fields[3] as double
      .._classificacaoIMC = fields[4] as String
      ..horario = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, ImcModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._peso)
      ..writeByte(2)
      ..write(obj._altura)
      ..writeByte(3)
      ..write(obj._imc)
      ..writeByte(4)
      ..write(obj._classificacaoIMC)
      ..writeByte(5)
      ..write(obj.horario);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImcModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
