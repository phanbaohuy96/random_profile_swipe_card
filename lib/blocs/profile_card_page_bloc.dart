import 'dart:async';
import 'dart:math';

import 'package:random_profile_swipe_card/base/bloc_base.dart';
import 'package:random_profile_swipe_card/data/mock/mock_data.dart';
import 'package:random_profile_swipe_card/data/models/user.dart';

enum ProfileCardState { INITIAL, LOADING, NONE}

class ProfileCardBloc extends BlocBase {
  final StreamController<ProfileCardState> _controller;

  ProfileCardBloc() : _controller = StreamController<ProfileCardState>.broadcast();

  ProfileCardState defaultItem = ProfileCardState.INITIAL;

  Stream<ProfileCardState> get itemStream => _controller.stream;

  //properties
  List<User> users = [];

  Future<void> getUser() async{
    changeListState(ProfileCardState.LOADING);
    appApiService.client.getUser().then((result) {
      users.add(result.users[0].user);
      appApiService.client.getUser().then((user) {
        users.add(result.users[0].user);
        changeListState(ProfileCardState.NONE);
      }).catchError((onError) {
        changeListState(ProfileCardState.NONE);
      });
    }).catchError((onError) {
      changeListState(ProfileCardState.LOADING);
    });
  }

  Future<User> addUser() async{
    var result = await appApiService.client.getUser();
    if(result != null && result.users.length > 0) {
      users.add(result.users[0].user);
      changeListState(ProfileCardState.NONE);
    }
    return result.users[0].user;
  }

  //---------------------------- MOCK-DATA ----------------------------//

  Random random = Random();

  Future<void> getUserMock() async{
    changeListState(ProfileCardState.LOADING);
    users.add(ResultUser.fromMockdata(user1).users[0].user);
    users.add(ResultUser.fromMockdata(user2).users[0].user);
    changeListState(ProfileCardState.NONE);
  }

  Future<User> addUserMock() async{
    int dataIdx = random.nextInt(5);
    var user;
    switch (dataIdx) {
      case 0:
        user = ResultUser.fromMockdata(user1).users[0].user;
        break;
      case 1:
        user = ResultUser.fromMockdata(user2).users[0].user;
        break;
      case 2:
        user = ResultUser.fromMockdata(user3).users[0].user;
        break;
      case 3:
        user = ResultUser.fromMockdata(user4).users[0].user;
        break;
      case 4:
        user = ResultUser.fromMockdata(user5).users[0].user;
        break;
      default: user = ResultUser.fromMockdata(user5).users[0].user;
    }
    users.add(user);
    return user;
  }

  //---------------------------- MOCK-DATA ----------------------------//

  void changeListState(ProfileCardState state) {
    if (!_controller.isClosed) _controller?.sink?.add(state);
  }

  @override
  void dispose() {
    _controller?.close();
  }
}
