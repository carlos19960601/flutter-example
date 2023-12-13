import 'package:apidash/consts.dart';
import 'package:flutter/material.dart';

Color getHTTPMethodColor(HTTPVerb method,
    {Brightness brightness = Brightness.light}) {
  Color col;
  switch (method) {
    case HTTPVerb.get:
      col = kColorHttpMethodGet;
      break;
    case HTTPVerb.head:
      col = kColorHttpMethodHead;
      break;
    case HTTPVerb.post:
      col = kColorHttpMethodPost;
      break;
    case HTTPVerb.put:
      col = kColorHttpMethodPut;
      break;
    case HTTPVerb.patch:
      col = kColorHttpMethodPatch;
      break;
    case HTTPVerb.delete:
      col = kColorHttpMethodDelete;
      break;
  }
  return col;
}
