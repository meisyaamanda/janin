import 'dart:async';
import 'package:janin/theme.dart';
import 'package:flutter/material.dart';
import 'package:janin/view/signin/signin.dart';
import 'package:janin/view/signin/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/auth.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    splashStart();
    getId();
  }

  void getId() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences pref = await _prefs;
    final id = await pref.getString(
      "uid",
    );
    print(id);
    Auth auth = Provider.of<Auth>(context, listen: false);
    auth.id = id!;
    print(auth.id);
  }

  splashStart() async {
    var duration = const Duration(seconds: 3);
    return Timer(
      duration,
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Wrapper(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pinkColor,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 300,
                child: Image.asset('assets/image/logo.png'),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
