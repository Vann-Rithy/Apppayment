import 'package:flutter/material.dart';
import '../app_localizations.dart'; // Ensure you have the correct path to your localization file
import 'notifications_page.dart'; // Import the NotificationsPage
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AdvanceRequestPage extends StatefulWidget {
  final Function(Locale) setLocale; // Add this line

  AdvanceRequestPage({required this.setLocale}); // Modify constructor

  @override
  _AdvanceRequestPageState createState() => _AdvanceRequestPageState();
}

class _AdvanceRequestPageState extends State<AdvanceRequestPage> {
  String _activeForm = 'Form Request';
  Map<String, bool> _formCompletion = {
    'Form Request': false,
    'Quotation': false,
    'Invoice': false,
  };
  bool _isNotificationVisible = true; // Control visibility of notification
  String _currentFlag =
      'assets/logo/icons8_Cambodia_480px 1.png'; // Default flag

  File? _formRequestImage;
  File? _quotationImage;
  File? _invoiceImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(String formType) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        switch (formType) {
          case 'Form Request':
            _formRequestImage = File(pickedFile.path);
            break;
          case 'Quotation':
            _quotationImage = File(pickedFile.path);
            break;
          case 'Invoice':
            _invoiceImage = File(pickedFile.path);
            break;
        }
      }
    });
  }

  void _switchForm(String formName) {
    setState(() {
      _activeForm = formName;
    });
  }

  void _toggleCompletion(String formName) {
    setState(() {
      _formCompletion[formName] = !_formCompletion[formName]!;
    });
  }

  void _handleSubmit() {
    int completedForms =
        _formCompletion.values.where((isCompleted) => isCompleted).length;

    if (completedForms >= 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!
              .translate('form_submitted_successfully')!),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                AppLocalizations.of(context)!.translate('incomplete_form')!),
            content: Text(AppLocalizations.of(context)!
                .translate('please_complete_at_least_two_forms')!),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppLocalizations.of(context)!.translate('ok')!),
              ),
            ],
          );
        },
      );
    }
  }

  void _toggleNotification() {
    setState(() {
      _isNotificationVisible = !_isNotificationVisible;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context)!.translate('advance_request')!),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.notifications, color: Colors.white, size: 30),
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
                    child: Center(
                      child: Text(
                        '10', // Notification count
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      NotificationsPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    final offsetTween = Tween<Offset>(
                        begin: Offset(1.0, 0.0), end: Offset.zero);
                    final offsetAnimation = animation.drive(
                        offsetTween.chain(CurveTween(curve: Curves.easeInOut)));
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  },
                ),
              );
            },
          ),
          IconButton(
            key: ValueKey(_currentFlag), // Use Key to force rebuild
            icon: Image.asset(_currentFlag), // Use flag image
            onPressed: _changeLanguage,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildForm(),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  child: Text(
                      AppLocalizations.of(context)!.translate('submit_form')!),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    switch (_activeForm) {
      case 'Quotation':
        return _buildQuotationForm();
      case 'Invoice':
        return _buildInvoiceForm();
      case 'Form Request':
      default:
        return _buildFormRequestForm();
    }
  }

  Widget _buildFormRequestForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context)!.translate('form_request')!,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        _buildTextField(AppLocalizations.of(context)!.translate('name')!),
        _buildTextField(AppLocalizations.of(context)!.translate('position')!),
        _buildTextField(AppLocalizations.of(context)!.translate('company')!),
        _buildTextField(
            AppLocalizations.of(context)!.translate('request_for')!),
        _buildTextField(AppLocalizations.of(context)!.translate('us_for')!),
        _buildTextField(AppLocalizations.of(context)!.translate('amount')!),
        SizedBox(height: 20),
        TextButton(
          onPressed: () => _pickImage('Form Request'),
          child: Text(AppLocalizations.of(context)!.translate('upload_image')!),
        ),
        if (_formRequestImage != null)
          Image.file(
            _formRequestImage!,
            height: 200,
            fit: BoxFit.cover,
          ),
      ],
    );
  }

  Widget _buildQuotationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context)!.translate('quotation')!,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        _buildTextField(AppLocalizations.of(context)!.translate('shop_name')!),
        _buildTextField(
            AppLocalizations.of(context)!.translate('quotation_number')!),
        _buildTextField(AppLocalizations.of(context)!.translate('date')!),
        _buildTextField(AppLocalizations.of(context)!.translate('amount')!),
        SizedBox(height: 20),
        TextButton(
          onPressed: () => _pickImage('Quotation'),
          child: Text(AppLocalizations.of(context)!.translate('upload_image')!),
        ),
        if (_quotationImage != null)
          Image.file(
            _quotationImage!,
            height: 200,
            fit: BoxFit.cover,
          ),
      ],
    );
  }

  Widget _buildInvoiceForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context)!.translate('invoice')!,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        _buildTextField(AppLocalizations.of(context)!.translate('shop_name')!),
        _buildTextField(
            AppLocalizations.of(context)!.translate('invoice_number')!),
        _buildTextField(
            AppLocalizations.of(context)!.translate('date_on_invoice')!),
        _buildTextField(AppLocalizations.of(context)!.translate('due_date')!),
        _buildTextField(AppLocalizations.of(context)!.translate('amount')!),
        SizedBox(height: 20),
        TextButton(
          onPressed: () => _pickImage('Invoice'),
          child: Text(AppLocalizations.of(context)!.translate('upload_image')!),
        ),
        if (_invoiceImage != null)
          Image.file(
            _invoiceImage!,
            height: 200,
            fit: BoxFit.cover,
          ),
      ],
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
