import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final String? errorText;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.value,
    this.items = const [],
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFFD1D5DB);
    const labelColor = Color(0xFF6B7280);
    const errorColor = Color(0xFFEF4444);

    final hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: labelColor,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: hasError ? errorColor : borderColor,
              width: hasError ? 1.5 : 1.0,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: items.contains(value) ? value : (items.isNotEmpty ? items.first : null),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Color(0xFF6B7280),
                size: 24,
              ),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1E1E1E),
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: errorColor,
                size: 13,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  errorText!,
                  style: const TextStyle(
                    color: errorColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
