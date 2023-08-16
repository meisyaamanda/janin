import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:janin/provider/prediksi.dart';
import 'package:janin/view/home/navbar.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        'http://153.92.4.162:5001/predict'; // Ganti dengan alamat Flask server
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
      PrediksiProvider prediksiProvider =
          Provider.of<PrediksiProvider>(context, listen: false);

      final responseData = jsonDecode(response.body);
      setState(() {
        prediksiProvider.setResult(
          responseData['result'] == 1 ? 'normal' : 'kurang baik',
        );
        // firestore
        FirebaseFirestore.instance.collection("hasil_prediksi").add({
          'result': prediksiProvider.result,
          'timestamp': FieldValue.serverTimestamp(),
        });
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
        title: Text(
          'Prediksi Janin',
          style: appBarStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  'Acceleration',
                  style: labelText,
                ),
                SizedBox(
                  width: 5,
                ),
                Tooltip(
                  message: 'Jumlah percepatan denyut jantung janin perdetik.',
                  child: Container(
                    height: 20,
                    width: 20,
                    child: Icon(
                      Icons.info_outline,
                      color: pinkColor,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: accelerationsController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Masukan nilai akselerasi',
                hintStyle: greyTextStyle.copyWith(fontSize: 14),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Fetal Movement',
                  style: labelText,
                ),
                SizedBox(
                  width: 5,
                ),
                Tooltip(
                  message: 'Jumlah pergerakan fisik janin perdetik.',
                  child: Container(
                    height: 20,
                    width: 20,
                    child: Icon(
                      Icons.info_outline,
                      color: pinkColor,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: movementController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Masukkan nilai movement',
                hintStyle: greyTextStyle.copyWith(fontSize: 14),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Uterine Contractions',
                  style: labelText,
                ),
                SizedBox(
                  width: 5,
                ),
                Tooltip(
                  message: 'Jumlah kontraksi rahim perdetik',
                  child: Container(
                    height: 20,
                    width: 20,
                    child: Icon(
                      Icons.info_outline,
                      color: pinkColor,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: uterineController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Masukkan nilai uterine',
                hintStyle: greyTextStyle.copyWith(fontSize: 14),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Light Decelerations',
                  style: labelText,
                ),
                SizedBox(
                  width: 5,
                ),
                Tooltip(
                  message:
                      'Jumlah penurunan singkat denyut jantung rahim perdetik.',
                  child: Container(
                    height: 20,
                    width: 20,
                    child: Icon(
                      Icons.info_outline,
                      color: pinkColor,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: lightController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Masukkan nilai light',
                hintStyle: greyTextStyle.copyWith(fontSize: 14),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Severe Decelerations',
                  style: labelText,
                ),
                SizedBox(
                  width: 5,
                ),
                Tooltip(
                  message:
                      'Jumlah penurunan yang signifikan dalam denyut jantung janin perdetik.',
                  child: Container(
                    height: 20,
                    width: 20,
                    child: Icon(
                      Icons.info_outline,
                      color: pinkColor,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: severeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText:
                    'Masukkan nilai severe',
                hintStyle: greyTextStyle.copyWith(fontSize: 14),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Prolongued Decelerations',
                  style: labelText,
                ),
                SizedBox(
                  width: 5,
                ),
                Tooltip(
                  message:
                      'Jumlah penurunan yang lebih lama dalam denyut jantung janin perdetik.',
                  child: Container(
                    height: 20,
                    width: 20,
                    child: Icon(
                      Icons.info_outline,
                      color: pinkColor,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: prolonguedController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText:
                    'Masukkan nilai prolongued',
                hintStyle: greyTextStyle.copyWith(fontSize: 14),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Abnormal Short Term',
                  style: labelText,
                ),
                SizedBox(
                  width: 5,
                ),
                Tooltip(
                  message:
                      'Persentase waktu dalam interval antara denyut jantung janin yang terjadi secara singkat.',
                  child: Container(
                    height: 20,
                    width: 20,
                    child: Icon(
                      Icons.info_outline,
                      color: pinkColor,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: abnormalController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText:
                    'Masukkan nilai abnormal',
                hintStyle: greyTextStyle.copyWith(fontSize: 14),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Percentage of time',
                  style: labelText,
                ),
                SizedBox(
                  width: 5,
                ),
                Tooltip(
                  message:
                      'Persentase waktu dalam interval antara denyut jantung janin yang terjadi dalam jangka waktu panjang.',
                  child: Container(
                    height: 20,
                    width: 20,
                    child: Icon(
                      Icons.info_outline,
                      color: pinkColor,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: percentageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Masukkan nilai percentage',
                hintStyle: greyTextStyle.copyWith(fontSize: 14),
              ),
            ),
            // Tambahkan TextField lain untuk atribut lainnya
            SizedBox(height: 16),
            Center(
              child: Container(
                width: 277,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: pinkColor,
                  ),
                  onPressed: () {
                    predictJanin();
                    showDialog(
                      context: context,
                      builder: (context) {
                        final prediksiProvider = Provider.of<PrediksiProvider>(
                            context,
                            listen: false);
                        return AlertDialog(
                          title: Text('Hasil Prediksi'),
                          content: Text(
                            "Janin anda dalam keadaan ${prediksiProvider.result} \n \v Status kesehatan: ${prediksiProvider.result}",
                          ),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: pinkColor,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Navbar(),
                                  ),
                                );
                              },
                              child: Text(
                                'Baik',
                                style: TextStyle(
                                  color: blackColor,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Prediksi',
                    style: buttonText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
