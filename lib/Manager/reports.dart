import 'package:flutter/material.dart';
import 'package:flutter_sales_graph/flutter_sales_graph.dart';
import 'Manager.dart'; // Import your Manager class

class IncomeReportPage extends StatefulWidget {
  final Manager manager;

  const IncomeReportPage({Key? key, required this.manager}) : super(key: key);

  @override
  _IncomeReportPageState createState() => _IncomeReportPageState();
}

class _IncomeReportPageState extends State<IncomeReportPage> {
  String selectedReportType = 'Weekly'; // Default selection
  String reportResult = ''; // Report result to display
  late Map<String, dynamic> report = {};
  late double Barwidth = 0;

  // List<double> salesData = [];
  // List<String> labels = [];

  @override
  void initState() {
    super.initState();
    fetchIncomeReport(); // Fetch initial data
  }

  void fetchIncomeReport() async {
    try {
     
      switch (selectedReportType) {
        case 'Weekly':
          report = await widget.manager.getWeeklyReport();
          print(report['labels']);
          print(report['dataSales']);
          Barwidth = 40;
          reportResult = 'Weekly Report Generated';
          break;
        case 'Monthly':
          report = await widget.manager.getMonthlyReport();
          Barwidth = 2.96;
          reportResult = 'Monthly Report Generated';
          break;
        case 'Annual':
          report = await widget.manager.getAnnualReport();
          Barwidth = 20;
          reportResult = 'Annual Report Generated';
          break;
      }

      setState(() {});
    } catch (e) {
      print("Error fetching income report: $e");
      reportResult = 'Error generating report';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Income Report'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedReportType,
              items: ['Weekly', 'Monthly', 'Annual'].map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedReportType = newValue;
                  });
                  fetchIncomeReport();
                }
              },
            ),
          ),
          if (report.isNotEmpty)
            FlutterSalesGraph(
              salesData: report['dataSales'],
              labels: report['labels'],
              maxBarHeight: 200,
              barWidth: Barwidth,
              colors: const [Colors.blue, Colors.green, Colors.red],
              dateLineHeight: 25,
            ),
          // else
          //   const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
