import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final String? author;
  final String? description;

  const DetailsScreen({super.key, this.author, this.description});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Detailed"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(children: [
          Text(
            'Author : ${widget.author ?? ""}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(widget.description ?? "")
        ]),
      ),
    );
  }
}
