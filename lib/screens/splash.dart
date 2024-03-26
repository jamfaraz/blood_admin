import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/auth_gate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Get.to(() => const AuthGate());
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'images/donor.jpeg',
               
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
