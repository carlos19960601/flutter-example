import 'package:apidash/consts.dart';
import 'package:apidash/models/name_value_model.dart';
import 'package:apidash/utils/convert.dart';
import 'package:collection/collection.dart';

String getRequestTitleFromUrl(String? url) {
  if (url == null || url.trim() == "") {
    return "untitled";
  }
  if (url.contains("://")) {
    String rem = url.split("://")[1];
    if (rem.trim() == "") {
      return "untitled";
    }
    return rem;
  }
  return url;
}

(Uri?, String?) getValidRequestUri(
    String? url, List<NameValueModel>? requestParams,
    {String defaultUriScheme = kDefaultUriScheme}) {
  url = url?.trim();
  if (url == null || url == "") {
    return (null, "URL is missing!");
  }

  Uri? uri = Uri.tryParse(url);
  if (uri == null) {
    return (null, "Check URL (malformed)");
  }

  (String?, bool) urlSchema = getUriSchema(uri);
  if (urlSchema.$1 != null) {
    if (!urlSchema.$2) {
      return (null, "Unsupported URL Scheme (${urlSchema.$1})");
    }
  } else {
    url = "$defaultUriScheme://$url";
  }

  uri = Uri.parse(url);
  if (uri.hasFragment) {
    uri.removeFragment();
  }

  Map<String, String>? queryParams = rowsToMap(requestParams);
  if (queryParams != null) {
    if (uri.hasQuery) {
      Map<String, String> urlQueryParams = uri.queryParameters;
      queryParams = mergeMaps(urlQueryParams, queryParams);
    }
    uri = uri.replace(queryParameters: queryParams);
  }
  return (uri, null);
}

(String?, bool) getUriSchema(Uri uri) {
  if (uri.hasScheme) {
    if (kSupportedUriSchemes.contains(uri.scheme)) {
      return (uri.scheme, true);
    }
    return (uri.scheme, false);
  }

  return (null, false);
}
