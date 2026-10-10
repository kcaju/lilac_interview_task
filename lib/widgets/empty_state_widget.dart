import 'package:flutter/material.dart';
import 'package:lilac_interview_task/widgets/custom_button.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyStateWidget({
    super.key,
    this.title = 'No Expenses Found',
    this.description = 'You have not added any transactions or expenses yet.',
    this.icon = Icons.receipt_long_rounded,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    const tealColor = Color(0xFF2F7E79);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFFEDF8F6),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFD0EAE6),
                  width: 2,
                ),
              ),
              child: Icon(
                icon,
                size: 44,
                color: tealColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF9CA3AF),
                height: 1.4,
              ),
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              CustomButton(
                text: buttonText!,
                width: 180,
                height: 44,
                borderRadius: 22,
                fontSize: 14,
                onPressed: onButtonPressed,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
