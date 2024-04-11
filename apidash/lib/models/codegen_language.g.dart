// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'codegen_language.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CodegenLanguageAdapter extends TypeAdapter<CodegenLanguage> {
  @override
  final int typeId = 0;

  @override
  CodegenLanguage read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return CodegenLanguage.curl;
      case 2:
        return CodegenLanguage.har;
      case 3:
        return CodegenLanguage.dartHttp;
      case 4:
        return CodegenLanguage.dartDio;
      case 5:
        return CodegenLanguage.goHttp;
      case 6:
        return CodegenLanguage.jsAxios;
      case 7:
        return CodegenLanguage.jsFetch;
      case 8:
        return CodegenLanguage.nodejsAxios;
      case 9:
        return CodegenLanguage.nodejsFetch;
      case 10:
        return CodegenLanguage.kotlinOkHttp;
      case 11:
        return CodegenLanguage.pythonHttpClient;
      case 12:
        return CodegenLanguage.pythonRequests;
      case 13:
        return CodegenLanguage.rustActix;
      case 14:
        return CodegenLanguage.rustReqwest;
      case 15:
        return CodegenLanguage.rustUreq;
      default:
        return CodegenLanguage.curl;
    }
  }

  @override
  void write(BinaryWriter writer, CodegenLanguage obj) {
    switch (obj) {
      case CodegenLanguage.curl:
        writer.writeByte(1);
        break;
      case CodegenLanguage.har:
        writer.writeByte(2);
        break;
      case CodegenLanguage.dartHttp:
        writer.writeByte(3);
        break;
      case CodegenLanguage.dartDio:
        writer.writeByte(4);
        break;
      case CodegenLanguage.goHttp:
        writer.writeByte(5);
        break;
      case CodegenLanguage.jsAxios:
        writer.writeByte(6);
        break;
      case CodegenLanguage.jsFetch:
        writer.writeByte(7);
        break;
      case CodegenLanguage.nodejsAxios:
        writer.writeByte(8);
        break;
      case CodegenLanguage.nodejsFetch:
        writer.writeByte(9);
        break;
      case CodegenLanguage.kotlinOkHttp:
        writer.writeByte(10);
        break;
      case CodegenLanguage.pythonHttpClient:
        writer.writeByte(11);
        break;
      case CodegenLanguage.pythonRequests:
        writer.writeByte(12);
        break;
      case CodegenLanguage.rustActix:
        writer.writeByte(13);
        break;
      case CodegenLanguage.rustReqwest:
        writer.writeByte(14);
        break;
      case CodegenLanguage.rustUreq:
        writer.writeByte(15);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CodegenLanguageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
