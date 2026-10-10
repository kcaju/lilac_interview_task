import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lilac_interview_task/controller/expense_provider.dart';
import 'package:lilac_interview_task/model/credit_model.dart';
import 'package:lilac_interview_task/widgets/custom_button.dart';
import 'package:lilac_interview_task/widgets/custom_dropdown_field.dart';
import 'package:lilac_interview_task/widgets/custom_header.dart';
import 'package:lilac_interview_task/widgets/custom_input_field.dart';
import 'package:lilac_interview_task/widgets/saved_credit_tile.dart';

class CreditScreen extends StatefulWidget {
  const CreditScreen({super.key});

  @override
  State<CreditScreen> createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  late final TextEditingController _toController;
  late final TextEditingController _dateController;
  late final TextEditingController _amountController;

  late final ValueNotifier<String> _creditTypeNotifier;
  late final ValueNotifier<String> _planTypeNotifier;
  late final ValueNotifier<String?> _toErrorNotifier;
  late final ValueNotifier<String?> _dateErrorNotifier;
  late final ValueNotifier<String?> _amountErrorNotifier;

  @override
  void initState() {
    super.initState();
    _creditTypeNotifier = ValueNotifier<String>('Subscriptions');
    _planTypeNotifier = ValueNotifier<String>('Monthly');
    _toController = TextEditingController();
    _dateController = TextEditingController();
    _amountController = TextEditingController();
    _toErrorNotifier = ValueNotifier<String?>(null);
    _dateErrorNotifier = ValueNotifier<String?>(null);
    _amountErrorNotifier = ValueNotifier<String?>(null);
  }

  @override
  void dispose() {
    _toController.dispose();
    _dateController.dispose();
    _amountController.dispose();
    _creditTypeNotifier.dispose();
    _planTypeNotifier.dispose();
    _toErrorNotifier.dispose();
    _dateErrorNotifier.dispose();
    _amountErrorNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const CustomHeader(
            title: 'Credit',
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(
                  20.0,
                  20.0,
                  20.0,
                  MediaQuery.of(context).viewInsets.bottom + 40.0,
                ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Form Fields
                  ValueListenableBuilder<String>(
                    valueListenable: _creditTypeNotifier,
                    builder: (context, val, _) {
                      return CustomDropdownField(
                        label: 'Credit Type',
                        value: val,
                        items: const ['Subscriptions', 'Loans', 'Bills', 'Personal'],
                        onChanged: (newVal) {
                          if (newVal != null) _creditTypeNotifier.value = newVal;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ValueListenableBuilder<String?>(
                    valueListenable: _toErrorNotifier,
                    builder: (context, error, _) {
                      return CustomInputField(
                        label: 'To',
                        controller: _toController,
                        hintText: 'Netflix',
                        errorText: error,
                        onChanged: (val) {
                          if (error != null) _toErrorNotifier.value = null;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ValueListenableBuilder<String?>(
                    valueListenable: _dateErrorNotifier,
                    builder: (context, error, _) {
                      return CustomInputField(
                        label: 'Date',
                        controller: _dateController,
                        readOnly: true,
                        hintText: 'Tue, 22 Feb 2026',
                        errorText: error,
                        suffixIcon: Icons.calendar_month_rounded,
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color(0xFF2F7E79),
                                    onPrimary: Colors.white,
                                    onSurface: Color(0xFF1E1E1E),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            const months = [
                              'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                              'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                            ];
                            const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                            final dayName = days[picked.weekday - 1];
                            final monthName = months[picked.month - 1];
                            _dateController.text =
                                '$dayName, ${picked.day} $monthName ${picked.year}';
                            _dateErrorNotifier.value = null;
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ValueListenableBuilder<String>(
                    valueListenable: _planTypeNotifier,
                    builder: (context, val, _) {
                      return CustomDropdownField(
                        label: 'Plan Type',
                        value: val,
                        items: const ['Monthly', 'Yearly', 'One-Time', 'Weekly'],
                        onChanged: (newVal) {
                          if (newVal != null) _planTypeNotifier.value = newVal;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ValueListenableBuilder<String?>(
                    valueListenable: _amountErrorNotifier,
                    builder: (context, error, _) {
                      return CustomInputField(
                        label: 'Amount',
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        hintText: '850.00',
                        errorText: error,
                        onChanged: (val) {
                          if (error != null) _amountErrorNotifier.value = null;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  // Save Button with Form Validation
                  CustomButton(
                    text: 'Save',
                    onPressed: () async {
                      bool hasError = false;

                      // Validate To
                      final to = _toController.text.trim();
                      if (to.isEmpty) {
                        _toErrorNotifier.value = 'Recipient / Service is required';
                        hasError = true;
                      } else {
                        _toErrorNotifier.value = null;
                      }

                      // Validate Date
                      final date = _dateController.text.trim();
                      if (date.isEmpty) {
                        _dateErrorNotifier.value = 'Date is required';
                        hasError = true;
                      } else {
                        _dateErrorNotifier.value = null;
                      }

                      // Validate Amount
                      final rawAmount = _amountController.text
                          .trim()
                          .replaceAll('\$', '')
                          .replaceAll('₹', '')
                          .replaceAll(',', '')
                          .trim();

                      if (rawAmount.isEmpty) {
                        _amountErrorNotifier.value = 'Amount is required';
                        hasError = true;
                      } else {
                        final parsed = double.tryParse(rawAmount);
                        if (parsed == null || parsed <= 0) {
                          _amountErrorNotifier.value = 'Amount must be a valid positive number (> 0)';
                          hasError = true;
                        } else {
                          _amountErrorNotifier.value = null;
                        }
                      }

                      // Prevent saving if invalid
                      if (hasError) {
                        return;
                      }

                      final parsedAmount = double.parse(rawAmount);
                      final newCredit = CreditModel(
                        creditType: _creditTypeNotifier.value,
                        to: to,
                        date: date,
                        planType: _planTypeNotifier.value,
                        amount: parsedAmount,
                        dueInfo: '',
                      );

                      final success = await context.read<ExpenseProvider>().addCredit(newCredit);
                      if (context.mounted && success) {
                        _toController.clear();
                        _dateController.clear();
                        _amountController.clear();
                      }
                    },
                  ),
                  const SizedBox(height: 28),
                  // Saved Lists Header
                  const Text(
                    'Your Saved Lists',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Saved items from SQLite database
                  Consumer<ExpenseProvider>(
                    builder: (context, provider, child) {
                      final credits = provider.credits;

                      if (credits.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.0),
                          child: Center(
                            child: Text(
                              'No saved credit records yet',
                              style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: credits.length,
                        itemBuilder: (context, index) {
                          final item = credits[index];
                          final formattedAmount = '₹ ${item.amount.toStringAsFixed(2)}';

                          return Dismissible(
                            key: ValueKey(item.id ?? index),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              color: Colors.red,
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (_) {
                              if (item.id != null) {
                                provider.deleteCredit(item.id!);
                              }
                            },
                            child: SavedCreditTile(
                              title: item.to,
                              dueInfo: item.formattedDueInfo,
                              planType: item.planType,
                              amount: formattedAmount,
                              isDueToday: item.isDueToday,
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
  }
}
