import 'package:flutter/material.dart';

class DocumentsScanConfirmPage extends StatelessWidget {
  const DocumentsScanConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DocumentsScanConfirmPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DocumentsScanConfirmPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
