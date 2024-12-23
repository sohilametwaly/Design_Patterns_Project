// import 'package:design_patterns_project/abstract_room.dart';
// import 'package:flutter/material.dart';
// import 'package:design_patterns_project/Receptionist.dart';
// import 'package:design_patterns_project/Resident.dart';
// import 'package:design_patterns_project/Database.dart';
// import 'package:design_patterns_project/calc-cost/Booking.dart';

// class AddResidentPage extends StatefulWidget {
  
//   final Receptionist receptionist;

//   AddResidentPage({required this.receptionist});

//   @override
//   _AddResidentPageState createState() => _AddResidentPageState();
// }

// class _AddResidentPageState extends State<AddResidentPage> {
//   final Database _db = Database.getInstance();
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//  // final _boardingOptionController = TextEditingController();
//   //final _roomTypeController = TextEditingController();
//   final _roomNumberController = TextEditingController();
//   final _durationController = TextEditingController();

//   List<String> _boardingOptions = [];
//   List<String> _roomTypes = [];
//   String? _selectedBoardingOption;
//   String? _selectedRoomType;

//     @override
//   void initState() {
//     super.initState();
//     _fetchOptions();
//     _fetchRoomTypes();
//   }

//   Future<void> _fetchOptions() async {
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
//           await _db.readData("RoomTypes");
      
//       setState(() {
//         _roomTypes = roomTypesSnapshot.docs
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
//   if (_formKey.currentState?.validate() ?? false) {
//     if (_selectedBoardingOption == null || _selectedRoomType == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please select both a boarding option and a room type')),
//       );
//       return;
//     }

//     final resident = Resident(
//       int.parse(DateTime.now().millisecondsSinceEpoch.toString()),
//       _nameController.text,
//       _emailController.text,
//       _phoneController.text,
//       Booking(
//         int.parse(DateTime.now().millisecondsSinceEpoch.toString()),
//         int.tryParse(_durationController.text) ?? 0,
//         AbstractRoom(
//           int.tryParse(_roomNumberController.text) ?? 0,

//           true,
//           _selectedRoomType!, // Pass the same room type here
//         ),
//         BoardingOption(_selectedBoardingOption!), // Use selected boarding option from dropdown
//       ),
//     );

//     widget.receptionist.addResident(resident, _selectedRoomType!);
//     Navigator.pop(context, true);
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Add New Resident')),
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
//                 TextFormField(
//                   controller: _boardingOptionController,
//                   decoration: InputDecoration(labelText: 'Boarding Option'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the boarding option';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _roomTypeController,
//                   decoration: InputDecoration(labelText: 'Room Type'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the room type';
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
//                   child: Text('Add Resident'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:design_patterns_project/resident_list/ResidentListScreen.dart';
// import 'package:flutter/material.dart';

// import '../Database.dart';

// class AddResidentScreen extends StatefulWidget {
//   @override
//   final Map<String, dynamic>? resident;

//   AddResidentScreen({this.resident});

//   _AddResidentScreenState createState() => _AddResidentScreenState();
// }

// class _AddResidentScreenState extends State<AddResidentScreen> {
//   TextEditingController residentName = TextEditingController();
//   TextEditingController residentId = TextEditingController();
//   TextEditingController residentEmail = TextEditingController();
//   TextEditingController roomType = TextEditingController();
//   TextEditingController boardingOption = TextEditingController();
//   TextEditingController durationOfStay = TextEditingController();
//   TextEditingController phone=TextEditingController();
//   String ? boardingOptions  ;
//   String? selectedRoom;
//   final List<String> boardingOptionsList = [
//     "Full Board",
//     "Half Board",
//     "Bed and Breakfast"
//   ];

//   final List<String> availableRooms = [
//     '300',
//     '301',
//     '302',
//     '303'
//   ];
//   @override
//   void initState() {
//     super.initState();
//     if (widget.resident != null) {
//       residentName.text = widget.resident!['name'] ?? '';
//       residentId.text = widget.resident!['id'] ?? '';
//       residentEmail.text = widget.resident!['email'] ?? '';
//       roomType.text = widget.resident!['roomType'] ?? '';
//       selectedRoom = widget.resident!['selectedRoom'] ?? '';
//       boardingOptions = widget.resident!['boardingOption'] ?? '';
//       durationOfStay.text = widget.resident!['durationOfStay'] ?? '';
//       phone.text = widget.resident!['phone'] ?? '';
//     }
//     // addInitialData();
//   }
//   void _selectRoom(BuildContext context) async {
//     final String? room = await showDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Select a Room"),
//           content: Container(
//             width: double.maxFinite,
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: availableRooms.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text(availableRooms[index]),
//                   onTap: () {
//                     Navigator.pop(context, availableRooms[index]);
//                   },
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );

//     if (room != null) {
//       setState(() {
//         selectedRoom = room;
//       });
//     }
//   }
//   void _boardingOptions(BuildContext context) async {
//     final String? option = await showDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Select board option"),
//           content: Container(
//             width: double.maxFinite,
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: boardingOptionsList.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text(  boardingOptionsList[index]),
//                   onTap: () {
//                     Navigator.pop(context, boardingOptionsList[index]);
//                   },
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );

//     if (option != null) {
//       setState(() {
//         boardingOptions = option;
//       });
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.resident != null ? "Edit Resident" : "Add Resident"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Card(
//             elevation: 4.0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.resident != null
//                         ? "Edit Resident Details"
//                         : " Add New Resident ",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,

//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   _buildTextField(
//                     controller: residentName,
//                     label: "Name",
//                     icon: Icons.person,
//                   ),
//                   SizedBox(height: 16),
//                   _buildTextField(
//                     controller: phone,
//                     label: "Phone",
//                     icon: Icons.phone,
//                   ),
//                   SizedBox(height: 16),
//                   _buildTextField(
//                     controller: residentId,
//                     label: "ID",
//                     icon: Icons.badge,
//                   ),
//                   SizedBox(height: 16),
//                   _buildTextField(
//                     controller: residentEmail,
//                     label: "Email",
//                     icon: Icons.email,
//                   ),
//                   SizedBox(height: 16),
//                   _buildTextField(
//                     controller: roomType,
//                     label: "Room Type",
//                     icon: Icons.room_preferences,
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     " Room Number :",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     selectedRoom ?? "No room selected",
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton.icon(
//                     onPressed: () => _selectRoom(context),
//                     label: Text("Choose a Room"),
//                   ),
//                   SizedBox(height: 16),
//                   SizedBox(height: 16),
//                   Text(
//                     " Board Option :",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     boardingOptions ?? "No option selected",
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton.icon(
//                     onPressed: () => _boardingOptions(context),
//                     label: Text("Choose an option"),
//                   ),
//                   SizedBox(height: 16),

//                   _buildTextField(
//                     controller: durationOfStay,
//                     label: "Duration of Stay",
//                     icon: Icons.calendar_today,
//                   ),

//                   SizedBox(height: 24),
//                   ElevatedButton(
//                     onPressed: () {
//                       Map<String, dynamic> residentData = {
//                         'name': residentName.text,
//                         'id': residentId.text,
//                         'email': residentEmail.text,
//                         'roomType': roomType.text,
//                         'selectedRoom': selectedRoom,
//                         'boardingOption': boardingOptions,
//                         'durationOfStay': durationOfStay.text,
//                         'phone':phone.text
//                       };
//                       addResidentData(residentId.text.toString(), residentEmail.text.toString(),residentName.text.toString(),phone.text.toString(),roomType.text.toString(),int.parse(selectedRoom!),boardingOptions!,int.parse(durationOfStay.text.toString()));
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ResidentListScreen(residentData: residentData),
//                         ),
//                       );
//                     },
//                     child: Text(
//                         widget.resident != null
//                             ? "Update "
//                             : "Add "),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue, // Set the background color
//                       foregroundColor: Colors.white, // Set the text color
//                       elevation: 5, // Optional: Add elevation
//                       minimumSize: Size(double.infinity, 50),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//   }) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//     );
//   }

//   void addResidentData(String id,String email, String name,String phone, String roomType, int roomNum, String boardingOption, int durationOfStay) async {
//     Database database = Database.getInstance();
//     Map<String,dynamic> residentData = {
//       "id": id,
//       "phone":phone,
//       "email":email,
//       "name": name,
//       "Booking":
//       {
//         "roomType": roomType,
//         "roomNum": roomNum,
//         "boardingOption": boardingOption,
//         "durationOfStay": durationOfStay
//       }

//     };
//     final path = "residents/${DateTime.now().millisecondsSinceEpoch}";
//     await database.writeData(path, residentData);
//     print("Resident added successfully at path: $path");
//   }

//   void BoardingData() async {
//     final database = Database.getInstance();

//     Map<String,dynamic> boardingOptions = {
//       "FullBoard": {"price": 300},
//       "HalfBoard": {"price": 150},
//       "BedAndBreakFast": {"price": 100},
//     };
//     final path = "boardingOptions";

//     await database.writeData(path, boardingOptions);

//     print("options added successfully at path: $path");
//   }

//   void addRoomData() async {
//     final database = Database.getInstance();

//     Map<String,dynamic> roomTypes = {
//       "Single": {"price": 300},
//       "Double": {"price": 150},
//       "triple": {"price": 100},
//     };
//     final path = "roomTypes";

//     await database.writeData(path, roomTypes);
//     print("options added successfully at path: $path");
//   }


// }