import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lilac_interview_task/controller/expense_provider.dart';
import 'package:lilac_interview_task/widgets/custom_button.dart';
import 'package:lilac_interview_task/widgets/custom_header.dart';

class ProfileScreen extends StatelessWidget {
  final String userName;

  const ProfileScreen({super.key, this.userName = 'Sahal Muhammed'});

  @override
  Widget build(BuildContext context) {
    const tealColor = Color(0xFF2F7E79);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const CustomHeader(title: 'Profile', showBackButton: false),
          Expanded(
            child: SafeArea(
              top: false,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // User Avatar with Camera Badge
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: const BoxDecoration(
                                color: Color(0xFFC4C4C4),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 70,
                                color: Color(0xFFEDEDED),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: tealColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 3),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // User Name with Edit Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E1E1E),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.edit_outlined,
                            size: 18,
                            color: Color(0xFF9CA3AF),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Clear Storage Button that clears SQLite Database
                      CustomButton(
                        text: 'Clear Storage',
                        isOutlined: true,
                        textColor: const Color(0xFF9CA3AF),
                        borderRadius: 20,
                        height: 42,
                        width: 150,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        onPressed: () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Clear Storage'),
                              content: const Text(
                                'Are you sure you want to clear all stored transactions and credits from the SQLite database?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, true),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                  child: const Text('Clear All'),
                                ),
                              ],
                            ),
                          );

                          if (confirmed == true && context.mounted) {
                            await context
                                .read<ExpenseProvider>()
                                .clearAllStorage();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
