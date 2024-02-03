import 'package:flutter/material.dart';

class FindPatientPage extends StatelessWidget {
  const FindPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FindPatientPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FindPatientPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
