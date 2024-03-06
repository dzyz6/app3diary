
class Users {
  int? code;
  String? message;
  Data? data;

  Users({this.code, this.message, this.data});

  Users.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? uid;
  String? username;
  String? token;
  String? nickname;

  Data({this.uid, this.username, this.token, this.nickname});

  Data.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    username = json['username'];
    token = json['token'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['token'] = this.token;
    data['nickname'] = this.nickname;
    return data;
  }
}