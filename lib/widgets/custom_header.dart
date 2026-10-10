import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const CustomHeader({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.onBackPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    const tealColor = Color(0xFF2F7E79);

    return Container(
      width: double.infinity,
      color: tealColor,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              if (showBackButton)
                IconButton(
                  onPressed: onBackPressed ?? () => Navigator.maybePop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                )
              else
                const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (actions != null)
                ...actions!
              else if (showBackButton)
                const SizedBox(width: 20)
              else
                const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
