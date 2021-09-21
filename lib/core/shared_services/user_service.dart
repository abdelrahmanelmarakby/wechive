import 'package:get/get.dart';

class UserService extends GetxService {
  String displayname = "";
  String email = "";
  String photoUrl = "";
  String phoneNumber = "";
 String get getDisplayname => displayname;

 set setDisplayname(String displayname) => this.displayname = displayname;

  get getEmail => email;

 set setEmail( email) => this.email = email;

  get getPhotoUrl => photoUrl;

 set setPhotoUrl( photoUrl) => this.photoUrl = photoUrl;

  get getPhoneNumber => phoneNumber;

 set setPhoneNumber( phoneNumber) => this.phoneNumber = phoneNumber;
}
