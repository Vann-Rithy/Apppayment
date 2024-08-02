import 'package:flutter/material.dart';
import '../app_localizations.dart';
import 'checkrequest.dart'; // Import CheckRequestPage

class NotificationsPage extends StatelessWidget {
  // Updated notifications with date
  final List<Map<String, String>> notifications = [
    {'message': 'Your request has been approved.', 'date': '2024-07-20'},
    {
      'message': 'Your account was logged in from a new device.',
      'date': '2024-07-19'
    },
    {'message': 'New message from support.', 'date': '2024-07-18'},
    {'message': 'Your payment has been processed.', 'date': '2024-07-17'},
    {'message': 'Update available for the app.', 'date': '2024-07-16'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 36, 143),
        title: Text(
          AppLocalizations.of(context)!.translate('notification')!,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 10, 1, 131),
              Color.fromARGB(255, 2, 4, 122),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  leading: Icon(
                    Icons.notifications,
                    color: Colors.blueAccent,
                    size: 32,
                  ),
                  title: Text(
                    notification['message']!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    'Date: ${notification['date']}',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckRequestPage(
                            index:
                                index + 1), // Pass index + 1 to match example
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
