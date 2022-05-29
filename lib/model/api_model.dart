class UserInformationModel {
  int? id;
  String? name;
  String? email;
  String? gender;
  String? status;

  UserInformationModel({this.id, this.name, this.email, this.gender, this.status});

  UserInformationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    var data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['status'] = this.status;
    return data;
  }
}

