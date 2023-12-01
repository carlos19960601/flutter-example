import 'package:blackhole/http/init.dart';

class SaavnHttp {
  static Future<dynamic> searchVocabulary({required String keyword}) async {
    var res = await Request().get(
      Api.vocabularySearch,
      data: {'keyword': keyword},
    );

    return ApiResponse(
      status: true,
      data: res.data["data"]
          .map<VocabularyModel>((v) => VocabularyModel.fromJson(v))
          .toList(),
    );
  }
}
