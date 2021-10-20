import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:wechive/app/modules/auth/controllers/auth_controller.dart';
import 'package:wechive/app/routes/app_pages.dart';
import 'package:wechive/core/consts.dart';
import 'package:wechive/core/models/user_model.dart';
import 'package:wechive/core/widgets/Text.dart';

class CompleteProfile extends GetView<AuthController> {
  // single choice value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50.0),
                  Txt(
                    "Complete your profile",
                    size: 24,
                    weight: FontWeight.bold,
                    color: KBlue,
                  ),
                  const SizedBox(height: 12.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Txt(
                      "Add a Image, name, bio, age and location  to let people know who you are",
                      size: 16,
                      color: KPink,
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Obx(
                    () => GestureDetector(
                      onTap: () => controller.pickImage(),
                      child: Stack(
                        children: [
                          CircleAvatar(
                              backgroundColor: KBlue,
                              radius: 50,
                              child: controller.imagePicked == false
                                  ? Icon(
                                      Ionicons.image,
                                      color: Colors.white,
                                      size: 40,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.file(
                                        controller.image,
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      ),
                                    )),
                          Positioned(
                            child: Card(
                              child: Icon(
                                Ionicons.add,
                                color: Colors.blue,
                                size: 25,
                              ),
                              shape: CircleBorder(),
                            ),
                            right: 2,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Txt(
                      "Choose your interests",
                      color: KBlue,
                    ),
                  ),
                  MultiSelectDialogField(
                    title: Txt("Please choose your interests"),
                    confirmText: Text("Confirm"),
                    items: controller.allInterests
                        .map((e) => MultiSelectItem(e, e))
                        .toList(),
                    listType: MultiSelectListType.CHIP,
                    chipDisplay: MultiSelectChipDisplay(
                      chipColor: KBlue,
                      textStyle: Theme.of(context).textTheme.headline5,
                      icon:
                          Icon(Ionicons.checkmark_circle, color: Colors.white),
                    ),
                    onConfirm: (values) {
                      controller.selectedInterests = values;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TxtButton(
                    onPressed: () async {
                      List interests =
                          controller.selectedInterests.map((e) => e).toList();
                      print(interests);
                      final Map<String, dynamic> user = FirebaseUser(
                        uid: controller.user.value!.uid,
                        username: controller.user.value!.displayName,
                        age: "not yet added",
                        location: "not yet added",
                        phoneNumber: controller.user.value!.phoneNumber,
                        bio: "not yet added",
                        imageUrl: controller.user.value!.photoURL,
                        interests: interests,
                      ).toJson();
                      await controller.addUser(user).then(
                          (value) => Get.offAllNamed(Routes.BOTTOM_NAV_BAR));
                    },
                    label: Txt(
                      "Complete profile",
                      color: Colors.white,
                      weight: FontWeight.bold,
                    ),
                    backgroundColor: KBlue,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TxtButton extends StatelessWidget {
  const TxtButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.backgroundColor = Colors.black,
    this.elevation = 4.0,
  }) : super(key: key);
  final void Function()? onPressed;
  final Widget label;
  final Color backgroundColor;
  final double elevation;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            elevation: elevation,
            shadowColor: backgroundColor,
            backgroundColor: backgroundColor,
            minimumSize: Size.fromHeight(64)),
        onPressed: onPressed,
        child: label);
  }
}
