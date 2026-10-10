import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final bool isIncome;
  final bool showActions;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const TransactionTile({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.isIncome,
    this.showActions = false,
    this.onEdit,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF9CA3AF),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  amount,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isIncome ? const Color(0xFF25A969) : const Color(0xFFF95B51),
                  ),
                ),
              ),
            ),
            if (showActions) ...[
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF1E1E1E)),
                  constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                  padding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete, size: 18, color: Colors.white),
                  constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
