import 'package:hmssdk_flutter/hmssdk_flutter.dart';

class User {
  HMSAudioTrack hmsAudioTrack;
  bool isSpeaking;
  HMSPeer peer;

  User(this.hmsAudioTrack, this.peer, {this.isSpeaking = false});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          hmsAudioTrack == other.hmsAudioTrack;

  @override
  String toString() {
    return 'User{isVideoOn: $isSpeaking}';
  }

  @override
  int get hashCode => hmsAudioTrack.hashCode ^ peer.hashCode;
}
