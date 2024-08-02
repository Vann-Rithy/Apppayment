import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CheckRequestPage extends StatefulWidget {
  final int index;

  CheckRequestPage({required this.index});

  @override
  _CheckRequestPageState createState() => _CheckRequestPageState();
}

class _CheckRequestPageState extends State<CheckRequestPage> {
  String _remark = '';
  File? _imageFile;
  String _selectedForm = 'View';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Voucher #${widget.index}',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Color.fromARGB(255, 0, 36, 143),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 12, 3, 151),
              Color.fromARGB(255, 1, 30, 160),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailSection(),
                SizedBox(height: 16),
                _buildFormButtons(),
                SizedBox(height: 16),
                _buildDynamicForm(),
                SizedBox(height: 16),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Requested by:', 'VANN RITHY'),
            _buildDetailRow('Requested to:', 'Boss'),
            _buildDetailRow('Position of Requested by:', 'Dev'),
            _buildDetailRow('Position of Requested to:', 'CEO'),
            _buildDetailRow('Date:', '2024-06-28'),
            _buildDetailRow('Purpose:', 'Buy PC'),
            _buildDetailRow('Request For:', 'ក្រសួង'),
            _buildDetailRow('Total Expense:', '100\$'),
            ElevatedButton(
              onPressed: () => _showcommentOptions(),
              child: Text('comment'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 130, vertical: 10),
                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$title',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedForm = 'Form Request';
            });
          },
          child: Text('Request'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedForm = 'Quotation';
            });
          },
          child: Text('Quotation'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedForm = 'Invoice';
            });
          },
          child: Text('Invoice'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicForm() {
    switch (_selectedForm) {
      case 'Form Request':
        return _buildImageSection();
      case 'Quotation':
        return _buildQuotationForm();
      case 'Invoice':
        return _buildInvoiceForm();
      default:
        return _buildImageSection();
    }
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          child: Image.asset(
            'assets/logo/PAYMENT REQUEST_HK_FORM_Aug_2023.jpg',
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 8),
        TextButton(
          onPressed: () {
            _showFullScreenImage(
              'assets/logo/PAYMENT REQUEST_HK_FORM_Aug_2023.jpg',
            );
          },
          child: Text(
            'View Full Screen',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ],
    );
  }

  Widget _buildQuotationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          child: Image.asset(
            'assets/logo/quotation.jpg',
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 8),
        TextButton(
          onPressed: () {
            _showFullScreenImage('assets/logo/quotation.jpg');
          },
          child: Text(
            'View Full Screen',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ],
    );
  }

  Widget _buildInvoiceForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          child: Image.asset(
            'assets/logo/invoice.jpg',
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 8),
        TextButton(
          onPressed: () {
            _showFullScreenImage('assets/logo/invoice.jpg');
          },
          child: Text(
            'View Full Screen',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ],
    );
  }

  void _showFullScreenImage(String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Stack(
            children: [
              Center(child: Image.asset(imagePath, fit: BoxFit.contain)),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.black, size: 30),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => _showApproveOptions(),
          child: Text('Approve'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
          onPressed: () => _showRejectOptions(),
          child: Text('Reject'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _showApproveOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Approve Payment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.attach_money, color: Colors.green),
                title: Text('Paid by Cash'),
                onTap: () {
                  Navigator.pop(context);
                  _showRemarkDialog('Paid by Cash');
                },
              ),
              ListTile(
                leading: Icon(Icons.account_balance, color: Colors.blue),
                title: Text('Paid by Bank'),
                onTap: () {
                  Navigator.pop(context);
                  _showBankOptions();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBankOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Bank',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Image.asset('assets/logo/aba.png', width: 24),
                title: Text('ABA'),
                onTap: () {
                  Navigator.pop(context);
                  _showUploadImageDialog('Paid by Bank (ABA)');
                },
              ),
              ListTile(
                leading: Image.asset('assets/logo/acleda.png', width: 24),
                title: Text('ACLEDA'),
                onTap: () {
                  Navigator.pop(context);
                  _showUploadImageDialog('Paid by Bank (ACLEDA)');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUploadImageDialog(String paymentMethod) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Upload Transaction Image',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await _pickImage();
                },
                child: Text('Upload Image'),
              ),
              _imageFile != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.file(
                        _imageFile!,
                        height: 100,
                      ),
                    )
                  : Container(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showRemarkDialog(paymentMethod);
              },
              child: Text('Approve'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      // Upload or process the selected image as needed
      print('Image selected: ${_imageFile!.path}');
    }
  }

  void _showRemarkDialog(String paymentMethod) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remark',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          content: TextField(
            onChanged: (value) {
              setState(() {
                _remark = value;
              });
            },
            decoration: InputDecoration(hintText: 'Enter your remark here'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _approvePayment(paymentMethod);
              },
              child: Text('Approve'),
            ),
          ],
        );
      },
    );
  }

  void _approvePayment(String paymentMethod) {
    // Handle the approve action with the selected payment method and remark
    print('Approved with $paymentMethod, Remark: $_remark');
    if (_imageFile != null) {
      print('Image path: ${_imageFile!.path}');
    }
    // Perform any additional actions here
  }

  void _showRejectOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reject Payment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          content: TextField(
            onChanged: (value) {
              setState(() {
                _remark = value;
              });
            },
            decoration: InputDecoration(hintText: 'Enter your reason here'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the comment dialog
                _rejectPayment();
                _showSuccessPopup(); // Show the success popup
              },
              child: Text('Reject'),
            ),
          ],
        );
      },
    );
  }

  void _rejectPayment() {
    // Handle the reject action with the remark
    print('Rejected, Remark: $_remark');
    // Perform any additional actions here
  }

//opup Reject Done!
// Variables
  String _comment = '';

// Show Comment Dialog
  void _showcommentOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Comments Payment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          content: TextField(
            onChanged: (value) {
              setState(() {
                _remark = value;
              });
            },
            decoration: InputDecoration(hintText: 'Enter Your Comments'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the comment dialog
                _rejectPayment();
                _showSuccessPopup(); // Show the success popup
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

// Handle Comment Submission
  void _rejectcomment() {
    // Handle the reject action with the remark
    print('Rejected, Remark: $_remark');
    // Perform any additional actions here
  }

// Show Success Popup
  void _showSuccessPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 50,
          ),
          content: Text(
            'Your comment has been submitted successfully!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
