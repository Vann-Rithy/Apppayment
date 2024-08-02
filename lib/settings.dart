import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final Function(Locale) setLocale;

  SettingsPage(this.setLocale);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 18, 70),
              Color(0xFF001F7F),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/logo/profile_image.png'),
                ),
                SizedBox(height: 20),
                Text(
                  'VANN RITHY',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '+885 96 744 8655',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 30),
                _buildSettingsOption(
                  icon: Icons.language,
                  title: 'Change Language',
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => _buildLanguageSelection(context),
                    );
                  },
                ),
                _buildSettingsOption(
                  icon: Icons.lock,
                  title: 'Change Password',
                  onTap: () {
                    // Add functionality to change password
                  },
                ),
                _buildSettingsOption(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  onTap: () {
                    setState(() {
                      _notificationsEnabled = !_notificationsEnabled;
                    });
                  },
                  trailing: Switch(
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),
                ),
                _buildSettingsOption(
                  icon: Icons.info,
                  title: 'About',
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationIcon: Image.asset(
                        'assets/logo/KCG logo_20230203_KC Group (3) 1.png',
                        width: 50,
                        height: 50,
                      ),
                      applicationName: 'Payment Voucher',
                      applicationVersion: '1.0.0',
                      applicationLegalese: '© 2024 BizApp',
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'BizApp is a comprehensive business application designed to streamline your operations. For more information, visit our website or contact us at support@bizapp.com.',
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Spacer(),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelection(BuildContext context) {
    return Container(
      color: Color(0xFF001F7F),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('English', style: TextStyle(color: Colors.white)),
            onTap: () {
              widget.setLocale(Locale('en', 'US'));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('ភាសាខ្មែរ', style: TextStyle(color: Colors.white)),
            onTap: () {
              widget.setLocale(Locale('km', 'KH'));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
