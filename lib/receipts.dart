import 'package:flutter/material.dart';

// Define the Transaction model
class Transaction {
  final String date;
  final String description;
  final double amount;
  final String status;
  final String remarks;
  final List<History> history;

  Transaction({
    required this.date,
    required this.description,
    required this.amount,
    required this.status,
    this.remarks = '',
    this.history = const [],
  });
}

class History {
  final String date;
  final String details;

  History({required this.date, required this.details});
}

// Sample list of transactions, including "Rejected" transactions
final List<Transaction> transactions = [
  Transaction(
    date: '2024-07-01',
    description: 'Payment from KC GROUP',
    amount: 1200.0,
    status: 'Completed',
    history: [
      History(date: '2024-06-30', details: 'Invoice sent to KC GROUP'),
      History(date: '2024-07-01', details: 'Payment received from KC GROUP'),
    ],
  ),
  Transaction(
    date: '2024-07-02',
    description: 'Pending invoice for SME News',
    amount: 300.0,
    status: 'Pending',
    history: [
      History(date: '2024-07-01', details: 'Invoice sent to SME News'),
    ],
  ),
  Transaction(
    date: '2024-07-03',
    description: 'Payment for HK',
    amount: 1500.0,
    status: 'Completed',
    history: [
      History(date: '2024-07-02', details: 'Invoice sent to HK'),
      History(date: '2024-07-03', details: 'Payment received from HK'),
    ],
  ),
  Transaction(
    date: '2024-07-04',
    description: 'Pending invoice for KC Motor',
    amount: 800.0,
    status: 'Pending',
    history: [
      History(date: '2024-07-03', details: 'Invoice sent to KC Motor'),
    ],
  ),
  Transaction(
    date: '2024-07-05',
    description: 'Rejected payment for ABC Corp',
    amount: 500.0,
    status: 'Rejected',
    remarks: 'Insufficient funds',
    history: [
      History(date: '2024-07-04', details: 'Invoice sent to ABC Corp'),
      History(date: '2024-07-05', details: 'Payment rejected by ABC Corp'),
    ],
  ),
  Transaction(
    date: '2024-07-06',
    description: 'Rejected invoice for XYZ Ltd',
    amount: 250.0,
    status: 'Rejected',
    remarks: 'Incorrect account details',
    history: [
      History(date: '2024-07-05', details: 'Invoice sent to XYZ Ltd'),
      History(date: '2024-07-06', details: 'Invoice rejected by XYZ Ltd'),
    ],
  ),
];

class ReceiptsPage extends StatefulWidget {
  @override
  _ReceiptsPageState createState() => _ReceiptsPageState();
}

class _ReceiptsPageState extends State<ReceiptsPage> {
  String _searchQuery = '';
  List<Transaction> _filteredTransactions = transactions;

  void _filterTransactions(String query) {
    setState(() {
      _searchQuery = query;
      _filteredTransactions = transactions
          .where((transaction) => transaction.description
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blueAccent, Colors.blue],
              ),
            ),
          ),
          title: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Transaction',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) => _filterTransactions(value),
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon:
                              Icon(Icons.search, color: Colors.blueAccent),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.white),
                    onPressed: () {
                      // Add your filter action here
                    },
                    tooltip: 'Filter',
                  ),
                ],
              ),
            ),
          ),
          elevation: 0,
        ),
      ),
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
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _filteredTransactions.length,
          itemBuilder: (context, index) {
            final transaction = _filteredTransactions[index];
            Color statusColor;

            switch (transaction.status) {
              case 'Completed':
                statusColor = Colors.green;
                break;
              case 'Pending':
                statusColor = Colors.orange;
                break;
              case 'Rejected':
                statusColor = Colors.red;
                break;
              default:
                statusColor = Colors.grey; // Default color for unknown status
                break;
            }

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  transaction.description,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  '${transaction.date} - ${transaction.status}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                trailing: Text(
                  '\$${transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TransactionDetailPage(transaction: transaction),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class TransactionDetailPage extends StatelessWidget {
  final Transaction transaction;

  TransactionDetailPage({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.description,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Date: ${transaction.date}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Amount: \$${transaction.amount.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Status: ${transaction.status}',
                        style: TextStyle(
                          fontSize: 18,
                          color: _getStatusColor(transaction.status),
                        ),
                      ),
                      SizedBox(height: 8),
                      if (transaction.remarks.isNotEmpty)
                        Text(
                          'Remarks: ${transaction.remarks}',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'History:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Column(
                children: transaction.history.map((history) {
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(
                        history.details,
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        history.date,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Receipts App',
    home: ReceiptsPage(),
  ));
}
