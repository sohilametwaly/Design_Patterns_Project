import 'package:design_patterns_project/Manager/Manager.dart';
import 'package:flutter/material.dart';
import 'Manager/RoomMonitoring.dart';
import 'package:flutter/material.dart';
import 'Database.dart';

class RoomListScreen extends StatefulWidget {
  @override
  _RoomListScreenState createState() => _RoomListScreenState();
  final Manager manager;
  RoomListScreen({required this.manager});
}

class _RoomListScreenState extends State<RoomListScreen> {
  String selectedRoomType = 'single';
  String selectedAvailability = 'All';

  dynamic roomsData;
  List<MapEntry> filteredRooms = [];

  @override
  void initState() {
    super.initState();
    loadRoomsData();
  }

  Future<void> loadRoomsData() async {
    Roommonitoring roommonitoring = await widget.manager.roomMonitor;
    try {
      final rooms = await roommonitoring.monitorRooms();
      if (rooms.isNotEmpty) {
        print("Rooms loaded successfully: $rooms");
        setState(() {
          roomsData = rooms;
          filterRooms();
        });
      } else {
        print("No rooms found");
      }
    } catch (e) {
      print("Errorrrr: $e");
    }
  }

  void filterRooms() {
    // print("Filtering rooms based on selected type: $selectedRoomType and availability: $selectedAvailability");
    setState(() {
      filteredRooms = roomsData.entries.where((entry) {
        bool matchesRoomType = entry.value['roomType'] == selectedRoomType;

        bool matchesAvailability = selectedAvailability == 'All' ||
            (selectedAvailability == 'Available' && !entry.value['occupied']) ||
            (selectedAvailability == 'Non-Available' &&
                entry.value['occupied']);

        return matchesRoomType && matchesAvailability;
      }).toList();
    });
    print(filteredRooms);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedRoomType,
              items: ['single', 'double', 'triple'].map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child:
                      Text(type.capitalize(), style: TextStyle(fontSize: 16)),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedRoomType = newValue!;
                  filterRooms();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedAvailability,
              items: ['All', 'Available', 'Non-Available'].map((String filter) {
                return DropdownMenuItem<String>(
                  value: filter,
                  child: Text(filter, style: TextStyle(fontSize: 16)),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedAvailability = newValue!;
                  filterRooms();
                });
              },
            ),
          ),
          Expanded(
            child: filteredRooms.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredRooms.length,
                    itemBuilder: (context, index) {
                      var room = filteredRooms[index];
                      var roomNumber = room.key;
                      var roomDetails = room.value;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey[300]!),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Room $roomNumber',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        roomDetails['occupied']
                                            ? Icons.close
                                            : Icons.check_circle,
                                        color: roomDetails['occupied']
                                            ? Colors.red
                                            : Colors.green,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        roomDetails['occupied']
                                            ? "Not Available"
                                            : "Available",
                                        style: TextStyle(
                                          color: roomDetails['occupied']
                                              ? Colors.red
                                              : Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(child: Text('No rooms available')),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
