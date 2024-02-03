import 'package:flutter/material.dart';

class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DonePage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DonePage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
