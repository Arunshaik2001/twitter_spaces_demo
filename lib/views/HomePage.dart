import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:twitter_spaces_demo/views/TwitterSpaceCardWidget.dart';

import 'RoomWidget.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final TextEditingController nameTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Happening Now",
          style: TextStyle(fontSize: 30.0),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                      title: "Join Space",
                      backgroundColor: Colors.green,
                      titleStyle: const TextStyle(color: Colors.white),
                      middleTextStyle: const TextStyle(color: Colors.white),
                      textConfirm: "Confirm",
                      textCancel: "Cancel",
                      cancelTextColor: Colors.white,
                      confirmTextColor: Colors.white,
                      buttonColor: Colors.red,
                      radius: 50,
                      onConfirm: () async{
                        if (!(GetUtils.isBlank(
                                nameTextEditingController.text) ??
                            true)) {
                          bool res = await getPermissions();
                          if(res) {
                            Get.back();
                            //print("DialogBox ${nameTextEditingController.text}");
                            Get.to(() => RoomWidget(name : nameTextEditingController.text));
                            //nameTextEditingController.clear();
                          }
                        }
                      },
                      content: SizedBox(
                        width: 200.0,
                        child: TextField(
                          controller: nameTextEditingController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Your Name',
                          ),
                        ),
                      ),);
                },
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: TwitterSpaceCardWidget(),
                ),
              );
            },
            itemCount: 6,
          ),
        )
      ],
    );
  }

  Future<bool> getPermissions() async {
    if (Platform.isIOS) return true;
    await Permission.microphone.request();
    await Permission.bluetoothConnect.request();

    while ((await Permission.microphone.isDenied)) {
      await Permission.microphone.request();
    }

    while ((await Permission.bluetoothConnect.isDenied)) {
      await Permission.bluetoothConnect.request();
    }
    return true;
  }
}


