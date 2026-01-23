import 'package:flutter/material.dart';

class PaginationScrollScreen extends StatefulWidget {
  const PaginationScrollScreen({super.key});

  @override
  State<PaginationScrollScreen> createState() => _PaginationScrollScreenState();
}

class _PaginationScrollScreenState extends State<PaginationScrollScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Pagination Scroll")));
  }
}
