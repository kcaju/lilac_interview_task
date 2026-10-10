import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lilac_interview_task/view/onboarding_screen.dart';

class SplashScreenController extends ChangeNotifier {
  Timer? _timer;

  void startSplash(BuildContext context) {
    _timer?.cancel();

    _timer = Timer(const Duration(seconds: 2), () {
      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
