import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_spaces_demo/services/Constants.dart';
import 'package:twitter_spaces_demo/views/UserAvatar.dart';

import '../controllers/RoomController.dart';

class RoomWidget extends StatelessWidget {
  late final RoomController roomController;
  final String name;

  RoomWidget({required this.name, Key? key}) : super(key: key) {
    roomController = Get.put(RoomController(Constant.defaultRoomID, name));
  }

  var rng = Random();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 70.0,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black, //New
                        blurRadius: 1.0,
                        offset: Offset(0, 1))
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Spaces",
                    style: TextStyle(
                        fontSize: 30.0,
                        backgroundColor: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: GestureDetector(
                    onTap: () {
                      roomController.leaveMeeting();
                    },
                    child: const Text(
                      "Leave",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    )),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: const Text(
                    "Building a Twitter Spaces Clone with Flutter 100ms SDK and Getx",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Flexible(
                child: GetX<RoomController>(builder: (controller) {
                  return GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    children: List.generate(
                      controller.usersList.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: UserAvatar(index),
                        );
                      },
                    ),
                  );
                }),
              )
            ],
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetX<RoomController>(builder: (controller) {
                return GestureDetector(
                    onTap: () {
                      controller.toggleAudio();
                    },
                    child: Icon(
                      controller.isLocalAudioOff.value
                          ? Icons.mic_off
                          : Icons.mic,
                      size: 40.0,
                    ));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
