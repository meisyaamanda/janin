import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../theme.dart';

class PrediksiForm extends StatefulWidget {
  const PrediksiForm({super.key});

  @override
  State<PrediksiForm> createState() => _PrediksiFormState();
}

class _PrediksiFormState extends State<PrediksiForm> {
  final TextEditingController accelerationsController = TextEditingController();
  final TextEditingController movementController = TextEditingController();
  final TextEditingController uterineController = TextEditingController();
  final TextEditingController lightController = TextEditingController();
  final TextEditingController severeController = TextEditingController();
  final TextEditingController prolonguedController = TextEditingController();
  final TextEditingController abnormalController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();
  String result = "";

  Future<void> predictJanin() async {
    final url =
        'http://192.168.1.12:5000/predict'; // Ganti dengan alamat Flask server
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'accelerations': accelerationsController.text,
      'movement': movementController.text,
      'uterine': uterineController.text,
      'light': lightController.text,
      'severe': severeController.text,
      'prolongued': prolonguedController.text,
      'abnormal': abnormalController.text,
      'percentage': percentageController.text,
    };

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      setState(() {
        result = responseData['result'] == 1 ? 'Normal' : 'Abnormal';
      });
    } else {
      setState(() {
        result = 'Error: ${response.statusCode}';
      });
    }
  }

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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: accelerationsController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Accelerations'),
            ),
            TextField(
              controller: movementController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Movement'),
            ),
            TextField(
              controller: uterineController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Uterine'),
            ),
            TextField(
              controller: lightController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Light'),
            ),
            TextField(
              controller: severeController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Severe'),
            ),
            TextField(
              controller: prolonguedController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'prolongued'),
            ),
            TextField(
              controller: abnormalController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'abnormal'),
            ),
            TextField(
              controller: percentageController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: 'percentage'),
            ),
            // Tambahkan TextField lain untuk atribut lainnya
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: predictJanin,
              child: Text('Predict'),
            ),
            SizedBox(height: 16),
            Text(
              'Hasil Prediksi:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(result),
          ],
        ),
      ),
    );
  }
}
