import 'package:design_patterns_project/Classes/factory/boardingStrategyFactory/CostCalculationFactory.dart';
import 'package:design_patterns_project/Classes/Receptionist.dart';
import 'package:design_patterns_project/Classes/Strategy/roomStrategy/RoomStrategy.dart';
import 'package:design_patterns_project/Classes/factory/roomCostStrategyFactory/RoomStrategyFactory.dart';
import 'package:design_patterns_project/Classes/Strategy/boardingStrategy/CostCalculationStrategy.dart';
import 'package:flutter/material.dart';
import '../../Classes/Resident.dart';
import '../../Classes/Booking.dart';
import '../../Classes/room.dart';
import '../../Classes/factory/boardingFactory/BoardingOptionFactory.dart';

class AddResidentPage extends StatefulWidget {
  final Receptionist receptionist;

  AddResidentPage({required this.receptionist});

  @override
  _AddResidentPageState createState() => _AddResidentPageState();
}

class _AddResidentPageState extends State<AddResidentPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final roomTypeController = TextEditingController();
    final boardingOptionController = TextEditingController();
    DateTime? checkInDate;
    DateTime? checkOutDate;

    final checkInController =
        TextEditingController(); // Add controllers for check-in and check-out dates
    final checkOutController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text('Add Resident'),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name is required';
                      }
                      if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                        return 'Invalid name format';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: 'Phone'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Phone number is required';
                      }
                      if (!RegExp(r"^\d{10}$").hasMatch(value)) {
                        return 'Phone number must be 10 digits';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          .hasMatch(value)) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    items: ['Single', 'Double', 'Triple']
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) {
                      roomTypeController.text = value!;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Room type is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Room Type'),
                  ),
                  DropdownButtonFormField<String>(
                    items: ['Full Board', 'Half Board', 'Bed and Breakfast']
                        .map((option) => DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            ))
                        .toList(),
                    onChanged: (value) {
                      boardingOptionController.text = value!;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Boarding option is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Boarding Option'),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: checkInDate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null) {
                        checkInDate = selectedDate;
                        checkInController.text = "${selectedDate.toLocal()}"
                            .split(' ')[0]; // Update controller
                      }
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: checkInController,
                        decoration: InputDecoration(labelText: 'Check-in Date'),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Check-out Date Picker
                  GestureDetector(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: checkOutDate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null) {
                        checkOutDate = selectedDate;
                        checkOutController.text = "${selectedDate.toLocal()}"
                            .split(' ')[0]; // Update controller
                      }
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: checkOutController,
                        decoration:
                            InputDecoration(labelText: 'Check-out Date'),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        CostCalculationStrategy costBoarding =
                            CostCalculationFactory.CreateBoardingOption(
                                boardingOptionController.text);
                        Roomstrategy costRoom =
                            RoomStrategyFactory.CreateBoardingOption(
                                roomTypeController.text);
                        final resident = Resident(
                            DateTime.now().millisecondsSinceEpoch.toString(),
                            nameController.text,
                            emailController.text,
                            phoneController.text,
                            Booking(
                              checkInDate!,
                              checkOutDate!,
                              AbstractRoom('', roomTypeController.text, false),
                              Boardingoptionfactory.CreateBoardingOption(
                                  boardingOptionController.text),
                              costBoarding,
                              costRoom,
                            ));
                        widget.receptionist
                            .assignRoom(resident, roomTypeController.text)
                            .then((roomDetails) {
                          print(
                              "Resident added successfully with room details: $roomDetails");
                          if (roomDetails != null) {
                            // Update the resident's booking with the assigned room details
                            resident.booking.room.occupied = true;
                            resident.booking.room.roomNumber =
                                roomDetails['roomId'].toString();

                            resident.booking.room.roomType =
                                roomDetails['roomType'];

                            // Add the resident to resident management
                            widget.receptionist.addResident(resident);

                            print(
                                "Resident added successfully with room details: $roomDetails");
                            Navigator.pop(context);
                          } else {
                            print(
                                "Failed to add resident. No suitable room available.");
                          }
                        }).catchError((error) {
                          print(
                              "An error occurred while assigning a room: $error");
                        });
                      }
                    },
                    child: Text('Add Resident'),
                  ),
                ],
              ),
            )));
  }
}
