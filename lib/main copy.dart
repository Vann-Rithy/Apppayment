import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'notification_service.dart';
import 'news_detail_page.dart';
import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsDashboard(),
    );
  }
}

class NewsDashboard extends StatefulWidget {
  @override
  _NewsDashboardState createState() => _NewsDashboardState();
}

class _NewsDashboardState extends State<NewsDashboard> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  List<dynamic> _news = [];
  Timer? _timer;
  int? _lastNewsId;

  @override
  void initState() {
    super.initState();
    fetchNews();
    _timer =
        Timer.periodic(Duration(seconds: 10), (timer) => checkForNewNews());

    NotificationService()
        .selectNotificationStreamController
        .stream
        .listen((String? payload) async {
      if (payload != null) {
        final id = int.parse(payload);
        final newsItem =
            _news.firstWhere((news) => news['id'] == id.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailPage(
              id: id,
              title: newsItem['title'],
              body: newsItem['body'],
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    NotificationService().dispose();
    super.dispose();
  }

  Future<void> postNews() async {
    final response = await http.post(
      Uri.parse('http://172.17.1.247:8000/post_news.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': _titleController.text,
        'body': _bodyController.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['message'] != null &&
          data['title'] != null &&
          data['body'] != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'])));
        _titleController.clear();
        _bodyController.clear();
        fetchNews();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected response format')));
        print('Unexpected response format: $data');
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to post news')));
      print('Failed to post news: ${response.body}');
    }
  }

  Future<void> fetchNews() async {
    final response =
        await http.get(Uri.parse('http://172.17.1.247:8000/get_all_news.php'));

    if (response.statusCode == 200) {
      setState(() {
        _news = jsonDecode(response.body);
        if (_news.isNotEmpty) {
          _lastNewsId = int.parse(_news.first['id']);
        }
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to fetch news')));
      print('Failed to fetch news: ${response.body}');
    }
  }

  Future<void> checkForNewNews() async {
    final response = await http
        .get(Uri.parse('http://172.17.1.247:8000/get_latest_news.php'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data != null && int.parse(data['id']) != _lastNewsId) {
        NotificationService().showNotification(
            int.parse(data['id']), data['title'], data['body']);
        setState(() {
          _lastNewsId = int.parse(data['id']);
        });
        fetchNews();
      }
    } else {
      print('Failed to check for new news: ${response.body}');
    }
  }

  Future<void> deleteNews(int id) async {
    final response = await http.delete(
      Uri.parse('http://172.17.1.247:8000/delete_news.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(data['message'])));
      fetchNews();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to delete news')));
      print('Failed to delete news: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _news.length,
                itemBuilder: (context, index) {
                  final news = _news[index];
                  return Card(
                    child: ListTile(
                      title: Text(news['title']),
                      subtitle: Text(news['body']),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => deleteNews(int.parse(
                            news['id'])), // Ensure id is parsed as int
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
