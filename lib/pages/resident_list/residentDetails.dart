import 'package:flutter/material.dart';

class ResidentDetailsPage extends StatelessWidget {
  final String residentId;
  final Map<String, dynamic> data;

  ResidentDetailsPage({required this.residentId, required this.data});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resident Details',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionCard(
              title: 'Personal Information',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Name', data['name']),
                  _buildDetailRow('Phone', data['phone']),
                  _buildDetailRow('Email', data['email']),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildSectionCard(
              title: 'Booking Details',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Check-In Date',
                      data['booking']['checkInDate']?.split('T')[0]),
                  _buildDetailRow('Check-Out Date',
                      data['booking']['checkOutDate']?.split('T')[0]),
                  _buildDetailRow(
                      'Boarding Type', data['booking']['boarding']['name']),
                  _buildDetailRow(
                      'Room Type', data['booking']['room']['roomType']),
                  _buildDetailRow('Room Number', data['booking']['room']['id']),
                  _buildDetailRow('Total Price', data['booking']['Total'])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget content}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent.withOpacity(0.8)),
            ),
            Divider(color: Colors.deepPurpleAccent.withOpacity(0.8)),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value?.toString() ?? 'N/A',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
