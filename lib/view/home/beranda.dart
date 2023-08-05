import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:janin/models/produkmodel.dart';
import 'package:janin/models/tipsmodel.dart';
import 'package:janin/services/berandaservices.dart';
import 'package:janin/theme.dart';
import 'package:janin/view/detail/detailtips.dart';
import 'package:janin/view/detail/produk.dart';
import 'package:janin/view/home/prediksi.dart';
import 'package:janin/view/home/produk.dart';
import 'package:janin/view/home/tips_beranda.dart';
import 'package:janin/view/home/widget/produkcard.dart';
import 'package:janin/view/home/widget/tipscard.dart';

class Beranda extends StatelessWidget {
  Beranda({super.key});

  BerandaService berandaService = BerandaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Hi, Moms',
                  style: labelText.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                StreamBuilder<QuerySnapshot<Object?>>(
                  stream: berandaService.streamUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var data = snapshot.data!.docs;
                      final dataUsers = data[0].data() as Map<String, dynamic>;
                      return Text(dataUsers['namaController']);
                    } else {
                      return Text('Gagal');
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: 150,
                    width: 307,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Untuk mengetahui kondisi janin anda dapat mengisi form dengan klik button form prediksi',
                            style: GoogleFonts.poppins(
                              color: pinkColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: pinkColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrediksiForm(),
                              ),
                            );
                          },
                          child: Text('Form Prediksi'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Produk Untuk Moms',
                      style: GoogleFonts.poppins(
                        color: pinkColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Produk(),
                          ),
                        );
                      },
                      child: Text(
                        'Lihat Semua',
                        style: buttonlabelhomeText.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                StreamBuilder<QuerySnapshot<Object?>>(
                  stream: berandaService.streamProduk(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var data = snapshot.data!.docs;
                      return SizedBox(
                        height: 280,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.9,
                            mainAxisExtent: 190,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            final dataProduk =
                                data[index].data() as Map<String, dynamic>;
                            return ProdukCard(
                              produkModel: ProdukModel(
                                logo: dataProduk['logo'],
                                nama: dataProduk['nama'],
                                kategori: dataProduk['kategori'],
                                rate: dataProduk['rate'],
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProdukDetail(
                                      idDoc: data[index].id,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tips',
                      style: GoogleFonts.poppins(
                        color: pinkColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TipsBeranda(),
                          ),
                        );
                      },
                      child: Text(
                        'Lihat Semua',
                        style: buttonlabelhomeText.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                StreamBuilder<QuerySnapshot<Object?>>(
                  stream: berandaService.streamTips(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var data = snapshot.data!.docs;
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        primary: false,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          final dataTips =
                              data[index].data() as Map<String, dynamic>;
                          return TipsCard(
                              tipsModel: TipsModel(
                                logoT: dataTips['logoT'],
                                namaT: dataTips['namaT'],
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TipsDetail(
                                      idDoc: data[index].id,
                                    ),
                                  ),
                                );
                              });
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
