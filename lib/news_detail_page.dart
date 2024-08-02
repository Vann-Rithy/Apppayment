import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  final int id;
  final String title;
  final String body;

  const NewsDetailPage(
      {Key? key, required this.id, required this.title, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(body, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
