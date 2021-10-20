class room {
  String? id;
  String? name;
  String? desc;
  String? locationLon;
  String? locationLat;
  String? coverImageUrl;
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
      required this.coverImageUrl,
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
    coverImageUrl = json["coverImageUrl"].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['desc'] = desc;
    data['location_lon'] = locationLon;
    data['location_lat'] = locationLat;
    data['tasks'] = tasks;
    data['goals'] = goals;
    data['interests'] = interests;
    data['users_id'] = usersId;
    data['coverImageUrl'] = coverImageUrl;
    return data;
  }
}
