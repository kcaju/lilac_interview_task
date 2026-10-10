import 'package:flutter/material.dart';

class SavedCreditTile extends StatelessWidget {
  final String title;
  final String dueInfo;
  final String planType;
  final String amount;
  final bool isDueToday;
  final VoidCallback? onTap;

  const SavedCreditTile({
    super.key,
    required this.title,
    required this.dueInfo,
    required this.planType,
    required this.amount,
    this.isDueToday = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      if (isDueToday)
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Due ',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF9CA3AF),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: dueInfo.startsWith('Due ')
                                    ? dueInfo.substring(4)
                                    : (dueInfo.isEmpty ? 'Today' : dueInfo),
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFFF95B51),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Text(
                          dueInfo,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        planType,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9CA3AF),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Text(
                          amount,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E1E1E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 0.8, color: Color(0xFFF3F4F6)),
        ],
      ),
    );
  }
}
