import 'package:flutter/material.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PatientPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PatientPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}