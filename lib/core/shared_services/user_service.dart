import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseUser extends GetxService {
  //* User Profile Details
  final String userName;
  final String location;
  final String imageUrl;
  final String phoneNumber;
  final String bio;
  final String age;
  final List<String> interests;

  //*Firebase and user ops
  //firestore operations
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return _users
        .add({
          'full_name': userName, // John Doe
          'location': location, // Stokes and Sons
          'age': age, // 42
          'bio': bio, // Hey connect with me
          'interests': interests, // 42
          "phoneNumber": phoneNumber,
          "imageUrl": imageUrl
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  FirebaseUser(
      {this.userName = "WhoAmI",
      this.location = "Egypt",
      this.bio = "Hello World!",
      this.age = "",
      this.phoneNumber = "",
      this.interests = const ["", "", "", ""],
      this.imageUrl = ""});
}
