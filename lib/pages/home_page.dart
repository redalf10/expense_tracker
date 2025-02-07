import 'dart:io';

import 'package:expense_tracker/pages/components/add_transaction.dart';
import 'package:expense_tracker/pages/components/transaction_balance.dart';
import 'package:expense_tracker/pages/components/transaction_list.dart';
import 'package:expense_tracker/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to exit?'),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), // Stay in app
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  // Close the app
                  if (Platform.isAndroid) {
                    SystemNavigator.pop(); // Works better for Android
                  } else if (Platform.isIOS) {
                    exit(0); // Forces app to close (iOS might reject this)
                  }
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final transcation = transactionProvider.transaction;
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          // actions: const [
          //   Icon(
          //     Icons.notification_add_rounded,
          //   ),
          // ],
          // leading: const Icon(
          //   Icons.menu_rounded,
          //   color: Colors.white,
          // ),
          title: const Text(
            'Expense Tracker',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xfffebc06),
          elevation: 0,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) => const AddTransaction(),
            );
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: Column(
          children: [
            const TransactionBalance(),
            const SizedBox(height: 20),
            transcation.isEmpty
                ? const Center(
                    child: Text(
                      'No transactions added yet.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                  )
                : const Expanded(
                    child: TransactionList(),
                  ),
          ],
        ),
      ),
    );
  }
}
