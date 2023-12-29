class Signaling {
  Signaling(this._host, this._context);

  final BuildContext? _context;
  final _host;

  final Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'url': 'stun:stun.l.google.com:19302'},
      /*
       * turn server configuration example.
      {
        'url': 'turn:123.45.67.89:3478',
        'username': 'change_to_real_user',
        'credential': 'change_to_real_secret'
      },
      */
    ]
  };

  Future<void> connect() async {
    var url = 'https://$_host:$_port/ws';
    _socket = SimpleWebSocket(url);
    
  }
}
