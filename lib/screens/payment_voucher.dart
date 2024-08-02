import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:image_picker/image_picker.dart';
import '../app_localizations.dart';
import 'notifications_page.dart';

class PaymentVoucherPage extends StatefulWidget {
  final Function(Locale) setLocale;

  PaymentVoucherPage({required this.setLocale});

  @override
  _PaymentVoucherPageState createState() => _PaymentVoucherPageState();
}

class _PaymentVoucherPageState extends State<PaymentVoucherPage> {
  String _activeForm = 'Form Request';
  Map<String, bool> _formCompletion = {
    'Form Request': false,
    'Quotation': false,
    'Invoice': false,
  };
  bool _isNotificationVisible = true;
  String _currentFlag = 'assets/logo/icons8_Cambodia_480px 1.png';
  File? _formRequestImage;
  File? _quotationImage;
  File? _invoiceImage;

  String? _selectedUsedAt;
  String? _selectedCompany;

  final List<String> _usedAtOptions = ['Office', 'ក្រសួង', 'ឆៀកចល័ត'];
  final List<String> _companyOptions = ['KC', 'SME', 'KCM', 'HK'];

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

  Future<void> _pickImage(String formName) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (formName == 'Form Request') {
          _formRequestImage = File(pickedFile.path);
        } else if (formName == 'Quotation') {
          _quotationImage = File(pickedFile.path);
        } else if (formName == 'Invoice') {
          _invoiceImage = File(pickedFile.path);
        }
      });
    }
  }

  void _handleSubmit() {
    int completedForms =
        _formCompletion.values.where((isCompleted) => isCompleted).length;

    if (completedForms >= 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!
                .translate('form_submitted_successfully')!)),
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
        _currentFlag = 'assets/logo/icons8_great_britain_48px.png';
        widget.setLocale(Locale('en', 'GB'));
      } else {
        _currentFlag = 'assets/logo/icons8_Cambodia_480px 1.png';
        widget.setLocale(Locale('km', 'KH'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Voucher'),
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
                        '10',
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
            key: ValueKey(_currentFlag),
            icon: Image.asset(_currentFlag),
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
              if (_isNotificationVisible)
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.amber,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .translate('new_notifications')!,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: _toggleNotification,
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFormButton(
                    icon: Icons.request_page,
                    label: AppLocalizations.of(context)!
                        .translate('form_request')!,
                    isActive: _activeForm == 'Form Request',
                    isCompleted: _formCompletion['Form Request']!,
                    onPressed: () => _switchForm('Form Request'),
                  ),
                  _buildFormButton(
                    icon: Icons.description,
                    label:
                        AppLocalizations.of(context)!.translate('quotation')!,
                    isActive: _activeForm == 'Quotation',
                    isCompleted: _formCompletion['Quotation']!,
                    onPressed: () => _switchForm('Quotation'),
                  ),
                  _buildFormButton(
                    icon: Icons.receipt,
                    label: AppLocalizations.of(context)!.translate('invoice')!,
                    isActive: _activeForm == 'Invoice',
                    isCompleted: _formCompletion['Invoice']!,
                    onPressed: () => _switchForm('Invoice'),
                  ),
                ],
              ),
              SizedBox(height: 20),
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

  Widget _buildFormButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required bool isCompleted,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isActive ? Colors.blueAccent : Colors.grey.shade400,
            padding: EdgeInsets.symmetric(vertical: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 50, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    label,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              if (isCompleted)
                Positioned(
                  top: -10,
                  right: -10,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20,
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
      case 'Form Request':
        return _buildFormRequest();
      case 'Quotation':
        return _buildQuotation();
      case 'Invoice':
        return _buildInvoice();
      default:
        return Container();
    }
  }

  Widget _buildFormRequest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () => _pickImage('Form Request'),
          icon: Icon(Icons.camera_alt),
          label: Text(AppLocalizations.of(context)!.translate('upload_image')!),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: EdgeInsets.symmetric(vertical: 14),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        if (_formRequestImage != null) Image.file(_formRequestImage!),
        SizedBox(height: 10),
        _buildDropdown(
          label: AppLocalizations.of(context)!.translate('used_at')!,
          value: _selectedUsedAt,
          items: _usedAtOptions,
          onChanged: (value) {
            setState(() {
              _selectedUsedAt = value;
            });
          },
        ),
        SizedBox(height: 10),
        _buildDropdown(
          label: AppLocalizations.of(context)!.translate('company')!,
          value: _selectedCompany,
          items: _companyOptions,
          onChanged: (value) {
            setState(() {
              _selectedCompany = value;
            });
          },
        ),
        ElevatedButton(
          onPressed: () => _toggleCompletion('Form Request'),
          child:
              Text(AppLocalizations.of(context)!.translate('mark_incomplete')!),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 14),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ],
    );
  }

  Widget _buildQuotation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () => _pickImage('Quotation'),
          icon: Icon(Icons.camera_alt),
          label: Text(AppLocalizations.of(context)!.translate('upload_image')!),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: EdgeInsets.symmetric(vertical: 14),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        if (_quotationImage != null) Image.file(_quotationImage!),
        ElevatedButton(
          onPressed: () => _toggleCompletion('Quotation'),
          child:
              Text(AppLocalizations.of(context)!.translate('mark_complete')!),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 14),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildInvoice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () => _pickImage('Invoice'),
          icon: Icon(Icons.camera_alt),
          label: Text(AppLocalizations.of(context)!.translate('upload_image')!),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: EdgeInsets.symmetric(vertical: 14),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        if (_invoiceImage != null) Image.file(_invoiceImage!),
        ElevatedButton(
          onPressed: () => _toggleCompletion('Invoice'),
          child:
              Text(AppLocalizations.of(context)!.translate('mark_incomplete')!),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 14),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
