import 'package:api_integration/cubit_state/userInfo_cubit.dart';
import 'package:api_integration/cubit_state/userInfo_state.dart';
import 'package:api_integration/model/api_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailWidget extends StatefulWidget {
  @override
  _UserDetailWidgetState createState() => _UserDetailWidgetState();
}

class _UserDetailWidgetState extends State<UserDetailWidget> {
  List<UserInformationModel> _userList = [];

  @override
  initState() {
    BlocProvider.of<UserInformationCubit>(context).getUserInformation();
    _userList =
        BlocProvider.of<UserInformationCubit>(context).userInformationList;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("User Details"))),
        body: BlocBuilder<UserInformationCubit, UserInfoState>(
          builder: (context, state) {
            if (state is UserInfoLoading) {
              return Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.only(top: 20),
                  child: const CircularProgressIndicator(
                    value: 0.8,
                  ));
            } else if (state is UserInfoFailure || state is UserInfoError) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: const Text("Api is not working!"),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            } else if (state is UserInfoSuccessful) {
              return Container(
                  child: StreamBuilder<List<UserInformationModel>>(
                      stream: BlocProvider.of<UserInformationCubit>(context)
                          .userInformationStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data == []) {
                            return const Center(
                                child: Text("No Records found"));
                          } else {
                            return displayList(snapshot.data, state);
                          }
                        } else {
                          return Center(
                            child: Container(
                                alignment: Alignment.topCenter,
                                margin: const EdgeInsets.only(top: 20),
                                child: const CircularProgressIndicator(
                                  value: 0.8,
                                )),
                          );
                        }
                      }));
            }
            return Container();
          },
        ));
  }
}

Widget displayList(List<UserInformationModel>? userdata, UserInfoState state) {
  return ListView.builder(
      itemCount: userdata!.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          dense: true,
          contentPadding: const EdgeInsets.only(bottom: 5),
          title: Text(userdata[index].name.toString()),
          leading: CircleAvatar(
              radius: 50, child: Text(userdata[index].email![0].toUpperCase())),
          //title:Text(_userList[index].id.toString())
        );
      });
}
