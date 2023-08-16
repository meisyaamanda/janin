import 'package:flutter/material.dart';
import 'package:janin/models/riwayat.dart';

class RiwayatCard extends StatelessWidget {
  final Function() onPressed;
  final RiwayatModel riwayatModel;
  const RiwayatCard({
    super.key,
    required this.onPressed,
    required this.riwayatModel,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
