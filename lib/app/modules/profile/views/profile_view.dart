import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wechive/core/consts.dart';
import 'package:wechive/core/widgets/Text.dart';
import 'package:wechive/data/firestore_data.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    //  print(user);
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseData.getProfile(authUserID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map data = snapshot.data as Map;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfilePhoto(data: data),
                    const SizedBox(
                      height: 22,
                    ),
                    NameAndLocation(data: data),
                    const SizedBox(
                      height: 22,
                    ),
                    Card(
                      child: Wrap(
                        spacing: 30,
                        runSpacing: 30,
                        children: [
                          ProfileCard(
                            icon: FontAwesomeIcons.peopleArrows,
                            label: 'rooms',
                          ),
                          ProfileCard(
                            icon: Icons.chat_bubble_rounded,
                            label: 'chats',
                          ),
                          ProfileCard(
                            icon: CupertinoIcons.group_solid,
                            label: 'friends',
                          ),
                          ProfileCard(
                            icon: CupertinoIcons.star_circle_fill,
                            label: 'interests',
                          ),
                          ProfileCard(
                            icon: CupertinoIcons.today_fill,
                            label: 'tasks',
                          ),
                          ProfileCard(
                            icon: CupertinoIcons.settings,
                            label: 'settings',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else
            return Center(
              child: CircularProgressIndicator(
                color: KBlue,
              ),
            );
        },
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        child: Column(
          children: [
            FaIcon(
              icon,
              size: 50,
              color: KBlue,
            ),
            const SizedBox(height: 8.0),
            Txt(
              label,
              size: 16,
              weight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}

class NameAndLocation extends StatelessWidget {
  const NameAndLocation({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Txt(
          data["username"],
          color: KBlue,
          weight: FontWeight.bold,
          size: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Ionicons.location_outline,
              color: Colors.grey,
            ),
            const SizedBox(width: 8.0),
            Txt(
              data["location"],
              color: Colors.grey,
              weight: FontWeight.normal,
              size: 14,
            ),
          ],
        ),
        Txt(
          data["bio"],
          color: KPink,
          weight: FontWeight.normal,
          size: 14,
        ),
      ],
    );
  }
}

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width * .35,
        child: Card(
          elevation: 8,
          shadowColor: KBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: ClipRRect(
            child: Image.network(
              data["imageUrl"],
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
