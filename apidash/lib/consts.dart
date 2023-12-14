import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kColorSchemeSeed = Colors.blue;
final kFontFamily = GoogleFonts.openSans().fontFamily;
const kHintOpacity = 0.6;

const kP1 = EdgeInsets.all(1);
const kP5 = EdgeInsets.all(5);
const kP8 = EdgeInsets.all(8);
const kPs8 = EdgeInsets.only(left: 8);
const kPh20v5 = EdgeInsets.symmetric(horizontal: 20, vertical: 5);
const kPh20v10 = EdgeInsets.symmetric(horizontal: 20, vertical: 10);
const kP10 = EdgeInsets.all(10);
const kPt24o8 = EdgeInsets.only(top: 24, left: 8.0, right: 8.0, bottom: 8.0);
const kPt5o10 =
    EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 10.0);
const kPh20t40 = EdgeInsets.only(
  left: 20,
  right: 20,
  top: 40,
);
const kPh60 = EdgeInsets.symmetric(horizontal: 60);
const kP24CollectionPane = EdgeInsets.only(top: 24, left: 8.0, bottom: 8.0);
const kP8CollectionPane = EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0);
const kPr8CollectionPane = EdgeInsets.only(right: 8.0);

const kHSpacer4 = SizedBox(width: 4);
const kHSpacer5 = SizedBox(width: 5);
const kHSpacer10 = SizedBox(width: 10);
const kHSpacer20 = SizedBox(width: 20);
const kVSpacer5 = SizedBox(height: 5);
const kVSpacer8 = SizedBox(height: 8);
const kVSpacer10 = SizedBox(height: 10);
const kVSpacer20 = SizedBox(height: 20);

const kLabelPlusNew = "+ New";
const kLabelSend = "Send";
const kLabelSending = "Sending..";
const kLabelBusy = "Busy";
const kLabelCopy = "Copy";
const kLabelSave = "Save";
const kLabelDownload = "Download";

const kTextStyleButton = TextStyle(fontWeight: FontWeight.bold);

enum RequestItemMenuOption { edit, delete, duplicate }

enum HTTPVerb { get, head, post, put, patch, delete }

enum ContentType { json, text }

const kBorderRadius8 = BorderRadius.all(Radius.circular(8));
final kBorderRadius10 = BorderRadius.circular(10);
const kBorderRadius12 = BorderRadius.all(Radius.circular(12));

final kColorStatusCodeDefault = Colors.grey.shade700;
final kColorStatusCode200 = Colors.green.shade800;
final kColorStatusCode300 = Colors.blue.shade800;
final kColorStatusCode400 = Colors.red.shade800;
final kColorStatusCode500 = Colors.amber.shade900;
const kOpacityDarkModeBlend = 0.4;

final kColorHttpMethodGet = Colors.green.shade800;
final kColorHttpMethodHead = kColorHttpMethodGet;
final kColorHttpMethodPost = Colors.blue.shade800;
final kColorHttpMethodPut = Colors.amber.shade900;
final kColorHttpMethodPatch = kColorHttpMethodPut;
final kColorHttpMethodDelete = Colors.red.shade800;

const kDefaultHttpMethod = HTTPVerb.get;
const kDefaultContentType = ContentType.json;
