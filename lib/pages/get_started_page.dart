import 'package:expense_tracker/pages/home_page.dart';
import 'package:flutter/material.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Stack(
                children: [
                  Center(
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 130,
                    ),
                  ),
                  Center(child: Image.asset('assets/payment.png')),
                ],
              ),
              const SizedBox(height: 30),

              // Moto
              const Text(
                'Save your money with \nExpense Tracker',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Sentence
              const Text(
                'Save money! The more your money works for you, the less you have to work to money.',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 100),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xfffebc06),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Let\'s Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
