import 'dart:convert';
import 'package:api_integration/model/api_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<List<UserInformationModel>?> getUserDetails() async {
    String _url = "https://gorest.co.in/public/v2/users";
    try {
      var response = await http.get(
        Uri.parse(_url),
      );
      if (response.statusCode == 200) {
        var jsonString = json.decode(response.body);
        if (jsonString == null) {
          return [];
        }
        List<UserInformationModel> userDetails =
            (json.decode(response.body) as List)
                .map((data) => UserInformationModel.fromJson(data))
                .toList();
        return userDetails;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
