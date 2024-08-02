import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final List<Map<String, dynamic>> data = [
    {
      'ID': 1,
      'Company': 'KC',
      'Date': '2024-07-01',
      'Status': 'Paid',
      'Currency': 'USD',
      'Total': 1200
    },
    {
      'ID': 2,
      'Company': 'SME',
      'Date': '2024-07-02',
      'Status': 'Pending',
      'Currency': 'Riel',
      'Total': 300
    },
    {
      'ID': 3,
      'Company': 'HK',
      'Date': '2024-07-03',
      'Status': 'Paid',
      'Currency': 'USD',
      'Total': 1500
    },
    {
      'ID': 4,
      'Company': 'KCM',
      'Date': '2024-07-04',
      'Status': 'Pending',
      'Currency': 'Riel',
      'Total': 800
    },
  ];

  final int _rowsPerPage = 5;
  int _currentPage = 0;
  String _selectedFilter = 'Today';

  // Assuming exchange rates
  final double _usdToRealRate = 4000.0; // 1 USD = 4000 REAL

  double getTotalAmount(String currency) {
    return data
        .where((item) => item['Currency'] == currency)
        .fold(0.0, (sum, item) => sum + item['Total']);
  }

  double getTotalAmountInUSD() {
    double totalInUSD = 0.0;
    for (var item in data) {
      if (item['Currency'] == 'USD') {
        totalInUSD += item['Total'];
      } else if (item['Currency'] == 'Reil') {
        totalInUSD += item['Total'] / _usdToRealRate;
      }
      // Add more currencies and conversions if needed
    }
    return totalInUSD;
  }

  double getTotalAmountInRiel() {
    return data
        .where((item) => item['Currency'] == 'Riel')
        .fold(0.0, (sum, item) => sum + item['Total']);
  }

  int getTotalCount() {
    return data.length;
  }

  Future<void> exportToPdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.Text('Bar Chart Data', style: pw.TextStyle(fontSize: 24)),
                pw.Table.fromTextArray(
                  data: [
                    ['Label', 'Value'],
                    ...data.map((item) => [item['Company'], item['Total']]),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
    final outputFile = await _getOutputFile('chart_data.pdf');
    final file = File(outputFile);
    await file.writeAsBytes(await pdf.save());
  }

  Future<void> exportToExcel() async {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];
    sheet.appendRow(['ID', 'Company', 'Date', 'Status', 'Currency', 'Total']);
    for (var item in data) {
      sheet.appendRow([
        item['ID'],
        item['Company'],
        item['Date'],
        item['Status'],
        item['Currency'],
        item['Total']
      ]);
    }
    final outputFile = await _getOutputFile('chart_data.xlsx');
    final file = File(outputFile);
    await file.writeAsBytes(excel.encode()!);
  }

  Future<String> _getOutputFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$fileName';
  }

  @override
  Widget build(BuildContext context) {
    final totalAmountUSD = getTotalAmountInUSD();
    final totalAmountREAL = getTotalAmountInRiel();
    final totalCount = getTotalCount();

    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: exportToPdf,
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: exportToExcel,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 12, 3, 151)!,
              Color.fromARGB(255, 1, 30, 160)!
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DropdownButton<String>(
                    value: _selectedFilter,
                    items: <String>[
                      'Today',
                      'Yesterday',
                      'Last Week',
                      'Last Month'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedFilter = newValue!;
                      });
                      // TODO: Implement data filtering logic based on _selectedFilter
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatCard('Payment Voucher', '1200', Colors.blue),
                      _buildStatCard('Advance Request', '300', Colors.orange),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[800],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Total by Company',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 200,
                          padding: const EdgeInsets.all(8.0),
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY: 2000,
                              barTouchData: BarTouchData(enabled: false),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 30,
                                    getTitlesWidget: (value, meta) {
                                      switch (value.toInt()) {
                                        case 0:
                                          return Text(
                                            'KC',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          );
                                        case 1:
                                          return Text(
                                            'SME',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          );
                                        case 2:
                                          return Text(
                                            'HK',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          );
                                        case 3:
                                          return Text(
                                            'KCM',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          );
                                        default:
                                          return Text('');
                                      }
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              barGroups: [
                                BarChartGroupData(
                                  x: 0,
                                  barRods: [
                                    BarChartRodData(
                                        toY: 1200, color: Colors.blue),
                                  ],
                                ),
                                BarChartGroupData(
                                  x: 1,
                                  barRods: [
                                    BarChartRodData(
                                        toY: 300, color: Colors.orange),
                                  ],
                                ),
                                BarChartGroupData(
                                  x: 2,
                                  barRods: [
                                    BarChartRodData(
                                        toY: 1500, color: Colors.green),
                                  ],
                                ),
                                BarChartGroupData(
                                  x: 3,
                                  barRods: [
                                    BarChartRodData(
                                        toY: 800, color: Colors.red),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[800],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Total Payments',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Total Count: $totalCount',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          'Total USD: \$${totalAmountUSD.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          'Total Riel: ៛${totalAmountREAL.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: [
                              DataColumn(
                                  label: Text('ID',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: Text('Company',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: Text('Date',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: Text('Status',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: Text('Currency',
                                      style: TextStyle(color: Colors.white))),
                              DataColumn(
                                  label: Text('Total',
                                      style: TextStyle(color: Colors.white))),
                            ],
                            rows: data
                                .skip(_currentPage * _rowsPerPage)
                                .take(_rowsPerPage)
                                .map((item) => DataRow(
                                      cells: [
                                        DataCell(Text(item['ID'].toString(),
                                            style: TextStyle(
                                                color: Colors.white))),
                                        DataCell(Text(item['Company'],
                                            style: TextStyle(
                                                color: Colors.white))),
                                        DataCell(Text(item['Date'],
                                            style: TextStyle(
                                                color: Colors.white))),
                                        DataCell(Text(item['Status'],
                                            style: TextStyle(
                                                color: Colors.white))),
                                        DataCell(Text(item['Currency'],
                                            style: TextStyle(
                                                color: Colors.white))),
                                        DataCell(Text(item['Total'].toString(),
                                            style: TextStyle(
                                                color: Colors.white))),
                                      ],
                                    ))
                                .toList(),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios,
                                  color: Colors.white),
                              onPressed: _currentPage > 0
                                  ? () {
                                      setState(() {
                                        _currentPage--;
                                      });
                                    }
                                  : null,
                            ),
                            Text(
                              'Page ${_currentPage + 1}',
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios,
                                  color: Colors.white),
                              onPressed: (_currentPage + 1) * _rowsPerPage <
                                      data.length
                                  ? () {
                                      setState(() {
                                        _currentPage++;
                                      });
                                    }
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
