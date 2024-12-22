import 'package:design_patterns_project/Receptionist.dart';
import 'package:design_patterns_project/ResidentManagement.dart';
import 'package:design_patterns_project/resident_list/BookingDetails.dart';
import 'package:design_patterns_project/resident_list/addResident.dart';
import 'package:flutter/material.dart';
import 'package:design_patterns_project/Resident.dart';
import 'package:design_patterns_project/calc-cost/Booking.dart';
import 'package:design_patterns_project/abstract_room.dart';
import 'package:design_patterns_project/Abstract Boarding Option/AbstractBoardingOption.dart';
import 'package:design_patterns_project/Abstract Boarding Option/BoardingOptionFactory.dart';
import '../Database.dart';

class ResidentListScreen extends StatefulWidget {
  final Map<String, dynamic> residentData;
  ResidentListScreen({required this.residentData});
  @override
  _ResidentListScreenState createState() => _ResidentListScreenState();
}

class _ResidentListScreenState extends State<ResidentListScreen> {
  late ResidentManagement management;

  //  late Receptionist management = ;
  @override
  void initState() {
    super.initState();
    management = ResidentManagement();
    int roomNum = int.parse(widget.residentData['selectedRoom']);
    int id = int.parse(widget.residentData['id']);
    int duration = int.parse(widget.residentData['durationOfStay']);

    AbstractRoom room =
        RoomFactory.createRoom(widget.residentData['roomType'], roomNum);
    AbstractBoardingOption option = Boardingoptionfactory.CreateBoardingOption(
        widget.residentData['boardingOption']);
    Booking booking = Booking(id, duration, room, option);

    Resident resident = Resident(
      id: widget.residentData['id'],
      name: widget.residentData['name'],
      email: widget.residentData['email'],
      phone: widget.residentData['phone'],
      booking: booking,
    );
    management.addResident(resident);

    // Add to static list of residents
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resident List"),
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView.builder(
          itemCount: ResidentManagement.listOfResidents.length,
          itemBuilder: (context, index) {
            Resident resident =
                ResidentManagement.listOfResidents.values.elementAt(index);
            AbstractRoom room = resident.booking!.room;
            AbstractBoardingOption option = resident.booking!.boardingOption;
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: InkWell(
                onTap: () async {
                  final updatedResident = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddResidentScreen(
                          resident: {
                            'name': resident.getName(),
                            'id': resident.getId(),
                            'email': resident.getEmail(),
                            'roomType': room.getRoomType(),
                            'selectedRoom':
                                resident.booking!.room.roomNumber.toString(),
                            'boardingOption': option.getMealPlan(),
                            'durationOfStay':
                                resident.booking!.DurationOfStay.toString(),
                            'phone': resident.getPhone(),
                          },
                        ),
                      ));
                  if (updatedResident != null) {
                    setState(() {
                      management.editResident(
                        Resident(
                          id: updatedResident['id'],
                          name: updatedResident['name'],
                          email: updatedResident['email'],
                          phone: updatedResident['phone'],
                        ),
                        (resident.getId() ?? 'N/A'),
                      );
                    });
                  }
                },
                onLongPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BookingDetails(
                            residentId: resident.getId() ??
                                " ") // Replace with your target page
                        ),
                  );
                },

                borderRadius:
                    BorderRadius.circular(16.0), // Matches card's border radius
                child: Card(
                  elevation: 6.0,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildResidentTitle(
                          resident.getName() ?? "N/A",
                          resident.getEmail() ?? "N/A",
                          resident.getId() ?? "N/A",
                        ),
                        const Divider(color: Colors.grey),
                        // Divider between title and details
                        _buildResidentInfoRow(
                          Icons.person,
                          "ID",
                          resident.getId()?.toString() ?? "N/A",
                        ),
                        _buildResidentInfoRow(
                          Icons.phone,
                          "Phone",
                          resident.getPhone() ?? "N/A",
                        ),
                        // _buildResidentInfoRow(
                        //   Icons.meeting_room,
                        //   "Room Type",
                        //   room.getRoomType(),
                        // ),
                        // _buildResidentInfoRow(
                        //   Icons.room_preferences,
                        //   "Room Number",
                        //   resident.booking!.room.roomNumber.toString(),
                        // ),
                        // _buildResidentInfoRow(
                        //   Icons.restaurant_menu,
                        //   "Boarding Option",
                        //   option.getMealPlan(),
                        // ),
                        // _buildResidentInfoRow(
                        //   Icons.calendar_today,
                        //   "Duration of Stay",
                        //   "${resident.booking!.DurationOfStay} days",
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // fetchResidents();
          printList(ResidentManagement.listOfResidents);
          final newResidentData = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddResidentScreen(),
            ),
          );

          if (newResidentData != null) {
            setState(() {
              int roomNum = int.parse(newResidentData['selectedRoom']);
              int id = ResidentManagement.listOfResidents.length +
                  1; // Increment ID based on existing list
              int duration = int.parse(newResidentData['durationOfStay']);

              AbstractRoom room =
                  RoomFactory.createRoom(newResidentData['roomType'], roomNum);
              AbstractBoardingOption option =
                  Boardingoptionfactory.CreateBoardingOption(
                      newResidentData['boardingOption']);
              Booking booking = Booking(id, duration, room, option);

              Resident newResident = Resident(
                id: id.toString(),
                name: newResidentData['name'],
                email: newResidentData['email'],
                phone: newResidentData['phone'],
                booking: booking,
              );

              management.addResident(newResident);
              late Receptionist receptionist =
                  Receptionist("Receptionist", "123", "receptionist");
              receptionist.assignRoom(
                  roomNum, newResidentData['roomType'].toString(), newResident);
            });
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  void printList(Map<String, Resident> list) {
    int count = 0;
    list.forEach((key, resident) {
      print('Key: $key, Resident: ${resident.getName()}}');
      count++;
      print(count);
    });
  }

  Widget _buildResidentTitle(String name, String email, String id) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
              SizedBox(height: 4),
              Text(
                email,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.delete, size: 40.0, color: Colors.red),
          onPressed: () {
            setState(() {
              management.deleteResident(id);
            });
            print("Deleted resident with ID: $id");
          },
        ),
      ],
    );
  }

  Widget _buildResidentInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 20),
          SizedBox(width: 10),
          Expanded(
              child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$title: ", // Title
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "  ",
                  // Adds a fixed amount of space between the title and value
                  style: TextStyle(fontSize: 16), // Optional
                ),
                TextSpan(
                  text: value, // Value
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87, // Value color
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  void fetchResidents() async {
    final database = Database.getInstance();
    final residents = await database.readData("residents");

    if (residents.isNotEmpty) {
      print("Residents Data: $residents");
    } else {
      print("No residents found!");
    }
  }
}
