import 'package:flutter/material.dart';

class ShareDynamicPdfScreen extends StatefulWidget {
  const ShareDynamicPdfScreen({super.key});

  @override
  State<ShareDynamicPdfScreen> createState() => _ShareDynamicPdfScreenState();
}

class _ShareDynamicPdfScreenState extends State<ShareDynamicPdfScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Share PDF')),
    );
  }
}
