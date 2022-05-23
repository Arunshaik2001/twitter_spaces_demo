import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:twitter_spaces_demo/controllers/RoomController.dart';
import 'package:twitter_spaces_demo/models/User.dart';

class UserAvatar extends StatelessWidget {
  final int index;

  UserAvatar(this.index, {Key? key}) : super(key: key);

  final List<Color> randomList = [
    Colors.red,
    Colors.brown,
    Colors.lightBlueAccent,
    Colors.orangeAccent,
    Colors.deepPurpleAccent,
    Colors.lightGreen,
    Colors.purpleAccent
  ];

  @override
  Widget build(BuildContext context) {
    return GetX<RoomController>(builder: (controller) {
      print("IsVideoOn ${controller.usersList[index].isSpeaking}");
      //User user = controller.usersList[index];
      return SizedBox(
          height: 500.0,
          width: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  backgroundColor: randomList[index % (randomList.length)],
                  radius: 36,
                  child: Text(
                    controller.usersList[index].peer.name[0],
                    style: const TextStyle(fontSize: 36, color: Colors.white),
                  )),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                controller.usersList[index].peer.name,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/audio_waves.png",
                    scale: 20,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    controller.usersList[index].peer.role.name,
                  )
                ],
              ),
            ],
          ));
      ;
    });
  }
}
