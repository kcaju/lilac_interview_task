import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lilac_interview_task/controller/expense_provider.dart';
import 'package:lilac_interview_task/model/transaction_model.dart';
import 'package:lilac_interview_task/widgets/custom_button.dart';
import 'package:lilac_interview_task/widgets/custom_dropdown_field.dart';
import 'package:lilac_interview_task/widgets/custom_header.dart';
import 'package:lilac_interview_task/widgets/custom_input_field.dart';

class EditTransactionScreen extends StatefulWidget {
  final TransactionModel transaction;

  const EditTransactionScreen({
    super.key,
    required this.transaction,
  });

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _amountController;
  late final TextEditingController _dateController;

  late final ValueNotifier<String> _typeNotifier;
  late final ValueNotifier<String?> _nameErrorNotifier;
  late final ValueNotifier<String?> _amountErrorNotifier;
  late final ValueNotifier<String?> _dateErrorNotifier;

  @override
  void initState() {
    super.initState();
    _typeNotifier = ValueNotifier<String>(widget.transaction.type);
    _nameController = TextEditingController(text: widget.transaction.name);
    _amountController = TextEditingController(
      text: widget.transaction.amount.toStringAsFixed(2),
    );
    _dateController = TextEditingController(text: widget.transaction.date);
    _nameErrorNotifier = ValueNotifier<String?>(null);
    _amountErrorNotifier = ValueNotifier<String?>(null);
    _dateErrorNotifier = ValueNotifier<String?>(null);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _typeNotifier.dispose();
    _nameErrorNotifier.dispose();
    _amountErrorNotifier.dispose();
    _dateErrorNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const CustomHeader(
            title: 'Edit Transaction',
            showBackButton: true,
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: Column(
                children: [
                  // Form Card Container
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: const Color(0xFFF3F4F6),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ValueListenableBuilder<String>(
                          valueListenable: _typeNotifier,
                          builder: (context, type, _) {
                            return CustomDropdownField(
                              label: 'Transaction Type',
                              value: type,
                              items: const ['Expense', 'Income'],
                              onChanged: (val) {
                                if (val != null) _typeNotifier.value = val;
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 18),
                        ValueListenableBuilder<String?>(
                          valueListenable: _nameErrorNotifier,
                          builder: (context, error, _) {
                            return CustomInputField(
                              label: 'Name',
                              controller: _nameController,
                              hintText: 'Upwork',
                              errorText: error,
                              onChanged: (val) {
                                if (error != null) {
                                  _nameErrorNotifier.value = null;
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 18),
                        ValueListenableBuilder<String?>(
                          valueListenable: _amountErrorNotifier,
                          builder: (context, error, _) {
                            return CustomInputField(
                              label: 'Amount',
                              controller: _amountController,
                              isHighlighted: false,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              hintText: '₹ 850.00',
                              suffixText: 'Clear',
                              errorText: error,
                              onChanged: (val) {
                                if (error != null) {
                                  _amountErrorNotifier.value = null;
                                }
                              },
                              onSuffixTap: () {
                                _amountController.clear();
                                _amountErrorNotifier.value = 'Amount is required';
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 18),
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  // Save Button with Validation
                  CustomButton(
                    text: 'Save',
                    onPressed: () async {
                      bool hasError = false;

                      // Validate Name
                      final name = _nameController.text.trim();
                      if (name.isEmpty) {
                        _nameErrorNotifier.value = 'Name is required';
                        hasError = true;
                      } else if (name.length < 2) {
                        _nameErrorNotifier.value = 'Name must be at least 2 characters';
                        hasError = true;
                      } else {
                        _nameErrorNotifier.value = null;
                      }

                      // Validate Amount (Must be a positive number)
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
                        final parsedAmount = double.tryParse(rawAmount);
                        if (parsedAmount == null) {
                          _amountErrorNotifier.value = 'Please enter a valid numerical amount';
                          hasError = true;
                        } else if (parsedAmount <= 0) {
                          _amountErrorNotifier.value = 'Amount must be a valid positive number (> 0)';
                          hasError = true;
                        } else {
                          _amountErrorNotifier.value = null;
                        }
                      }

                      // Validate Date
                      final date = _dateController.text.trim();
                      if (date.isEmpty) {
                        _dateErrorNotifier.value = 'Date is required';
                        hasError = true;
                      } else {
                        _dateErrorNotifier.value = null;
                      }

                      // Block save on validation error
                      if (hasError) {
                        return;
                      }

                      final parsedAmount = double.parse(rawAmount);
                      final updatedTx = widget.transaction.copyWith(
                        type: _typeNotifier.value,
                        name: name,
                        amount: parsedAmount,
                        date: date,
                      );

                      final success = await context.read<ExpenseProvider>().updateTransaction(updatedTx);
                      if (context.mounted && success) {
                        Navigator.pop(context);
                      }
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
