import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wechive/app/modules/auth/controllers/auth_controller.dart';
import 'package:wechive/core/consts.dart';
import 'package:wechive/core/widgets/Text.dart';
import 'package:wechive/core/widgets/TxtForm.dart';

class CompleteProfile extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Center(
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
                  const SizedBox(height: 24.0),
                  Obx(
                    () => GestureDetector(
                      onTap: () => controller.pickImage(),
                      child: Stack(
                        children: [
                          CircleAvatar(
                              radius: 50,
                              child: controller.imagePicked == false
                                  ? Icon(
                                      Ionicons.image,
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
                  const SizedBox(height: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(
                        "Location",
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                      Obx(
                        () => DropdownButtonFormField<String>(
                          autovalidateMode: AutovalidateMode.always,
                          itemHeight: 70,
                          validator:
                              RequiredValidator(errorText: "Can't be empty"),
                          elevation: 4,
                          disabledHint: Text("Stopped"),
                          value: controller.userLocation.value,
                          onChanged: (value) {
                            controller.userLocation.value = value.toString();
                          },
                          items: controller.country_list.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Txt(
                                value,
                                size: 16,
                                color: KBlue,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
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
