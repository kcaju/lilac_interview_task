import 'package:flutter/material.dart';
import 'package:lilac_interview_task/view/bottom_nav_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isShortScreen = size.height < 700;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top light teal background with curve
          ClipPath(
            clipper: BottomCurveClipper(),
            child: Container(
              height: size.height * (isShortScreen ? 0.62 : 0.68),
              width: double.infinity,
              color: const Color(0xFFEDF8F6),
              child: CustomPaint(painter: ConcentricCirclesPainter()),
            ),
          ),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    // Illustration Area with Character, Coin, and Donut Chart
                    Expanded(
                      flex: isShortScreen ? 5 : 6,
                      child: Center(
                        child: SizedBox(
                          width: size.width,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Character Image
                              Positioned(
                                top: isShortScreen ? 10 : 25,
                                bottom: 10,
                                child: Image.asset(
                                  'assets/onboard1.png',
                                  fit: BoxFit.contain,
                                ),
                              ),

                              // Coin (Left near right hand)
                              Positioned(
                                top: isShortScreen ? 30 : 50,
                                left: (size.width * 0.12).clamp(20.0, 80.0),
                                child: Image.asset(
                                  'assets/Coint.png',
                                  width: isShortScreen ? 52 : 65,
                                  height: isShortScreen ? 52 : 65,
                                ),
                              ),

                              // Donut Chart with Yellow Frame (Right near left hand)
                              Positioned(
                                top: isShortScreen ? 70 : 100,
                                right: (size.width * 0.12).clamp(20.0, 80.0),
                                child: Transform.rotate(
                                  angle: 0.15,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.asset(
                                      'assets/Donut.png',
                                      width: isShortScreen ? 44 : 52,
                                      height: isShortScreen ? 44 : 52,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Bottom Content Area
                    Expanded(
                      flex: isShortScreen ? 4 : 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Spend Smarter\nSave More',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isShortScreen ? 28 : 32,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF42887D),
                                  height: 1.25,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                            SizedBox(height: isShortScreen ? 18 : 28),
                            Container(
                              width: double.infinity,
                              height: isShortScreen ? 52 : 58,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Color(0xFF5AB6AC), Color(0xFF42887D)],
                                ),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF42887D)
                                        .withValues(alpha: 0.35),
                                    blurRadius: 16,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const BottomNavScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Get Started',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 20,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ConcentricCirclesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final center = Offset(size.width / 2, size.height * 0.42);
    canvas.drawCircle(center, size.width * 0.28, paint);
    canvas.drawCircle(center, size.width * 0.45, paint);
    canvas.drawCircle(center, size.width * 0.62, paint);
    canvas.drawCircle(center, size.width * 0.80, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
