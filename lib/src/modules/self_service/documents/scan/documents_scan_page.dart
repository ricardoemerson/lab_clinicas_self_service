import 'package:flutter/material.dart';

class DocumentsScanPage extends StatelessWidget {
  const DocumentsScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DocumentsScanPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DocumentsScanPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
