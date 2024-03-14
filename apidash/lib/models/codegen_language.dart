import 'package:hive_flutter/hive_flutter.dart';

part 'codegen_language.g.dart';

@HiveType(typeId: 0)
enum CodegenLanguage {
  @HiveField(1)
  curl("cURL", "bash", "curl"),
  @HiveField(2)
  har("HAR", "json", "har"),
  @HiveField(3)
  dartHttp("Dart (http)", "dart", "dart"),
  @HiveField(4)
  dartDio("Dart (dio)", "dart", "dart"),
  @HiveField(5)
  goHttp("Go (http)", "go", "go"),
  @HiveField(6)
  jsAxios("JavaScript (axios)", "javascript", "js"),
  @HiveField(7)
  jsFetch("JavaScript (fetch)", "javascript", "js"),
  @HiveField(8)
  nodejsAxios("node.js (axios)", "javascript", "js"),
  @HiveField(9)
  nodejsFetch("node.js (fetch)", "javascript", "js"),
  @HiveField(10)
  kotlinOkHttp("Kotlin (okhttp3)", "java", "kt"),
  @HiveField(11)
  pythonHttpClient("Python (http.client)", "python", "py"),
  @HiveField(12)
  pythonRequests("Python (requests)", "python", "py"),
  @HiveField(13)
  rustActix("Rust (Actix Client)", "rust", "rs"),
  @HiveField(14)
  rustReqwest("Rust (reqwest)", "rust", "rs"),
  @HiveField(15)
  rustUreq("Rust (ureq)", "rust", "rs");

  const CodegenLanguage(this.label, this.codeHighlightLang, this.ext);
  final String label;
  final String codeHighlightLang;
  final String ext;
}
