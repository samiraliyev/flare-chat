class MessageModel {
  String? clock;
  String? username;
  String? message;
  String? id;

  MessageModel({this.clock, this.username, this.message, this.id});

  MessageModel.fromJson(Map<String, dynamic> json) {
    clock = json['clock'];
    username = json['username'];
    message = json['message'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clock'] = clock;
    data['username'] = username;
    data['message'] = message;
    data['id'] = id;
    return data;
  }
}
