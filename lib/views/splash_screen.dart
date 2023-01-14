import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student/views/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    splashScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Text(
          'Student App',
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.w700, color: Colors.green),
        ),
      )),
    );
  }

  Future<void> splashScreen() async {
    await Future.delayed(Duration(seconds: 4));
    // Navigator.of(context)
    //     .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    Get.to(() => HomeScreen());
  }
}
