import 'package:flutter/material.dart';
import 'package:janin/provider/auth.dart';
import 'package:provider/provider.dart';
import '../../theme.dart';

class EditProfil extends StatefulWidget {
  EditProfil({
    super.key,
    required this.nama,
    required this.email,
    required this.no,
  });
  final String nama;
  final String email;
  final String no;

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaUController = TextEditingController();
  TextEditingController noUController = TextEditingController();
  TextEditingController emailUController = TextEditingController();

  @override
  void initState() {
    namaUController.text = widget.nama;
    noUController.text = widget.no;
    emailUController.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: false);
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
          'Edit Profil',
          style: appBarStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://googleflutter.com/sample_image.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Lengkap',
                      style: labelText,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: namaUController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Nomor Hp',
                      style: labelText,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: noUController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Email',
                      style: labelText,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: emailUController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Container(
                  width: 277,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: pinkColor,
                      ),
                      onPressed: () {
                        auth.updateDetailsToFirestore(
                          emailUController.text,
                          namaUController.text,
                          noUController.text,
                          context,
                        );
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Simpan',
                        style: buttonText,
                      )),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
