import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lilac_interview_task/controller/bottomnav_controller.dart';
import 'package:lilac_interview_task/view/credit_screen.dart';
import 'package:lilac_interview_task/view/history_screen.dart';
import 'package:lilac_interview_task/view/home_screen.dart';
import 'package:lilac_interview_task/view/profile_screen.dart';
import 'package:lilac_interview_task/view/transaction_screen.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    HistoryScreen(),
    CreditScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    const tealColor = Color(0xFF3F877D);
    const ringColor = Color(0xFFD4E7E3);

    return Consumer<BottomnavController>(
      builder: (context, controller, child) {
        final selectedIndex = controller.currentIndex;
        final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: IndexedStack(index: selectedIndex, children: _screens),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: isKeyboardOpen
              ? null
              : GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TransactionScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 68,
                    width: 68,
                    decoration: const BoxDecoration(
                      color: ringColor,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(5.5),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: tealColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.add, color: Colors.white, size: 32),
                      ),
                    ),
                  ),
                ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 5.0,
            color: tealColor,
            elevation: 8,
            padding: EdgeInsets.zero,
            height: 68,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Home Tab
                IconButton(
                  onPressed: () => controller.changeIndex(0),
                  icon: Image.asset(
                    selectedIndex == 0
                        ? 'assets/homeactive.png'
                        : 'assets/home.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                // History Tab
                IconButton(
                  onPressed: () => controller.changeIndex(1),
                  icon: Image.asset(
                    selectedIndex == 1
                        ? 'assets/historyactive.png'
                        : 'assets/history.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                // Middle spacing for FAB
                const SizedBox(width: 48),
                // Wallet / Credit Tab
                IconButton(
                  onPressed: () => controller.changeIndex(2),
                  icon: Image.asset(
                    selectedIndex == 2
                        ? 'assets/creditactive.png'
                        : 'assets/credit.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                // Profile Tab
                IconButton(
                  onPressed: () => controller.changeIndex(3),
                  icon: Image.asset(
                    selectedIndex == 3
                        ? 'assets/profileactive.png'
                        : 'assets/profile.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
