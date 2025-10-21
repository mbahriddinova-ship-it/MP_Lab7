import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostFormScreen extends StatefulWidget {
  const PostFormScreen({super.key});

  @override
  State<PostFormScreen> createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  bool isLoading = false;

  Future<void> submitPost() async {
    setState(() => isLoading = true);
    final response = await http.post(
      Uri.parse('https://reqres.in/api/posts'),
      body: {
        'title': titleController.text,
        'body': bodyController.text,
      },
    );
    setState(() => isLoading = false);

    if (response.statusCode == 201 || response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Post submitted successfully")),
      );
      print(response.body);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to submit post")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Submit Post")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(labelText: "Body"),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: submitPost,
                    child: const Text("Submit"),
                  ),
          ],
        ),
      ),
    );
  }
}
