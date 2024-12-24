import 'package:flutter/material.dart';
import 'package:design_patterns_project/Classes/worker.dart';

class WorkerDetailsPage extends StatelessWidget {
  final Worker worker;

  WorkerDetailsPage({required this.worker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Worker Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.deepPurpleAccent.withOpacity(0.8),
                      child: Text(
                        worker.name[0].toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          worker.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          worker.jobTitle,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Divider(thickness: 1.2),
                SizedBox(height: 8),
                Text(
                  'Phone: ${worker.phone}',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                SizedBox(height: 6),
                Text(
                  'Salary: ${worker.salary}',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
