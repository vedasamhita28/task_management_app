class UserModel {
  String? name;
  bool? isTLuser;
  String? userId;
  String? email;
  String? fcmtoken;

  UserModel({this.name, this.isTLuser, this.userId, this.email, this.fcmtoken});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isTLuser = json['isTLuser'];
    userId = json['userId'];
    email = json['email'];
    fcmtoken = json['fcmToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['isTLuser'] = isTLuser;
    data['userId'] = userId;
    data['email'] = email;
    data['fcmToken'] = fcmtoken;
    return data;
  }
}
