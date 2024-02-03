import 'package:flutter/material.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DocumentsPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DocumentsPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
