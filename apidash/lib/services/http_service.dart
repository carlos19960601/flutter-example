import 'package:apidash/consts.dart';
import 'package:apidash/models/request_model.dart';
import 'package:apidash/utils/http.dart';
import 'package:http/http.dart' as http;

Future<(http.Response?, Duration?, String?)> request(RequestModel requestModel,
    {String defaultUriScheme = kDefaultUriScheme}) async {
  (Uri?, String?) uriRec = getValidRequestUri(
    requestModel.url,
    requestModel.requestParams,
    defaultUriScheme: defaultUriScheme,
  );

  if (uriRec.$1 != null) {
    Uri requestUrl = uriRec.$1!;
    
  }

  return (null, null, uriRec.$2);
}
