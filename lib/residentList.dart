import 'package:flutter/material.dart';
//import 'Resident.dart';
import 'Receptionist.dart';
import 'residentDetails.dart';
import 'addResident.dart';
import 'editResident.dart';

class ResidentListPage extends StatefulWidget {
  final Receptionist receptionist;

  ResidentListPage({required this.receptionist});

  @override
  _ResidentListPageState createState() => _ResidentListPageState();
}

class _ResidentListPageState extends State<ResidentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resident List'),
      ),
      body: FutureBuilder<Map<String, Map<String, dynamic>>>(
        future: widget.receptionist.viewResidents(),
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _editResident(residentId, residentData),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteResident(residentId),
                      ),
                    ],
                  ),
                  onTap: () => _viewResidentDetails(residentId, residentData),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addResident,
      ),
    );
  }

  void _viewResidentDetails(String id, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResidentDetailsPage(residentId: id, data: data),
      ),
    );
  }

  void _editResident(String id, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditResidentPage(residentId: id, data: data, receptionist: widget.receptionist),
      ),
    ).then((_) => setState(() {}));
  }

  void _deleteResident(String id) {
    setState(() {
      widget.receptionist.deleteResident(id);
    });
  }

  void _addResident() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddResidentPage(receptionist: widget.receptionist),
      ),
    ).then((_) => setState(() {}));
  }
}