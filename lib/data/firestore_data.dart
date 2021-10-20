import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseData {
  static Future<List> getAllRooms() async {
    CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
    QuerySnapshot querySnapshot = await rooms.get();

    // Get data from docs and convert map to List
    List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }

  static getRoom(var id) async {
    CollectionReference rooms =
        await FirebaseFirestore.instance.collection('rooms');
    QuerySnapshot querySnapshot = await rooms.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }

  static Future<List> getAllUsers() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await users.get();

    // Get data from docs and convert map to List
    final List<Object?> allData =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  static getUser(var id) async {
    CollectionReference users =
        await FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await users.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }

  static getProfile(String uid) async {
    var user =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    print(user);
    return user.data();
  }
}
