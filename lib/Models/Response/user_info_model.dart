class UserInfoModel {
  String? email;
  String? image;
  String? password;
  String? userId;
  String? username;
  String? phone;

  UserInfoModel({this.email, this.image, this.password, this.userId, this.username, this.phone});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    image = json['image'];
    password = json['password'];
    userId = json['userId'];
    username = json['username'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['image'] = image;
    data['password'] = password;
    data['userId'] = userId;
    data['username'] = username;
    data['phone'] = phone;
    return data;
  }
}
