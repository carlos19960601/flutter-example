import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc_demo/common/signaling.dart';

class CallSample extends StatefulWidget {
  const CallSample({super.key, required this.host});

  final String host;
  @override
  State<CallSample> createState() => _CallSampleState();
}

class _CallSampleState extends State<CallSample> {
  String? _selfId;
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  final bool _inCalling = false;
  Signaling? _signaling;

  @override
  void initState() {
    super.initState();
    initRenderers();
    _connect(context);
  }

  initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  void _connect(BuildContext context) async {
    _signaling ??= Signaling(widget.host, context)..connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'P2P Call Sample${_selfId != null ? ' [Your ID ($_selfId)] ' : ''}'),
        actions: const <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: null,
            tooltip: 'setup',
          ),
        ],
      ),
    );
  }
}
