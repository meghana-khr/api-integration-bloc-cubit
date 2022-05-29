import 'dart:async';
import 'package:api_integration/cubit_state/userInfo_state.dart';
import 'package:api_integration/model/api_model.dart';
import 'package:api_integration/network/apiServices.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class UserInformationCubit extends Cubit<UserInfoState> {
  UserInformationCubit() : super(UserInfoStateInitial());

  List<UserInformationModel> userInformationList = [];

  var _userInformationController =
      BehaviorSubject<List<UserInformationModel>>();

  Stream<List<UserInformationModel>> get userInformationStream =>
      _userInformationController.stream;

  void getUserInformation() {
    emit(UserInfoLoading());
    UserService().getUserDetails().then((value) {
      if (value == null) {
        userInformationList = [];
        _userInformationController.add([]);
        emit(UserInfoSuccessful());
      } else {
        userInformationList = value;
        _userInformationController.add(value);
        emit(UserInfoSuccessful());
      }
    }).catchError((error) {
      emit(UserInfoFailure());
    });
  }
}
