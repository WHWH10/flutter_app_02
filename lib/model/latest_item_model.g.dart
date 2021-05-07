// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LatestItemModelAdapter extends TypeAdapter<LatestItemModel> {
  @override
  final int typeId = 0;

  @override
  LatestItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LatestItemModel(
      name: fields[0] as String,
      imageUrl: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LatestItemModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LatestItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
