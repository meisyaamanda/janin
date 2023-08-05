import 'package:flutter/material.dart';

import '../../theme.dart';

class PrediksiForm extends StatefulWidget {
  const PrediksiForm({super.key});

  @override
  State<PrediksiForm> createState() => _PrediksiFormState();
}

class _PrediksiFormState extends State<PrediksiForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: blackColor,
          ),
        ),
        title: Text('Buat Prediksi', style: appBarStyle,),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Text('Form Prediksi'),
        ),
      ),
    );
  }
}
