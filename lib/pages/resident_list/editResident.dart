import 'package:design_patterns_project/Classes/factory/boardingFactory/BoardingOptionFactory.dart';
import 'package:design_patterns_project/Classes/factory/boardingStrategyFactory/CostCalculationFactory.dart';
import 'package:design_patterns_project/Classes/singleton/Database.dart';
import 'package:design_patterns_project/Classes/Resident.dart';
import 'package:design_patterns_project/Classes/Strategy/roomStrategy/RoomStrategy.dart';
import 'package:design_patterns_project/Classes/factory/roomCostStrategyFactory/RoomStrategyFactory.dart';
import 'package:design_patterns_project/Classes/room.dart';
import 'package:design_patterns_project/Classes/Booking.dart';
import 'package:design_patterns_project/Classes/Strategy/boardingStrategy/CostCalculationStrategy.dart';
import 'package:flutter/material.dart';
import 'package:design_patterns_project/Classes/Receptionist.dart';

class EditResidentPage extends StatefulWidget {
  final String residentId;
  final Map<String, dynamic> data;
  final Receptionist receptionist;

  EditResidentPage({
    required this.residentId,
    required this.data,
    required this.receptionist,
  });

  @override
  _EditResidentPageState createState() => _EditResidentPageState();
}

class _EditResidentPageState extends State<EditResidentPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController roomIdController;

  bool isOccupied = false;
  late String selectedBoardingName;
  late String selectedRoomType;

  DateTime? checkInDate;
  DateTime? checkOutDate;
  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();
  Database database = Database.getInstance();

  final List<String> boardingOptions = [
    'Full Board',
    'Half Board',
    'Bed and Breakfast'
  ];
  final List<String> roomTypes = ['single', 'double', 'triple'];

  @override
  void initState() {
    super.initState();

    // Initialize Controllers with Existing Data
    nameController = TextEditingController(text: widget.data['name']);
    phoneController = TextEditingController(text: widget.data['phone']);
    emailController = TextEditingController(text: widget.data['email']);
    roomIdController = TextEditingController(
        text: widget.data['booking']['room']['id'].toString());

    // Room and Boarding Data
    selectedRoomType = widget.data['booking']['room']['roomType'];
    selectedBoardingName = widget.data['booking']['boarding']['name'];
    isOccupied = widget.data['booking']['room']['occupied'];

    // Date Initialization
    checkInDate = DateTime.parse(widget.data['booking']['checkInDate']);
    checkOutDate = DateTime.parse(widget.data['booking']['checkOutDate']);
    checkInController.text =
        widget.data['booking']['checkInDate'].split('T')[0];
    checkOutController.text =
        widget.data['booking']['checkOutDate'].split('T')[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Resident')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey, // Form key for validation
          child: Column(
            children: [
              // Name
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

              // Phone
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Phone is required';
                  }
                  if (!RegExp(r"^\d{10}$").hasMatch(value)) {
                    return 'Phone must be 10 digits';
                  }
                  return null;
                },
              ),

              // Email
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
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

              SizedBox(height: 20),
              Text('Room Details',
                  style: TextStyle(fontWeight: FontWeight.bold)),

              DropdownButtonFormField<String>(
                value: roomTypes.contains(selectedRoomType)
                    ? selectedRoomType
                    : null, // Ensure value exists in dropdown
                items: roomTypes
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => selectedRoomType = value!),
                decoration: InputDecoration(labelText: 'Room Type'),
              ),
              SizedBox(height: 20),
              Text('Boarding Details',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: boardingOptions.contains(selectedBoardingName)
                    ? selectedBoardingName
                    : null,
                items: boardingOptions
                    .map((option) => DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        ))
                    .toList(),
                onChanged: (value) =>
                    setState(() => selectedBoardingName = value!),
                decoration: InputDecoration(labelText: 'Boarding Name'),
              ),

              SizedBox(height: 20),
              Text('Booking Dates',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              _buildDatePicker('Check-in Date', checkInController,
                  (date) => checkInDate = date),
              _buildDatePicker('Check-out Date', checkOutController,
                  (date) => checkOutDate = date),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    CostCalculationStrategy costBoarding =
                        CostCalculationFactory.CreateBoardingOption(
                            selectedBoardingName);
                    Roomstrategy costRoom =
                        RoomStrategyFactory.CreateBoardingOption(
                            selectedRoomType);
                    final resident = Resident(
                        widget.residentId,
                        nameController.text,
                        emailController.text,
                        phoneController.text,
                        Booking(
                          checkInDate!,
                          checkOutDate!,
                          AbstractRoom(
                              widget.data['booking']['room']['id'],
                              widget.data['booking']['room']['roomType'],
                              widget.data['booking']['room']['occupied']),
                          Boardingoptionfactory.CreateBoardingOption(
                              selectedBoardingName),
                          costBoarding,
                          costRoom,
                        ));
                    if (widget.data['booking']['room']['roomType'] !=
                        selectedRoomType) {
                      print(widget.data['booking']['room']['roomType']);
                      print(selectedRoomType);
                      widget.receptionist
                          .assignRoom(resident, selectedRoomType)
                          .then((roomDetails) {
                        print(
                            "Resident added successfully with room details: $roomDetails");
                        if (roomDetails != null) {
                          print(roomDetails);
                          // Update the resident's booking with the assigned room details
                          String id = widget.data['booking']['room']['id'];

                          Map<String, dynamic> updateData = {'occupied': false};
                          database.updateData('Rooms/${id}', updateData);

                          resident.booking.room.occupied = true;
                          resident.booking.room.roomNumber =
                              roomDetails['roomId'].toString();
                          resident.booking.room.roomType =
                              roomDetails['roomType'];

                          // Add the resident to resident management
                          widget.receptionist
                              .editResident(widget.residentId, resident);

                          print(
                              "Resident added successfully with room details: $roomDetails");
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("No Available Rooms"),
                                content: const Text(
                                    "Sorry, there are no available rooms to assign to this resident."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Navigator.of(context).pop();
                                      Navigator.pop(context, true);
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }).catchError((error) {
                        print(
                            "An error occurred while assigning a room: $error");
                      });
                    }

                    widget.receptionist
                        .editResident(widget.residentId, resident);
                    Navigator.pop(context, true);
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(String label, TextEditingController controller,
      Function(DateTime) onDateSelected) {
    return GestureDetector(
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2101),
        );
        if (selectedDate != null) {
          onDateSelected(selectedDate);
          controller.text = "${selectedDate.toLocal()}"
              .split(' ')[0]; // Format date as YYYY-MM-DD
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(labelText: label),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label is required';
            }
            return null;
          },
        ),
      ),
    );
  }
}
