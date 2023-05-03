import 'dart:async';

import 'package:web_socket_channel/io.dart';

class WebSocketService {
  static const String _baseUrl = 'ws://139.59.44.53:3005?phone=7452976914';
  static final WebSocketService _instance = WebSocketService._();
  IOWebSocketChannel? _channel;
  StreamController<String>? _streamController;

  WebSocketService._();

  factory WebSocketService() {
    return _instance;
  }

  Stream<String> get stream {
    if (_streamController == null) {
      _streamController = StreamController<String>.broadcast();
      _connect();
    }
    return _streamController!.stream;
  }

  void _connect() {
    _channel = IOWebSocketChannel.connect(_baseUrl);
    _channel!.stream.listen(
          (message) {
        _streamController!.add(message);
      },
      onError: (error) {
        print('WebSocket error: $error');
        _channel?.sink.close();
        _streamController?.close();
        _streamController = null;
        _connect();
      },
      onDone: () {
        print('WebSocket done');
        _channel?.sink.close();
        _streamController?.close();
        _streamController = null;
        _connect();
      },
    );
  }

  void send(String message) {
    if (_channel != null) {
      _channel!.sink.add(message);
    }
  }
}
