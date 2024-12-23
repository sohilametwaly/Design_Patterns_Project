// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:design_patterns_project/Resident.dart';
// import 'package:design_patterns_project/Database.dart';
// import 'package:design_patterns_project/calc-cost/Booking.dart';
// import 'package:design_patterns_project/abstract_room.dart';
// import 'package:design_patterns_project/Abstract%20Boarding%20Option/AbstractBoardingOption.dart';

// class EditResidentPage extends StatefulWidget {
//   final Resident resident;
//   final Function(Resident updatedResident) onUpdate;

//   EditResidentPage({required this.resident, required this.onUpdate});

//   @override
//   _EditResidentPageState createState() => _EditResidentPageState();
// }

// class _EditResidentPageState extends State<EditResidentPage> {
//     final Database _db = Database.getInstance();
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _roomNumberController = TextEditingController();
//   final _durationController = TextEditingController();

//   List<String> _boardingOptions = [];
//   List<String> _roomTypes = [];
//   String? _selectedBoardingOption;
//   String? _selectedRoomType;

//   @override
//   void initState() {
//     super.initState();
//     _initializeFields();
//     _fetchOptions();
//     _fetchRoomTypes();
//   }

//   void _initializeFields() {
//     _nameController.text = widget.resident.name;
//     _emailController.text = widget.resident.email;
//     _phoneController.text = widget.resident.phone;
//     _roomNumberController.text = widget.resident.booking.room.roomNumber.toString();
//     _durationController.text = widget.resident.booking.DurationOfStay.toString();
//     _selectedBoardingOption = widget.resident.booking.boardingOption.toString();
//     _selectedRoomType = widget.resident.booking.room.roomType;
//   }

//     Future<void> _fetchOptions() async {
//     try {
//       final boardingOptionsSnapshot =
//           await _db.readData("boardingOptions");
     
//       setState(() {
//         _boardingOptions = boardingOptionsSnapshot.docs
//             .map((doc) => doc.data()['name'] as String)
//             .toList();

//        });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to fetch options: $e')),
//       );
//     }
//   }
//   Future<void> _fetchRoomTypes() async {
//     try {
//       final roomTypesSnapshot =
//           await _db.readData("roomTypes");
      
//       setState(() {
//         _boardingOptions = roomTypesSnapshot.docs
//             .map((doc) => doc.data()['name'] as String)
//             .toList();
//        });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to fetch options: $e')),
//       );
//     }
//   }

//   void _submitForm() {
//     if (_formKey.currentState?.validate() ?? false) {
//       if (_selectedBoardingOption == null || _selectedRoomType == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please select all options')),
//         );
//         return;
//       }

//       final updatedResident = Resident(
//          widget.resident.id,
//          _nameController.text,
//          _emailController.text,
//          _phoneController.text,
//          Booking(
//           widget.resident.booking.id,
//           int.tryParse(_durationController.text) ?? 0,
//           Room(
//             roomNumber: int.tryParse(_roomNumberController.text) ?? 0,
//             roomType: _selectedRoomType!,
//           ),
//           BoardingOption(_selectedBoardingOption!),
//         ),
//       );

//       widget.onUpdate(updatedResident);
//       Navigator.pop(context, true);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Edit Resident')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: InputDecoration(labelText: 'Name'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the resident\'s name';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: InputDecoration(labelText: 'Email'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the resident\'s email';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _phoneController,
//                   decoration: InputDecoration(labelText: 'Phone'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the resident\'s phone number';
//                     }
//                     return null;
//                   },
//                 ),
//                 DropdownButtonFormField<String>(
//                   value: _selectedBoardingOption,
//                   decoration: InputDecoration(labelText: 'Boarding Option'),
//                   items: _boardingOptions.map((option) {
//                     return DropdownMenuItem(
//                       value: option,
//                       child: Text(option),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedBoardingOption = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please select a boarding option';
//                     }
//                     return null;
//                   },
//                 ),
//                 DropdownButtonFormField<String>(
//                   value: _selectedRoomType,
//                   decoration: InputDecoration(labelText: 'Room Type'),
//                   items: _roomTypes.map((type) {
//                     return DropdownMenuItem(
//                       value: type,
//                       child: Text(type),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedRoomType = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please select a room type';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _roomNumberController,
//                   decoration: InputDecoration(labelText: 'Room Number'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the room number';
//                     }
//                     if (int.tryParse(value) == null) {
//                       return 'Please enter a valid room number';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _durationController,
//                   decoration: InputDecoration(labelText: 'Duration of Stay (days)'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the duration of stay';
//                     }
//                     if (int.tryParse(value) == null) {
//                       return 'Please enter a valid duration';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: _submitForm,
//                   child: Text('Update Resident'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
