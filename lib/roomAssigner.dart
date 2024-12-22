import 'package:design_patterns_project/Database.dart';
import 'Resident.dart';

class RoomAssigner {
  final Database _db = Database.getInstance();

  Future<bool> assignRoom(Resident resident, String desiredRoomType) async {
    // Fetch all rooms from Firebase
    final Map<dynamic, dynamic> roomsData = await _db.readData('Rooms');

    if (roomsData == null || roomsData.isEmpty) {
      print("No rooms available in the database.");
      return false;
    }

    // Iterate over rooms to find an available room of the desired type
    for (var entry in roomsData.entries) {
      int roomId = entry.key;
      Map<String, dynamic> room = Map<String, dynamic>.from(entry.value);

      if (room['occupied'] == false && room['roomType'] == desiredRoomType) {
        // Assign room to the resident
        room['occupied'] = true;
        //room['residentId'] = resident.id;

        // Update room data in Firebase
        await _db.writeData('Rooms/$roomId', room);

        // Update resident's assigned room in Firebase
        resident.booking.room.roomNumber = roomId;
        //await _db.writeData('residents/${resident.id}', resident.toMap());

        print("Assigned room $roomId to resident ${resident.name}");
        return true;
      }
    }

    // If no suitable room is found
    print("No available rooms match the desired room type.");
    return false;
  }
}
