import 'package:flutter/material.dart';
import 'package:twitter_spaces_demo/Models/TwitterSpace.dart';
import 'dart:math';

class TwitterSpaceCardWidget extends StatelessWidget {
  TwitterSpaceCardWidget({Key? key}) : super(key: key);

  final List<Color> randomList = [
    Colors.red,
    Colors.brown,
    Colors.lightBlueAccent,
    Colors.orangeAccent,
    Colors.deepPurpleAccent,
    Colors.lightGreen,
    Colors.purpleAccent
  ];

  var rng = Random();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: randomList[rng.nextInt(randomList.length)],
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              const SizedBox(
                width: 5.0,
              ),
              Image.asset(
                "assets/icons/audio_waves.png",
                scale: 10,
              ),
              const SizedBox(
                width: 5.0,
              ),
              const Text(
                "Live",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: const [
              SizedBox(
                width: 5.0,
              ),
              Flexible(
                child: Text(
                  "Building a Twitter Spaces Clone with Flutter 100ms SDK and Getx",
                  style: TextStyle(color: Colors.white,fontSize: 20.0),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              const SizedBox(
                width: 5.0,
              ),
              ClipOval(
                  child: Image.asset(
                "assets/icons/avatar.png",
                fit: BoxFit.cover,
                scale: 10,
              )),
              const SizedBox(
                width: 8.0,
              ),
              const Text("1 Listening",style: TextStyle(color: Colors.white),)
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              const SizedBox(
                width: 5.0,
              ),
              ClipOval(
                  child: Image.asset(
                "assets/icons/avatar.png",
                fit: BoxFit.cover,
                scale: 20,
              )),
              const SizedBox(
                width: 5.0,
              ),
              Container(child: const Text("Host",style: TextStyle(color: Colors.white),))
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
