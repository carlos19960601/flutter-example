// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountModelAdapter extends TypeAdapter<AccountModel> {
  @override
  final int typeId = 2;

  @override
  AccountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountModel(
      name: fields[0] as String?,
      bankName: fields[3] as String?,
      number: fields[4] as String?,
      cardType: fields[5] == null ? CardType.bank : fields[5] as CardType?,
      amount: fields[7] as double?,
      color: fields[8] == null ? 4294951175 : fields[8] as int?,
      isAccountExcluded: fields[1] == null ? false : fields[1] as bool?,
    )
      ..superId = fields[6] as int?
      ..isAccountDefault = fields[9] == null ? false : fields[9] as bool?;
  }

  @override
  void write(BinaryWriter writer, AccountModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.isAccountExcluded)
      ..writeByte(3)
      ..write(obj.bankName)
      ..writeByte(4)
      ..write(obj.number)
      ..writeByte(5)
      ..write(obj.cardType)
      ..writeByte(6)
      ..write(obj.superId)
      ..writeByte(7)
      ..write(obj.amount)
      ..writeByte(8)
      ..write(obj.color)
      ..writeByte(9)
      ..write(obj.isAccountDefault);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
