import 'package:design_patterns_project/Manager/Manager.dart';
import 'package:flutter/material.dart';
//import 'Resident.dart';
import 'Receptionist.dart';
import 'residentDetails.dart';


class viewResidentListPage extends StatefulWidget {
  final Manager manager;

  viewResidentListPage({required this.manager});

  @override
  _viewResidentListPageState createState() => _viewResidentListPageState();
}

class _viewResidentListPageState extends State<viewResidentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' View Resident List'),
      ),
      body: FutureBuilder<Map<String, Map<String, dynamic>>>(
        future: widget.manager.residentViewer.viewResidents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No residents found.'));
          }
          final residents = snapshot.data!;
          return ListView(
            children: residents.entries.map((entry) {
              final residentId = entry.key;
              final residentData = entry.value;
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text('${residentData['name']}'),
                  subtitle: Text('Room: ${residentData['booking']['room']['id']}'),
                ),
              );
            }).toList(),
          );
        },
      ),

    );
  }




}