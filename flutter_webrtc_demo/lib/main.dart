import 'package:flutter/material.dart';
import 'package:flutter_webrtc_demo/models/route_item.dart';
import 'package:flutter_webrtc_demo/pages/call_sample/view.dart';
import 'package:flutter_webrtc_demo/pages/date_channel_sample/view.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

enum DialogDemoAction {
  cancel,
  connect,
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _datachannel = false;
  final String _server = 'demo.cloudwebrtc.com';
  List<RouteItem> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      RouteItem(
          title: 'P2P Call Sample',
          subtitle: 'P2P Call Sample.',
          push: (BuildContext context) {
            _datachannel = false;
            _showAddressDialog(context);
          }),
      RouteItem(
          title: 'Data Channel Sample',
          subtitle: 'P2P Data Channel.',
          push: (BuildContext context) {
            _datachannel = true;
            _showAddressDialog(context);
          }),
    ];
  }

  void showDemoDialog<T>(
      {required BuildContext context, required Widget child}) {
    showDialog<T>(
      context: context,
      builder: (context) => child,
    ).then((T? value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        if (value == DialogDemoAction.connect) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => _datachannel
                      ? DataChannelSample(host: _server)
                      : CallSample(host: _server)));
        }
      }
    });
  }

  _showAddressDialog(context) {
    showDemoDialog<DialogDemoAction>(
        context: context,
        child: AlertDialog(
            title: const Text('Enter server address:'),
            content: TextField(
              onChanged: (String text) {},
              decoration: InputDecoration(
                hintText: _server,
              ),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context, DialogDemoAction.cancel);
                  }),
              TextButton(
                  child: const Text('CONNECT'),
                  onPressed: () {
                    Navigator.pop(context, DialogDemoAction.connect);
                  })
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter-WebRTC example'),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            // padding: const EdgeInsets.all(0.0),
            itemBuilder: (context, index) {
              return _buildRow(context, items[index]);
            }),
      ),
    );
  }

  _buildRow(BuildContext context, RouteItem item) {
    return Column(
      children: [
        ListTile(
          title: Text(item.title),
          onTap: () => item.push(context),
          trailing: const Icon(Icons.arrow_right),
        ),
        const Divider()
      ],
    );
  }
}
