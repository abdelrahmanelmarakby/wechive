import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddUser extends GetxService {
  final String fullName;
  final String location;
  final String phoneNumber;
  final String bio;
  final String age;
  final List<String> interests;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'full_name': fullName, // John Doe
          'location': location, // Stokes and Sons
          'age': age, // 42
          'bio': bio, // Hey connect with me
          'interests': interests // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  AddUser(
      {this.fullName = "WhoAmI",
      this.location = "Egypt",
      this.bio = "Hello World!",
      this.age = "",
      this.phoneNumber = "",
      this.interests = const ["", "", "", ""]});
}
