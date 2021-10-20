class room {
  String? id;
  String? name;
  String? desc;
  String? locationLon;
  String? locationLat;
  List? tasks;
  List? goals;
  List? interests;
  List? usersId;

  room(
      {required this.id,
      required this.name,
      required this.desc,
      required this.locationLon,
      required this.locationLat,
      required this.tasks,
      required this.goals,
      required this.interests,
      required this.usersId});

  room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    locationLon = json['location_lon'];
    locationLat = json['location_lat'];
    tasks = json['tasks'].cast<String>();
    goals = json['goals'].cast<String>();
    interests = json['interests'].cast<String>();
    usersId = json['users_id'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['location_lon'] = this.locationLon;
    data['location_lat'] = this.locationLat;
    data['tasks'] = this.tasks;
    data['goals'] = this.goals;
    data['interests'] = this.interests;
    data['users_id'] = this.usersId;
    return data;
  }
}
