import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final String? initialValue;
  final String? hintText;
  final TextEditingController? controller;
  final bool isHighlighted;
  final String? suffixText;
  final VoidCallback? onSuffixTap;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final Color? textColor;
  final String? errorText;

  const CustomInputField({
    super.key,
    required this.label,
    this.initialValue,
    this.hintText,
    this.controller,
    this.isHighlighted = false,
    this.suffixText,
    this.onSuffixTap,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.textColor,
    this.errorText,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const tealColor = Color(0xFF2F7E79);
    const borderColor = Color(0xFFD1D5DB);
    const labelColor = Color(0xFF6B7280);
    const errorColor = Color(0xFFEF4444);

    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;
    final isActive = _isFocused || widget.isHighlighted;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: hasError
                ? errorColor
                : (isActive ? tealColor : labelColor),
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: hasError
                    ? errorColor
                    : (isActive ? tealColor : borderColor),
                width: hasError || isActive ? 1.5 : 1.0,
              ),
              boxShadow: isActive && !hasError
                  ? [
                      BoxShadow(
                        color: tealColor.withValues(alpha: 0.12),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                Expanded(
                  child: widget.controller != null
                      ? TextField(
                          controller: widget.controller,
                          focusNode: _focusNode,
                          readOnly: widget.readOnly,
                          keyboardType: widget.keyboardType,
                          onChanged: widget.onChanged,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: widget.textColor ?? const Color(0xFF1E1E1E),
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: widget.hintText,
                            hintStyle: const TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                      : Text(
                          widget.initialValue ?? widget.hintText ?? '',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: widget.textColor ??
                                (widget.initialValue != null
                                    ? const Color(0xFF1E1E1E)
                                    : const Color(0xFF9CA3AF)),
                          ),
                        ),
                ),
                if (widget.suffixText != null)
                  GestureDetector(
                    onTap: widget.onSuffixTap,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        widget.suffixText!,
                        style: const TextStyle(
                          color: tealColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                if (widget.suffixIcon != null)
                  GestureDetector(
                    onTap: widget.onSuffixIconTap ?? widget.onTap,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        widget.suffixIcon,
                        color: isActive ? tealColor : const Color(0xFF6B7280),
                        size: 20,
                      ),
                    ),
                  ),
              ],
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
                  widget.errorText!,
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

