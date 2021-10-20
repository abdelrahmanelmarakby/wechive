import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wechive/app/modules/auth/views/complete_profile.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'
    as firebase_storage; // For File Upload To Firestore
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:wechive/core/consts.dart';

class AuthController extends GetxController {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  List selectedInterests = [""];
  List allInterests = [
    "Entertainment",
    'News',
    "Politics",
    "Automobile ",
    "Sports & Outdoors ",
    "Education",
    "Fashion",
    "Travel",
    "Food",
    "Tech & Electronics",
    "Programming",
    "Pets",
    "Finance and business",
    "Space",
    "Gaming",
    "Beauty & Personal Care ",
    "Apps ",
    "Science",
  ];
  var isLoading = false.obs;
  var verId = '';
  var authStatus = ''.obs;
  bool isPhoneOk = false;
  final phone = TextEditingController();
  final otp = TextEditingController();
  var auth = FirebaseAuth.instance;

  final Rxn<User> user = Rxn<User>();

  var onTapRecognizer;

  //*FIRESTORAGE OPS
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final RxBool imagePicked = false.obs;
  late File image;

  final picker = ImagePicker();
  Future pickImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 750, maxWidth: 750);
    image = File(pickedFile!.path);
    imagePicked.value = true;
    Get.forceAppUpdate();
    uploadFile();
  }

  Future<void> uploadFile() async {
    File file = File(image.path);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('images/${authUserID + "profilePic"}.png')
          .putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      Get.snackbar("Can't upload profile pic", e.message.toString());
    }
  }

  //***************************OTP******************************************************************/

  TextEditingController textEditingController = TextEditingController();

  // ..text = "123456";

  StreamController<ErrorAnimationType>? errorController;

  RxBool hasError = false.obs;
  RxString currentText = "".obs;

  verifyPhone(String phone) async {
    isLoading.value = true;
    await auth.verifyPhoneNumber(
        timeout: Duration(seconds: 70),
        phoneNumber: phone,
        verificationCompleted: (AuthCredential authCredential) {
          print("Login Successfully");
          if (auth.currentUser != null) {
            authUserID = auth.currentUser!.uid;
            isLoading.value = false;
            authStatus.value = "login successfully";
          }
        },
        verificationFailed: (authException) {
          Get.snackbar("sms code info", "otp code hasn't been sent!!");
        },
        codeSent: (String id, [int? forceResent]) {
          print("Code Sent $id");

          isLoading.value = false;
          // ignore: unnecessary_this
          this.verId = id;
          authStatus.value = "login successfully";
        },
        codeAutoRetrievalTimeout: (String id) {
          verId = id;
        });
  }

  /////////
  Future<bool> otpVerify(String otp) async {
    isLoading.value = true;
    try {
      print("trying to verify");

      UserCredential userCredential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(verificationId: verId, smsCode: otp));
      if (userCredential.user != null) {
        isLoading.value = false;
        Get.offAll(() => CompleteProfile());
      }
    } on Exception catch (e) {
      Get.snackbar("otp info", " ${e.toString()}");
    }
    return false;
  }

  @override
  void onInit() {
    super.onInit();

    user.bindStream(auth.authStateChanges());
  }

  //***************************EMAIL***************************************/
  Future createAccountWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      
      FirebaseAuth.instance.currentUser!.reload();
      
    authUserID = user.value!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      FirebaseAuth.instance.currentUser!.reload();

    authUserID = user.value!.uid;
      Get.offAll(CompleteProfile());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    Get.offAll(CompleteProfile());
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) {
      FirebaseAuth.instance.currentUser!.reload();
      
    authUserID = user.value!.uid;
      Get.offAll(CompleteProfile());
      return value;
    });
  }

  Future<void> addUser(Map<String, dynamic> user) {
    final CollectionReference _users =
        FirebaseFirestore.instance.collection('users');
    // Call the user's CollectionReference to add a new user
    
    authUserID = this.user.value!.uid;
    return _users
        .doc(this.user.value!.uid.toString())
        .set(user)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

/*
  Future<UserCredential> signInWithTwitter() async {
    // Create a TwitterLogin instance
    final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: '<your consumer key>',
      consumerSecret: ' <your consumer secret>',
    );

    // Trigger the sign-in flow
    final TwitterLoginResult loginResult = await twitterLogin.authorize();

    // Get the Logged In session
    final TwitterSession twitterSession = loginResult.session;

    // Create a credential from the access token
    final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: twitterSession.token, secret: twitterSession.secret);

    FirebaseAuth.instance.currentUser!.reload();
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(twitterAuthCredential);
  }*/

/*Future<UserCredential> signInWithGitHub(BuildContext context) async {
  // Create a GitHubSignIn instance
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
          clientId: "393f07b7644caab767b9",
          clientSecret: "80d9460d79944b81d6538f015f1b8d75cb40619f",
          redirectUrl: 'https://wechive-c727d.firebaseapp.com/__/auth/handler');

  // Trigger the sign-in flow
  final result = await gitHubSignIn.signIn(context);

  // Create a credential from the access token
  final githubAuthCredential = GithubAuthProvider.credential(result.token);

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
}*/
//*lOCATION
  final RxString userLocation = "Egypt".obs;
  var country_list = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Anguilla",
    "Antigua &amp; Barbuda",
    "Argentina",
    "Armenia",
    "Aruba",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bermuda",
    "Bhutan",
    "Bolivia",
    "Bosnia &amp; Herzegovina",
    "Botswana",
    "Brazil",
    "British Virgin Islands",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Cape Verde",
    "Cayman Islands",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Congo",
    "Cook Islands",
    "Costa Rica",
    "Cote D Ivoire",
    "Croatia",
    "Cruise Ship",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Estonia",
    "Ethiopia",
    "Falkland Islands",
    "Faroe Islands",
    "Fiji",
    "Finland",
    "France",
    "French Polynesia",
    "French West Indies",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Gibraltar",
    "Greece",
    "Greenland",
    "Grenada",
    "Guam",
    "Guatemala",
    "Guernsey",
    "Guinea",
    "Guinea Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hong Kong",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Isle of Man",
    "Palas",
    "Italy",
    "Jamaica",
    "Japan",
    "Jersey",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kuwait",
    "Kyrgyz Republic",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Macau",
    "Macedonia",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Montserrat",
    "Morocco",
    "Mozambique",
    "Namibia",
    "Nepal",
    "Netherlands",
    "Netherlands Antilles",
    "New Caledonia",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Norway",
    "Oman",
    "Pakistan",
    "Palestine",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Puerto Rico",
    "Qatar",
    "Reunion",
    "Romania",
    "Russia",
    "Rwanda",
    "Saint Pierre &amp; Miquelon",
    "Samoa",
    "San Marino",
    "Satellite",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "South Africa",
    "South Korea",
    "Spain",
    "Sri Lanka",
    "St Kitts &amp; Nevis",
    "St Lucia",
    "St Vincent",
    "St. Lucia",
    "Sudan",
    "Suriname",
    "Swaziland",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Timor L'Este",
    "Togo",
    "Tonga",
    "Trinidad &amp; Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Turks &amp; Caicos",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "Uruguay",
    "Uzbekistan",
    "Venezuela",
    "Vietnam",
    "Virgin Islands (US)",
    "Yemen",
    "Zambia",
    "Zimbabwe"
  ];
}
