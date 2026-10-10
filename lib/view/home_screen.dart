import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lilac_interview_task/controller/bottomnav_controller.dart';
import 'package:lilac_interview_task/controller/expense_provider.dart';
import 'package:lilac_interview_task/widgets/empty_state_widget.dart';
import 'package:lilac_interview_task/widgets/transaction_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _formatCurrency(double amount, {String symbol = '₹'}) {
    return '$symbol ${amount.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth < 360 ? 14.0 : 20.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<ExpenseProvider>(
          builder: (context, provider, child) {
            final transactions = provider.transactions;
            final recentTransactions = transactions.take(3).toList();

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting Section
                  const Text(
                    'Good afternoon,',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF444444),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Sahal Muhammed',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Total Balance Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 22,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF42887D), Color(0xFF2F7E79)],
                      ),
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2F7E79)
                              .withValues(alpha: 0.35),
                          blurRadius: 18,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Balance',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _formatCurrency(provider.totalBalance),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Income
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withValues(
                                            alpha: 0.2,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_downward,
                                          color: Colors.white,
                                          size: 13,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Income',
                                        style: TextStyle(
                                          color: Colors.white.withValues(
                                            alpha: 0.9,
                                          ),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _formatCurrency(provider.totalIncome),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Expenses
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withValues(
                                            alpha: 0.2,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_upward,
                                          color: Colors.white,
                                          size: 13,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Expenses',
                                        style: TextStyle(
                                          color: Colors.white.withValues(
                                            alpha: 0.9,
                                          ),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _formatCurrency(provider.totalExpense),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Daily Average & Weekly Cards
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'DAILY AVERAGE',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6B7280),
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFFD1D5DB),
                                  width: 1.2,
                                ),
                              ),
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    _formatCurrency(provider.dailyAverage),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E1E1E),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'WEEKLY',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6B7280),
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFFD1D5DB),
                                  width: 1.2,
                                ),
                              ),
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    _formatCurrency(provider.weeklyTotal),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E1E1E),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Transactions History Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Transactions History',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E1E1E),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Switch to History tab in bottom navigation
                          Provider.of<BottomnavController>(
                            context,
                            listen: false,
                          ).changeIndex(1);
                        },
                        child: const Text(
                          'See all',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Transaction Items from SQLite
                  if (recentTransactions.isEmpty)
                    const EmptyStateWidget(
                      title: 'No Expenses Found',
                      description: 'Start tracking your spending by adding an expense.',
                    )
                  else
                    ...recentTransactions.map((tx) {
                      final prefix = tx.isIncome ? '+ ₹ ' : '- ₹ ';
                      final formattedAmount =
                          '$prefix${tx.amount.toStringAsFixed(2)}';
                      return TransactionTile(
                        title: tx.name,
                        date: tx.date,
                        amount: formattedAmount,
                        isIncome: tx.isIncome,
                      );
                    }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
