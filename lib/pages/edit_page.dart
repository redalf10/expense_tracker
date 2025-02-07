import 'package:expense_tracker/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'List of Transactions',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_circle_left,
            size: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xfffebc06),
      ),
      body: ListView.builder(
        itemCount: transactionProvider.transaction.length,
        itemBuilder: (context, index) {
          final transaction = transactionProvider.transaction[index];
          return Dismissible(
            key: Key(transaction.id), // Unique key for each item
            direction: DismissDirection.endToStart, // Swipe from right to left
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Confirm Deletion"),
                  content: const Text(
                      "Are you sure you want to delete this transaction?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false); // Cancel deletion
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true); // Confirm deletion
                      },
                      child: const Text("Delete",
                          style: TextStyle(color: Color(0xfffebc06))),
                    ),
                  ],
                ),
              );
            },
            onDismissed: (direction) {
              transactionProvider.removeTransaction(transaction.id);
            },
            child: ListTile(
              title: Text(
                transaction.title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(transaction.date.toString()),
              trailing: Text(
                '₱ ${transaction.amount.toString()}',
                style: TextStyle(
                  color: transaction.isIncome
                      ? const Color(0xfffebc06)
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
