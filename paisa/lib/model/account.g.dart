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
    return AccountModel()
      ..amount = fields[0] as double?
      ..bankName = fields[1] as String?
      ..cardType = fields[2] == null ? CardType.bank : fields[2] as CardType?
      ..color = fields[3] == null ? 4294951175 : fields[3] as int?
      ..isAccountExcluded = fields[4] == null ? false : fields[4] as bool?
      ..name = fields[5] as String?
      ..number = fields[6] as String?;
  }

  @override
  void write(BinaryWriter writer, AccountModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.bankName)
      ..writeByte(2)
      ..write(obj.cardType)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.isAccountExcluded)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.number);
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
