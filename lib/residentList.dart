import 'package:design_patterns_project/Database.dart';
import 'package:design_patterns_project/Resident.dart';
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
  Database database = Database.getInstance();
  @override
 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Residents',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      elevation: 0,
      centerTitle: true,
    ),
    body: FutureBuilder<Map<String, Map<String, dynamic>>>(
      future: widget.receptionist.viewResidents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
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
              child: _buildResidentCard(residentId, residentData),
            );
          },
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: _addResident,
      backgroundColor: Colors.deepPurpleAccent.withOpacity(0.8),
      child: Icon(Icons.add, size: 28, color: Colors.white),
      tooltip: 'Add Resident',
    ),
  );
}

Widget _buildResidentCard(String residentId, Map<String, dynamic> residentData) {
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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            shape: CircleBorder(),
            color: Colors.blueAccent.withOpacity(0.1),
            child: IconButton(
              icon: Icon(Icons.edit, color: Colors.blueAccent, size: 30),
              onPressed: () => _editResident(residentId, residentData),
              tooltip: 'Edit Resident',
              padding: EdgeInsets.all(8),
              splashRadius: 28,
              splashColor: Colors.blueAccent.withOpacity(0.3),
            ),
          ),
          SizedBox(width: 10),
          Material(
            shape: CircleBorder(),
            color: Colors.redAccent.withOpacity(0.1),
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent, size: 30),
              onPressed: () => _deleteResident(residentId),
              tooltip: 'Delete Resident',
              padding: EdgeInsets.all(8),
              splashRadius: 28,
              splashColor: Colors.redAccent.withOpacity(0.3),
            ),
          ),
        ],
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

  void _editResident(String id, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditResidentPage(
            residentId: id, data: data, receptionist: widget.receptionist),
      ),
    ).then((_) => setState(() {}));
  }

  void _deleteResident(String id) async {
    print(id);
    Map<dynamic, dynamic> room =
        await database.readData('residents/${id}/booking/room');

    setState(() {
      Map<String, dynamic> updateData = {'occupied': false};
      database.updateData('Rooms/${room['id']}', updateData);
      widget.receptionist.deleteResident(id);
    });
  }

  void _addResident() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddResidentPage(receptionist: widget.receptionist),
      ),
    ).then((_) => setState(() {}));
  }
}
