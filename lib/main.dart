import 'package:expense_tracker/pages/get_started_page.dart';
import 'package:expense_tracker/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Add this
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransactionProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GetStartedPage(),
      ),
    );
  }
}
