import 'package:api_integration/model/api_model.dart';
import 'package:api_integration/screen/userDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_state/userInfo_cubit.dart';
import 'cubit_state/userInfo_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "User Details",
      theme: ThemeData(primarySwatch: Colors.teal),
      debugShowCheckedModeBanner: false,
      // home: new UserDetailWidget()
      home: BlocProvider<UserInformationCubit>(
          create: (context) => UserInformationCubit(),
          child: UserDetailWidget()),
    );
  }
}
