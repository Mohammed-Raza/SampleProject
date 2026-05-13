import 'package:flutter/material.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/features/presentation/widgets/responsive_page.dart';
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
    return ResponsivePage(
      title: context.l10n.webSocket,
      maxWidth: 760,
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: context.l10n.sendMessage,
        child: const Icon(Icons.send),
      ),
      child: Column(
        spacing: 18,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ResponsiveHeroPanel(
            icon: Icons.hub_outlined,
            title: context.l10n.webSocket,
            description: context.l10n.webSocketDescription,
          ),
          ResponsivePanel(
            child: Column(
              spacing: 18,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: context.l10n.sendAMessage,
                      prefixIcon: const Icon(Icons.chat_bubble_outline),
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: _channel.stream,
                  builder: (context, snapshot) {
                    return Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(minHeight: 110),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                      child: Text(
                        snapshot.hasData ? '${snapshot.data}' : '',
                        style: context.titleMedium,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
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
