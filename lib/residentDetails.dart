import 'package:flutter/material.dart';

class ResidentDetailsPage extends StatelessWidget {
  final String residentId;
  final Map<String, dynamic> data;

  ResidentDetailsPage({required this.residentId, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Worker Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(' ${data['name']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Phone: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(' ${data['phone']}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Booking Details: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Check In Date: ${data['booking']['checkInDate'].split('T')[0]}', style: TextStyle(fontSize: 18)),
            Text('Check Out Date: ${data['booking']['checkOutDate'].split('T')[0]}', style: TextStyle(fontSize: 18)),
            Text('Boarding Type: ${data['booking']['boarding']['name']}', style: TextStyle(fontSize: 18)),
            Text('Room Type: ${data['booking']['room']['roomType']}', style: TextStyle(fontSize: 18)),
            Text('Room Number: ${data['booking']['room']['id']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Email: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(' ${data['email']}', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}