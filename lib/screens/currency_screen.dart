import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final dateController = TextEditingController();
  final codeController = TextEditingController();
  List currencies = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchCurrency() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      currencies = [];
    });

    String date = dateController.text.trim();
    String code = codeController.text.trim().toUpperCase();
    String url = 'https://cbu.uz/ru/arkhiv-kursov-valyut/json/';

    if (date.isNotEmpty && code.isNotEmpty) {
      url += '$code/$date/';
    } else if (date.isNotEmpty && code.isEmpty) {
      url += 'all/$date/';
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          currencies = jsonDecode(response.body);
        });
      } else {
        errorMessage = "Error: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage = "Network error: $e";
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Currency Rates (CBU.uz)")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: dateController,
              decoration:
                  const InputDecoration(labelText: "Date (YYYY-MM-DD)"),
            ),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                  labelText: "Currency Code (e.g. USD, RUB, all)"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: fetchCurrency, child: const Text("Fetch")),
            const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator()
            else if (errorMessage != null)
              Text(errorMessage!)
            else
              Expanded(
                child: ListView.builder(
                  itemCount: currencies.length,
                  itemBuilder: (context, i) {
                    var c = currencies[i];
                    return ListTile(
                      title: Text('${c['CcyNm_RU']} (${c['Ccy']})'),
                      subtitle: Text('Rate: ${c['Rate']} UZS'),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
