import 'package:design_patterns_project/Database.dart';
import 'package:flutter/material.dart';

class BookingDetails extends StatefulWidget {
  final String residentId;

  BookingDetails({required this.residentId});

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  List<String>? bookingDetails; // Store the booking details
  bool isLoading = true; // Track if the data is still being fetched

  @override
  void initState() {
    super.initState();
    // Fetch booking details
    fetchBookingDetails();
  }

  Future<void> fetchBookingDetails() async {
    try {
      List<String> details = await fetchRoomNumberById(widget.residentId);
      setState(() {
        bookingDetails = details;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching booking details: $e');
      setState(() {
        bookingDetails = [];
        isLoading = false;
      });
    }
  }

  Future<List<String>> fetchRoomNumberById(String id) async {
    Database database = Database.getInstance();
    String residentsPath = 'residents';

    try {
      // Read all residents, cast the returned map safely
      Map<Object?, Object?> residentsRaw = await database.readData(residentsPath);
      Map<String, dynamic> residents = residentsRaw.cast<String, dynamic>();

      // Find the resident with the matching id, safely cast each resident's data
      String? residentKey = residents.keys.firstWhere(
            (key) => (residents[key] as Map<Object?, Object?>)['id'] == id,
      );

      // If the residentKey is null, return an empty list
      if (residentKey == null) {
        print('Resident not found');
        return [];
      }

      // Safely cast booking data to Map<String, dynamic>
      Map<Object?, Object?> bookingRaw = residents[residentKey]['Booking'];
      Map<String, dynamic> booking = bookingRaw.cast<String, dynamic>();

      // Fetch booking details
      dynamic roomNum = booking['roomNum'];
      dynamic roomType = booking['roomType'];
      dynamic durationOfStay = booking['durationOfStay'];
      dynamic boardingOption = booking['boardingOption'];

      print('Booking found:');
      print('Room Number: $roomNum');

      // Construct the list of booking details
      return [
        roomNum?.toString() ?? "Room number not found",
        roomType ?? "Room type not found",
        durationOfStay?.toString() ?? "Duration of stay not found",
        boardingOption ?? "Boarding option not found",
      ];
    } catch (e) {
      print('Error fetching booking details: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Details"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : bookingDetails == null || bookingDetails!.isEmpty
          ? Center(
        child: Text(
          "No booking details found.",
          style: TextStyle(fontSize: 16),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Resident ID: ${widget.residentId}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.room),
              title: Text("Room Number"),
              subtitle: Text(bookingDetails![0]),
            ),
            ListTile(
              leading: Icon(Icons.bed),
              title: Text("Room Type"),
              subtitle: Text(bookingDetails![1]),
            ),
            ListTile(
              leading: Icon(Icons.timelapse),
              title: Text("Duration of Stay"),
              subtitle: Text(bookingDetails![2]),
            ),
            ListTile(
              leading: Icon(Icons.restaurant),
              title: Text("Boarding Option"),
              subtitle: Text(bookingDetails![3]),
            ),
          ],
        ),
      ),
    );
  }
}
