
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';

import '../models/User.dart';
import '../services/RoomService.dart';
import '../views/HomePage.dart';

class RoomController extends GetxController
    implements HMSUpdateListener, HMSActionResultListener {



  List<User> usersList = <User>[].obs;

  RxBool isLocalAudioOff = false.obs;

  String url;
  String name;

  RoomController(this.url, this.name);

  HMSSDK hmsSdk = HMSSDK();



  @override
  void onInit() async {

    joinMeeting();

    super.onInit();
  }

  void joinMeeting() async{


    hmsSdk.addUpdateListener(listener: this);

    hmsSdk.build();

    String userName = name;

    List<String?>? token = await RoomService().getToken(user: userName, room: url);




    if (token == null) return;
    if (token[0] == null) return;



    HMSConfig config = HMSConfig(
      authToken: token[0]!,
      userName: name,
      endPoint: token[1] == "true" ? "" : "https://qa-init.100ms.live/init",
    );

    hmsSdk.join(config: config);


  }

  @override
  void onChangeTrackStateRequest(
      {required HMSTrackChangeRequest hmsTrackChangeRequest}) {
    // TODO: implement onChangeTrackStateRequest
  }

  @override
  void onError({required HMSException error}) {
    Get.snackbar("Error", error.message);
  }

  @override
  void onJoin({required HMSRoom room}) {

  }

  @override
  void onMessage({required HMSMessage message}) {
    // TODO: implement onMessage
  }

  @override
  void onPeerUpdate({required HMSPeer peer, required HMSPeerUpdate update}) {
    if (update == HMSPeerUpdate.peerLeft) {
      removeUserFromList(peer);
    }
  }

  @override
  void onReconnected() {
    Get.snackbar("Reconnected", "We are Back");
  }

  @override
  void onReconnecting() {
    Get.snackbar("Reconnecting", "Please Wait");
  }

  @override
  void onRemovedFromRoom(
      {required HMSPeerRemovedFromPeer hmsPeerRemovedFromPeer}) {
    // TODO: implement onRemovedFromRoom
  }

  @override
  void onRoleChangeRequest({required HMSRoleChangeRequest roleChangeRequest}) {
    // TODO: implement onRoleChangeRequest
  }

  @override
  void onRoomUpdate({required HMSRoom room, required HMSRoomUpdate update}) {
    // TODO: implement onRoomUpdate
  }

  @override
  void onTrackUpdate(
      {required HMSTrack track,
      required HMSTrackUpdate trackUpdate,
      required HMSPeer peer}) {
    // isLocalAudioOn.value = isAudioOnPreview.value;
    // isLocalAudioOn.refresh();
    //
    // isLocalVideoOn.value = isVideoOnPreview.value;
    // isLocalVideoOn.refresh();

    if (peer.isLocal) {

      if (track.kind == HMSTrackKind.kHMSTrackKindAudio) {
        if(isLocalAudioOff.value != track.isMute){
          isLocalAudioOff.toggle();
        }
      }

    }

    if (track.kind == HMSTrackKind.kHMSTrackKindAudio) {
      User user = User(track as HMSAudioTrack,peer);

      if (!usersList.contains(user)) {
        usersList.add(user);
      } else {
        int userIndex = usersList.indexOf(user);
        usersList.removeAt(userIndex);
        usersList.insert(userIndex, user);
      }
    }
  }

  @override
  void onUpdateSpeakers({required List<HMSSpeaker> updateSpeakers}) {
    // if(updateSpeakers.isEmpty)
    //   return;
    // HMSSpeaker hmsSpeaker = updateSpeakers[0];
    // int userIndex = usersList.indexWhere((element) => element.peer.peerId == hmsSpeaker.peer.peerId);
    // User user = usersList[userIndex];
    // user.isSpeaking = true;
    // print("onUpdateSpeakers ${userIndex}");
    // usersList.removeAt(userIndex);
    // usersList.insert(userIndex, user);
  }

  void leaveMeeting() async {
    hmsSdk.leave(hmsActionResultListener: this);
  }

  void toggleAudio() async {
    var result = await hmsSdk.switchAudio(isOn: !isLocalAudioOff.value);
    if (result == null) {
      isLocalAudioOff.toggle();
    }
  }


  @override
  void onException(
      {HMSActionResultListenerMethod? methodType,
      Map<String, dynamic>? arguments,
      required HMSException hmsException}) {
    Get.snackbar("Error", hmsException.message);
  }

  @override
  void onSuccess(
      {HMSActionResultListenerMethod? methodType,
      Map<String, dynamic>? arguments}) {
    usersList.clear();
    Get.back();
  }

  void removeUserFromList(HMSPeer peer) {
    usersList.removeWhere((element) => peer.peerId == element.peer.peerId);
  }

  @override
  void onLocalAudioStats({required HMSLocalAudioStats hmsLocalAudioStats, required HMSLocalAudioTrack track, required HMSPeer peer}) {
    // TODO: implement onLocalAudioStats
  }

  @override
  void onLocalVideoStats({required HMSLocalVideoStats hmsLocalVideoStats, required HMSLocalVideoTrack track, required HMSPeer peer}) {
    // TODO: implement onLocalVideoStats
  }

  @override
  void onRTCStats({required HMSRTCStatsReport hmsrtcStatsReport}) {
    // TODO: implement onRTCStats
  }

  @override
  void onRemoteAudioStats({required HMSRemoteAudioStats hmsRemoteAudioStats, required HMSRemoteAudioTrack track, required HMSPeer peer}) {
    // TODO: implement onRemoteAudioStats
  }

  @override
  void onRemoteVideoStats({required HMSRemoteVideoStats hmsRemoteVideoStats, required HMSRemoteVideoTrack track, required HMSPeer peer}) {
    // TODO: implement onRemoteVideoStats
  }
}
