class FirebaseUser {
  String? username;
  String? age;
  String? location;
  String? phoneNumber;
  String? bio;
  String? imageUrl;
  String? uid;
  List<dynamic>? interests;

  FirebaseUser(
      {required this.uid,
      required this.username,
      required this.age,
      required this.location,
      required this.phoneNumber,
      required this.bio,
      required this.imageUrl,
      required this.interests});

  FirebaseUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    username = json['username'];
    age = json['age'];
    location = json['location'];
    phoneNumber = json['phoneNumber'];
    bio = json['bio'];
    imageUrl = json['imageUrl'];
    interests = json['interests'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['username'] = this.username;
    data['age'] = this.age;
    data['location'] = this.location;
    data['phoneNumber'] = this.phoneNumber;
    data['bio'] = this.bio;
    data['imageUrl'] = this.imageUrl;
    data['interests'] = this.interests;
    data['uid'] = this.uid;
    return data;
  }
}
