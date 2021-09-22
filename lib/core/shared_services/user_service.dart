import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserService extends GetxService {
  String displayname = "";
  String email = "";
  String photoUrl = "";
  String phoneNumber = "";

  GetStorage? user;

  String get getDisplayname => user!.read("displayname");

  set setDisplayname(String displayname) {
    this.displayname = displayname;
    user!.write("displayname", displayname);
  }

  get getEmail => user!.read("email");

  set setEmail(email) {
    this.email = email;
    user!.write("email", email);
  }

  get getPhotoUrl => user!.read("photoUrl");

  set setPhotoUrl(photoUrl) {
    this.photoUrl = photoUrl;
    user!.write("photoUrl", photoUrl);
  }

  get getPhoneNumber => user!.read("phoneNumber");

  set setPhoneNumber(phoneNumber) {
    this.phoneNumber = phoneNumber;
    user!.write("phoneNumber", phoneNumber);
  }
}
