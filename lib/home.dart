import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'app_localizations.dart'; // Ensure you have the correct path to your localization file
import 'payment.dart';
import 'sms.dart';
import 'statistics.dart';
import 'receipts.dart';
import 'settings.dart';
import 'screens/payment_voucher_details.dart'; // Import the new details page
import 'screens/advance_request_details.dart'; // Import the new details page
import 'screens/payment_voucher.dart'; // Import the new details page
import 'screens/advance_request.dart'; // Import the new details page
import 'screens/notifications_page.dart'; // Add this import

class HomeScreen extends StatefulWidget {
  final Function(Locale) setLocale;

  HomeScreen(this.setLocale);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _currentFlag =
      'assets/logo/icons8_Cambodia_480px 1.png'; // Initial flag

  static late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomePage(widget.setLocale), // Pass the setLocale function
      PaymentsPage(),
      StatisticsPage(),
      ReceiptsPage(),
      SettingsPage(widget.setLocale), // Pass the setLocale function
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _changeLanguage() {
    setState(() {
      if (_currentFlag == 'assets/logo/icons8_Cambodia_480px 1.png') {
        _currentFlag =
            'assets/logo/icons8_great_britain_48px.png'; // Change to Great Britain flag
        widget.setLocale(
            Locale('en', 'GB')); // Change to British English language
      } else {
        _currentFlag =
            'assets/logo/icons8_Cambodia_480px 1.png'; // Change to Cambodia flag
        widget.setLocale(Locale('km', 'KH')); // Change to Khmer language
      }
    });
  }

  Widget _buildStatCard(
      String title, String count, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    count,
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              color, // Correct parameter for setting the button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: AppLocalizations.of(context)!.translate('home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: AppLocalizations.of(context)!.translate('payments'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: AppLocalizations.of(context)!.translate('statistics'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: AppLocalizations.of(context)!.translate('transaction'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: AppLocalizations.of(context)!.translate('settings'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentDate =
        DateFormat.yMMMMd(AppLocalizations.of(context)!.locale.toString())
            .format(DateTime.now());

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 36, 143),
      appBar: _selectedIndex == 0 // Show AppBar only for HomePage
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.translate('hello')!,
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(_createRoute());
                          },
                          child: Stack(
                            children: [
                              Icon(Icons.notifications,
                                  color: Colors.white, size: 30),
                              Positioned(
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 18,
                                    minHeight: 18,
                                  ),
                                  child: Text(
                                    '10',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: _changeLanguage,
                          child: Image.asset(
                            _currentFlag,
                            height: 36,
                            key: ValueKey(
                                _currentFlag), // Use Key to force rebuild
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SmsPage()),
                            );
                          },
                          child: Stack(
                            children: [
                              Icon(Icons.sms, color: Colors.white, size: 30),
                              Positioned(
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 18,
                                    minHeight: 18,
                                  ),
                                  child: Text(
                                    '5', // Replace with the actual number of SMS notifications
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : null, // Hide AppBar for other pages
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          NotificationsPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final Function(Locale) setLocale;

  HomePage(this.setLocale);

  @override
  Widget build(BuildContext context) {
    final currentDate =
        DateFormat.yMMMMd(AppLocalizations.of(context)!.locale.toString())
            .format(DateTime.now());

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.translate('today')!,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              currentDate,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                _buildStatCard(
                  AppLocalizations.of(context)!.translate('payment_voucher')!,
                  '120',
                  Colors.lightBlueAccent,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentVoucherDetailsPage(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                _buildStatCard(
                  AppLocalizations.of(context)!.translate('advance_request')!,
                  '10',
                  Colors.orange,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdvanceRequestDetailsPage(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildNavButton(
              text: AppLocalizations.of(context)!.translate('payment_voucher')!,
              icon: Icons.payment,
              color: Colors.lightBlueAccent,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PaymentVoucherPage(setLocale: setLocale),
                ),
              ),
            ),
            SizedBox(height: 10),
            _buildNavButton(
              text: AppLocalizations.of(context)!.translate('advance_request')!,
              icon: Icons.request_page,
              color: Colors.orange,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AdvanceRequestPage(setLocale: setLocale),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, String count, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    count,
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              color, // Correct parameter for setting the button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
