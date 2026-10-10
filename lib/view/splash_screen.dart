import 'package:flutter/material.dart';
import 'package:lilac_interview_task/controller/splashscreen_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashScreenController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SplashScreenController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.startSplash(context);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF68B8B0), Color(0xFF438F89)],
          ),
        ),
        child: const Center(
          child: Text(
            'Expenzia',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
