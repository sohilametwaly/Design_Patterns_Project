import 'package:design_patterns_project/Database.dart';
import 'Resident.dart';

class RoomAssigner {
  final Database _db = Database.getInstance();

//Future<bool> assignRoom(Resident resident, String desiredRoomType) async {
  // Fetch all rooms from Firebase
//   final Map<dynamic, dynamic>? roomsData = await _db.readData('Rooms');

//   if (roomsData == null || roomsData.isEmpty) {
//     print("No rooms available in the database.");
//     return false;
//   }

//   // Iterate over rooms to find an available room of the desired type
//   for (var entry in roomsData.entries) {
//     // Room ID as string
//     final String roomIdKey = entry.key.toString();

//     // Room data as a map
//     Map<String, dynamic> room = Map<String, dynamic>.from(entry.value);

//     // Check for available room matching the desired type
//     if (room['occupied'] == false && room['roomType'] == desiredRoomType.toLowerCase()) {
//       // Mark room as occupied
//       room['occupied'] = true;

//       // Update the room in Firebase
//       await _db.writeData('Rooms/$roomIdKey', room);

//       // Assign the room to the resident's booking
//       resident.booking.room.roomNumber = roomIdKey; // Ensure roomNumber is an integer
//       resident.booking.room.pricePerNight = double.parse(room['pricePerNight']);
//       resident.booking.room.roomType = room['roomType'];

//       // Update resident's data in Firebase
//       //await _db.writeData('Residents/${resident.id}', resident.toMap());

//       print("Assigned room $roomIdKey to resident ${resident.name}");
//       return true;
//     }
//   }

//   // If no suitable room is found
//   print("No available rooms match the desired room type.");
//   return false;
// }




  Future<Map<String, dynamic>?> assignRoom(Resident resident, String desiredRoomType) async {
    // Fetch all rooms from Firebase
    final Map<dynamic, dynamic>? roomsData = await _db.readData('Rooms');

    if (roomsData == null || roomsData.isEmpty) {
      print("No rooms available in the database.");
      return null;
    }

    // Iterate over rooms to find an available room of the desired type
    for (var entry in roomsData.entries) {
      // Room ID as string
      final String roomIdKey = entry.key.toString();

      // Room data as a map
     final Map<String, dynamic> room = Map<String, dynamic>.from(entry.value);

      // Check for available room matching the desired type
      if (room['occupied'] == false && room['roomType'] == desiredRoomType.toLowerCase()) {
          // final double pricePerNight = (room['pricePerNight'] is int)
          // ? (room['pricePerNight'] as int).toDouble()
          // : double.parse(room['pricePerNight'].toString());
        // Mark room as occupied
        room['occupied'] = true;

        // Update the room in Firebase
        await _db.writeData('Rooms/$roomIdKey', room);

        // Assign the room to the resident's booking
        // resident.booking.room.roomNumber = roomIdKey; // Ensure roomNumber is a string
        // resident.booking.room.pricePerNight = double.parse(room['pricePerNight']);
        // resident.booking.room.roomType = room['roomType'];

        // Optionally update resident's data in Firebase
        // await _db.writeData('Residents/${resident.id}', resident.toMap());

        print("Assigned room $roomIdKey to resident ${resident.name}");
        return {
          'roomId': roomIdKey,
          'roomType': room['roomType'].toString(),
          // 'pricePerNight': pricePerNight.toString(),
        };
      }
    }

    // If no suitable room is found
    print("No available rooms match the desired room type.");
    return null;
  }
}




