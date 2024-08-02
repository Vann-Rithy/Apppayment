import 'package:flutter/material.dart';

class SmsPage extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {
      'avatar':
          'assets/logo/profile_image.png', // Example asset, replace with actual path
      'name': 'Mr.CheavSamnang',
      'message': 'New Requests',
      'time': '5:30 PM'
    },
    {
      'avatar': 'assets/logo/profile_image.png',
      'name': 'Chamroeun Chea',
      'message': 'Check on Remark',
      'time': '4:10 PM'
    },
    {
      'avatar': 'assets/logo/profile_image.png',
      'name': 'vann rithy',
      'message': 'Pls Approve!',
      'time': '2:45 PM'
    },
    // Add more messages as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messenger'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(messages[index]['avatar']!),
              radius: 24,
            ),
            title: Text(messages[index]['name']!,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(messages[index]['message']!),
            trailing: Text(messages[index]['time']!,
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            onTap: () {
              // Add navigation to conversation details if needed
            },
          );
        },
      ),
    );
  }
}
