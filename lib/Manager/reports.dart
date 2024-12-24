import 'package:flutter/material.dart';
import 'package:flutter_sales_graph/flutter_sales_graph.dart';
import 'package:design_patterns_project/Manager/Manager.dart';

class ManagerChart extends StatefulWidget {
  const ManagerChart({super.key, required this.manager});
  final Manager manager;

  @override
  _ManagerChartState createState() => _ManagerChartState();
}

class _ManagerChartState extends State<ManagerChart> {
  String selectedReport = "weekly"; // Default report type
  double totalIncome = 0.0; // To store the total income for the selected report
  bool isLoading = false; // To handle loading state

  @override
  void initState() {
    super.initState();
    _fetchReport(); // Fetch the default report (weekly) on widget initialization
  }

  Future<void> _fetchReport() async {
    setState(() {
      isLoading = true;
    });

    try {
      switch (selectedReport) {
        case 'weekly':
          widget.manager.getWeeklyReport();
          break;
        case 'monthly':
          widget.manager.getMonthlyReport();
          break;
        case 'annual':
          widget.manager.getAnnualReport();
          break;
      }

      // Update the totalIncome based on the selected report
      setState(() {
        // totalIncome = widget.manager.totalIncome; // Assuming `totalIncome` is accessible
      });
    } catch (e) {
      print("Error fetching $selectedReport report: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Income Tracker"),
      ),
      body: Column(
        children: [
          // Dropdown to select report type
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: selectedReport,
              items: ['weekly', 'monthly', 'annual'].map((String report) {
                return DropdownMenuItem<String>(
                  value: report,
                  child: Text(report.capitalizeFirst()),
                );
              }).toList(),
              onChanged: (String? newReport) {
                if (newReport != null && newReport != selectedReport) {
                  setState(() {
                    selectedReport = newReport;
                  });
                  _fetchReport(); // Fetch new report data
                }
              },
            ),
          ),

          //  Loading indicator or chart
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Total Income for $selectedReport report: \$${totalIncome.toStringAsFixed(2)}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          // Placeholder for future graphs or additional data
          Expanded(
            child: Center(
              child: Text(
                "Graph or additional data can be displayed here.",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalizeFirst() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
