import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../self_service_controller.dart';

class DonePage extends StatelessWidget {
  final selfServiceController = Injector.get<SelfServiceController>();

  DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            width: sizeOf.width * .8,
            margin: const EdgeInsets.only(top: 98),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.orangeColor),
            ),
            child: Column(
              children: [
                Image.asset('assets/images/stroke_check.png'),
                const SizedBox(height: 24),
                const Text(
                  'Sua senha é',
                  style: AppTheme.titleSmallStyle,
                ),
                const SizedBox(height: 24),
                Container(
                  width: 218,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.orangeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      selfServiceController.password,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text.rich(
                  TextSpan(
                    style: TextStyle(
                      color: AppTheme.blueColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(text: 'AGUARDE!\n'),
                      TextSpan(text: 'Sua senha será chamada no painel'),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('IMPRIMIR SENHA'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('ENVIAR SENHA VIA SMS'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selfServiceController.restartProcess,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.orangeColor,
                    ),
                    child: const Text('FINALIZAR'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
