// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product()
      ..id = fields[0] as String
      ..Name = fields[1] as String
      ..Category = fields[2] as String
      ..Price = fields[3] as String
      ..Size = fields[4] as String
      ..Desc = fields[5] as String
      ..Short_Desc = fields[6] as String
      ..ImageUrl = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.Name)
      ..writeByte(2)
      ..write(obj.Category)
      ..writeByte(3)
      ..write(obj.Price)
      ..writeByte(4)
      ..write(obj.Size)
      ..writeByte(5)
      ..write(obj.Desc)
      ..writeByte(6)
      ..write(obj.Short_Desc)
      ..writeByte(7)
      ..write(obj.ImageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
