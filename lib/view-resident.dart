import 'package:design_patterns_project/Classes/Manager/Manager.dart';
import 'package:design_patterns_project/pages/resident_list/residentDetails.dart';
import 'package:flutter/material.dart';

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
        title: Text(
          'Resident List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, Map<String, dynamic>>>(
        future: widget.manager.residentViewer.viewResidents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
              ),
            );
          }

          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No residents found.',
                style: TextStyle(fontSize: 16, color: Colors.redAccent),
              ),
            );
          }

          final residents = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: residents.length,
            itemBuilder: (context, index) {
              final residentId = residents.keys.elementAt(index);
              final residentData = residents[residentId]!;
              return GestureDetector(
                onTap: () => _viewResidentDetails(residentId, residentData),
                child: _buildResidentCard(residentData),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildResidentCard(Map<String, dynamic> residentData) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.deepPurpleAccent.withOpacity(0.8),
          child: Text(
            residentData['name'][0].toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          residentData['name'],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          'Room: ${residentData['booking']['room']['id']}',
          style: TextStyle(color: Colors.grey[700], fontSize: 16),
        ),
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
}
