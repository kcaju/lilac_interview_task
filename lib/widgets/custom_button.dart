import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 48,
    this.borderRadius = 28,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    const tealColor = Color(0xFF2F7E79);

    if (isOutlined) {
      return SizedBox(
        width: width,
        height: height,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? const Color(0xFF9CA3AF),
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? tealColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
