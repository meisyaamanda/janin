import 'package:flutter/material.dart';
import 'package:janin/services/prediksiservices.dart';

class Riwayat extends StatelessWidget {
  Riwayat({super.key});

  PrediksiService prediksiService = PrediksiService();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Riwayat'),
        )
      ),
    );
  }
}