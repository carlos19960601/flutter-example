import 'dart:convert';
import 'dart:io';
import 'dart:math';

class SimpleWebSocket {
  final String _url;
  var _socket;
  Function()? onOpen;
  Function(dynamic msg)? onMessage;
  Function(int? code, String? reaso)? onClose;

  SimpleWebSocket(this._url);

  connect() async {
    _socket = await _connectForSelfSignedCert(_url);
    onOpen?.call();

    _socket.listen((data) {
      onMessage?.call(data);
    }, onDone: () {
      onClose?.call(_socket.closeCode, _socket.closeReason);
    });
  }

  send(data) {
    if (_socket != null) {
      _socket.add(data);
      print('send: $data');
    }
  }

  close() {
    if (_socket != null) _socket.close();
  }

  Future<WebSocket> _connectForSelfSignedCert(url) async {
    Random r = Random();
    String key = base64.encode(List<int>.generate(8, (_) => r.nextInt(255)));
    HttpClient client = HttpClient(context: SecurityContext());
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) {
      print('SimpleWebSocket: Allow self-signed certificate => $host:$port. ');
      return true;
    };

    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.add('Connection', 'Upgrade');
    request.headers.add('Upgrade', 'websocket');
    request.headers
        .add('Sec-WebSocket-Version', '13'); // insert the correct version here
    request.headers.add('Sec-WebSocket-Key', key.toLowerCase());

    HttpClientResponse response = await request.close();
    // ignore: close_sinks
    Socket socket = await response.detachSocket();
    var webSocket = WebSocket.fromUpgradedSocket(
      socket,
      protocol: 'signaling',
      serverSide: false,
    );

    return webSocket;
  }
}
