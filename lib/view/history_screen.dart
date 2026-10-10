import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lilac_interview_task/controller/expense_provider.dart';
import 'package:lilac_interview_task/view/edit_transaction_screen.dart';
import 'package:lilac_interview_task/widgets/custom_header.dart';
import 'package:lilac_interview_task/widgets/empty_state_widget.dart';
import 'package:lilac_interview_task/widgets/transaction_tile.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIdNotifier = ValueNotifier<int?>(null);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const CustomHeader(
            title: 'Transaction History',
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: Consumer<ExpenseProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading && provider.transactions.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                final transactions = provider.transactions;

                if (transactions.isEmpty) {
                  return const EmptyStateWidget(
                    title: 'No Transactions Yet',
                    description: 'Your expense and income transactions will appear here.',
                  );
                }

                return ValueListenableBuilder<int?>(
                  valueListenable: selectedIdNotifier,
                  builder: (context, selectedId, _) {
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                      itemCount: transactions.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 4),
                      itemBuilder: (context, index) {
                        final tx = transactions[index];
                        final prefix = tx.isIncome ? '+ ₹ ' : '- ₹ ';
                        final formattedAmount = '$prefix${tx.amount.toStringAsFixed(2)}';
                        final isSelected = selectedId == tx.id;

                        return TransactionTile(
                          title: tx.name,
                          date: tx.date,
                          amount: formattedAmount,
                          isIncome: tx.isIncome,
                          showActions: isSelected,
                          onTap: () {
                            // Toggle showing edit/delete actions on clicked data
                            if (selectedIdNotifier.value == tx.id) {
                              selectedIdNotifier.value = null;
                            } else {
                              selectedIdNotifier.value = tx.id;
                            }
                          },
                          onEdit: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditTransactionScreen(
                                  transaction: tx,
                                ),
                              ),
                            );
                          },
                          onDelete: () async {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                title: const Text(
                                  'Delete Expense',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: Text(
                                  'Are you sure you want to delete "${tx.name}" with amount $formattedAmount?',
                                  style: const TextStyle(color: Color(0xFF4B5563)),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, false),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: Color(0xFF6B7280)),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(ctx, true),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFEF4444),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );

                            if (confirmed == true && tx.id != null) {
                              if (context.mounted) {
                                await context
                                    .read<ExpenseProvider>()
                                    .deleteTransaction(tx.id!);
                              }
                            }
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
  }
}
