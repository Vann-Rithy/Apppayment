// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class StatisticsPage extends StatefulWidget {
//   @override
//   _StatisticsPageState createState() => _StatisticsPageState();
// }

// class _StatisticsPageState extends State<StatisticsPage> {
//   int _currentPage = 0;
//   int _rowsPerPage = 10;

//   List<Map<String, dynamic>> getFilteredData() {
//     // Your data filtering logic
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey[900],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Statistics',
//                   style: TextStyle(fontSize: 32, color: Colors.white),
//                 ),
//                 SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildStatCard('Total USD', '1200', Colors.blue),
//                     _buildStatCard('Total Riel', '4,800,000', Colors.green),
//                     _buildStatCard('Total Count', '50', Colors.red),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.blueGrey[700],
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         Text(
//                           'Bar Chart',
//                           style: TextStyle(fontSize: 20, color: Colors.white),
//                         ),
//                         SizedBox(height: 16),
//                         SizedBox(
//                           height: 200,
//                           child: BarChart(
//                             BarChartData(
//                               alignment: BarChartAlignment.spaceAround,
//                               maxY: 2000,
//                               titlesData: FlTitlesData(
//                                 show: true,
//                                 rightTitles: AxisTitles(
//                                     sideTitles: SideTitles(showTitles: false)),
//                                 topTitles: AxisTitles(
//                                     sideTitles: SideTitles(showTitles: false)),
//                                 bottomTitles: AxisTitles(
//                                   sideTitles: SideTitles(
//                                     showTitles: true,
//                                     getTitles: (value) {
//                                       switch (value.toInt()) {
//                                         case 0:
//                                           return 'Q1';
//                                         case 1:
//                                           return 'Q2';
//                                         case 2:
//                                           return 'Q3';
//                                         case 3:
//                                           return 'Q4';
//                                       }
//                                       return '';
//                                     },
//                                   ),
//                                 ),
//                                 leftTitles: AxisTitles(
//                                   sideTitles: SideTitles(
//                                     showTitles: true,
//                                     interval: 500,
//                                     getTitles: (value) {
//                                       return value.toInt().toString();
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               borderData: FlBorderData(show: false),
//                               barGroups: [
//                                 _makeGroupData(0, 1200),
//                                 _makeGroupData(1, 800),
//                                 _makeGroupData(2, 1500),
//                                 _makeGroupData(3, 500),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 16),
//                         Container(
//                           padding: const EdgeInsets.all(16.0),
//                           decoration: BoxDecoration(
//                             color: Colors.blueGrey[700],
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             children: [
//                               Text(
//                                 'Data Table',
//                                 style: TextStyle(
//                                     fontSize: 20, color: Colors.white),
//                               ),
//                               SizedBox(height: 16),
//                               DataTable(
//                                 columns: const <DataColumn>[
//                                   DataColumn(
//                                     label: Text('ID',
//                                         style: TextStyle(color: Colors.white)),
//                                   ),
//                                   DataColumn(
//                                     label: Text('Company',
//                                         style: TextStyle(color: Colors.white)),
//                                   ),
//                                   DataColumn(
//                                     label: Text('Date',
//                                         style: TextStyle(color: Colors.white)),
//                                   ),
//                                   DataColumn(
//                                     label: Text('Status',
//                                         style: TextStyle(color: Colors.white)),
//                                   ),
//                                   DataColumn(
//                                     label: Text('Currency',
//                                         style: TextStyle(color: Colors.white)),
//                                   ),
//                                   DataColumn(
//                                     label: Text('Total',
//                                         style: TextStyle(color: Colors.white)),
//                                   ),
//                                 ],
//                                 rows: getFilteredData()
//                                     .skip(_currentPage * _rowsPerPage)
//                                     .take(_rowsPerPage)
//                                     .map(
//                                       (item) => DataRow(
//                                         cells: <DataCell>[
//                                           DataCell(Text(item['ID'].toString(),
//                                               style: TextStyle(
//                                                   color: Colors.white))),
//                                           DataCell(Text(item['Company'],
//                                               style: TextStyle(
//                                                   color: Colors.white))),
//                                           DataCell(Text(item['Date'],
//                                               style: TextStyle(
//                                                   color: Colors.white))),
//                                           DataCell(Text(item['Status'],
//                                               style: TextStyle(
//                                                   color: Colors.white))),
//                                           DataCell(Text(item['Currency'],
//                                               style: TextStyle(
//                                                   color: Colors.white))),
//                                           DataCell(Text(
//                                               item['Total'].toString(),
//                                               style: TextStyle(
//                                                   color: Colors.white))),
//                                         ],
//                                       ),
//                                     )
//                                     .toList(),
//                               ),
//                               SizedBox(height: 16),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   IconButton(
//                                     icon: Icon(Icons.arrow_back,
//                                         color: Colors.white),
//                                     onPressed: _currentPage > 0
//                                         ? () {
//                                             setState(() {
//                                               _currentPage--;
//                                             });
//                                           }
//                                         : null,
//                                   ),
//                                   Text(
//                                     'Page ${_currentPage + 1}',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   IconButton(
//                                     icon: Icon(Icons.arrow_forward,
//                                         color: Colors.white),
//                                     onPressed:
//                                         (_currentPage + 1) * _rowsPerPage <
//                                                 getFilteredData().length
//                                             ? () {
//                                                 setState(() {
//                                                   _currentPage++;
//                                                 });
//                                               }
//                                             : null,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatCard(String title, String value, MaterialColor color) {
//     return Container(
//       width: 150,
//       padding: EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 8,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontSize: 18, color: Colors.white),
//           ),
//           SizedBox(height: 8),
//           Text(
//             value,
//             style: TextStyle(
//                 fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }

//   BarChartGroupData _makeGroupData(int x, double y) {
//     return BarChartGroupData(
//       x: x,
//       barRods: [
//         BarChartRodData(
//           toY: y,
//           color: Colors.blue,
//           width: 15,
//           borderRadius: BorderRadius.circular(0),
//           backDrawRodData: BackgroundBarChartRodData(
//             show: true,
//             toY: 2000,
//             color: Colors.grey[300],
//           ),
//         ),
//       ],
//     );
//   }
// }
