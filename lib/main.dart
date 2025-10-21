//Madina Bahriddinova
//Student id: 220155
//Lab7
import 'package:flutter/material.dart';
import 'screens/posts_screen.dart';
import 'screens/post_form_screen.dart';
import 'screens/currency_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API & Networking Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API & Networking Lecture 7')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const PostsScreen())),
                child: const Text('View Posts (GET API)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const PostFormScreen())),
                child: const Text('Submit Post (POST API)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const CurrencyScreen())),
                child: const Text('Currency Rates (CBU API)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
