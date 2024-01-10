import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc_demo/common/random_string.dart';
import 'package:flutter_webrtc_demo/utils/device_info.dart';
import 'package:flutter_webrtc_demo/utils/websocket.dart';

class Signaling {
  Signaling(this._host, this._context);

  final String _selfId = randomNumeric(6);
  SimpleWebSocket? _socket;
  final BuildContext? _context;
  final _host;
  final _port = 8086;

  final JsonEncoder _encoder = const JsonEncoder();
  final JsonDecoder _decoder = const JsonDecoder();

  final Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'url': 'stun:stun.l.google.com:19302'},
    ]
  };

  Future<void> connect() async {
    var url = 'https://$_host:$_port/ws';
    _socket = SimpleWebSocket(url);

    _socket?.onOpen = () {
      _send('new', {
        'name': DeviceInfo.label,
        'id': _selfId,
        'user_agent': DeviceInfo.userAgent
      });
    };

    _socket?.onMessage = (message) {
      print('Received data: ' + message);
      onMessage(_decoder.convert(message));
    };

    await _socket?.connect();
  }

  void onMessage(message) async {
    Map<String, dynamic> mapData = message;
    var data = mapData['data'];
    switch (mapData['type']) {}
  }

  _send(event, data) {
    var request = {};
    request["type"] = event;
    request["data"] = data;
    _socket?.send(_encoder.convert(request));
  }
}
