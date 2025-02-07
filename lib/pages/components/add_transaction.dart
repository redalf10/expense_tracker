import 'package:expense_tracker/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  bool isIncome = true;

  void _submitTransaction() {
    final title = titleController.text;
    final amountText = amountController.text;

    if (title.isEmpty || amountText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter all fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    double? amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid amount.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Provider.of<TransactionProvider>(context, listen: false)
        .addTransaction(title, amount, isIncome);

    // Clear input fields
    titleController.clear();
    amountController.clear();
    setState(() {
      isIncome = true; // Reset switch
    });

    // Close the dialog
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appTextField('Title', 'Enter Title', titleController),
          const SizedBox(height: 10),
          appTextField('Amount', 'Enter Amount', amountController),
          const SizedBox(height: 30),
          incomeExpense(),
          const Spacer(),
          submitButton(),
        ],
      ),
    );
  }

  Column appTextField(
      String title, String hintText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                width: 2,
                color: Color(0xfffebc06),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                width: 3,
                color: Color(0xfffebc06),
              ),
            ),
            hintText: hintText,
          ),
        ),
      ],
    );
  }

  Row incomeExpense() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Income',
          style: TextStyle(
              color: isIncome == true ? const Color(0xfffebc06) : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        Switch(
          activeColor: const Color(0xfffebc06),
          value: isIncome,
          onChanged: (value) {
            setState(() {
              isIncome = value;
            });
          },
        ),
        Text(
          'Expense',
          style: TextStyle(
            color: isIncome == false ? Colors.red : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget submitButton() {
    return InkWell(
      onTap: _submitTransaction,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          // gradient: const LinearGradient(
          //   colors: [
          //     Colors.green,
          //     Colors.yellow,
          //     Colors.red,
          //   ],
          // ),
          color: const Color(0xfffebc06),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            'Submit',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
