import 'package:flutter/material.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketMainScreen extends StatefulWidget {
  const WebSocketMainScreen({super.key});

  @override
  State<WebSocketMainScreen> createState() => _WebSocketMainScreenState();
}

class _WebSocketMainScreenState extends State<WebSocketMainScreen> {
  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://ws.ifelse.io'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.webSocket)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration:
                    InputDecoration(labelText: context.l10n.sendAMessage),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: context.l10n.sendMessage,
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
