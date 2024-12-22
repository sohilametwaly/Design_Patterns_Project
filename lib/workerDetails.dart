import 'package:flutter/material.dart';
import 'package:design_patterns_project/worker.dart';


class WorkerDetailsPage extends StatelessWidget {
  final Worker worker;

  WorkerDetailsPage({required this.worker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Worker Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: ${worker.name}', style: TextStyle(fontSize: 20)),
            Text('Job Title: ${worker.jobTitle}', style: TextStyle(fontSize: 20)),
            Text('Phone: ${worker.phone}', style: TextStyle(fontSize: 20)),
            Text('Salary: ${worker.salary}', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}