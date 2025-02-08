// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenEntityAdapter extends TypeAdapter<TokenEntity> {
  @override
  final int typeId = 1;

  @override
  TokenEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TokenEntity(
      tokenType: fields[0] as String,
      accessToken: fields[1] as String,
      refreshToken: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TokenEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.tokenType)
      ..writeByte(1)
      ..write(obj.accessToken)
      ..writeByte(2)
      ..write(obj.refreshToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
