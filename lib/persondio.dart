import 'package:dio/dio.dart';

Future<bool> Logoff(String token)async {
    Dio dio =  Dio();
    String url = "http://8.130.98.175:8080/logout";
    dio.options.baseUrl=url;
    dio.options.headers['token']=token;
    Response response =  await dio.get(url);
    if(response.data['code']==200)
    {
      return true;
    }
    else {
      return false;
    }
}

Future<UserMessage> tokenTest(String token)async {
    Dio dio =  Dio();
    String url = "http://172.23.146.5:25565/";
    dio.options.baseUrl=url;
    dio.options.headers['token']=token;
    Response response =  await dio.get(url);
    var usermessage = UserMessage.fromJson(response.data);
    return usermessage;
}


class UserMessage {
  int ?code;
  String? message;
  Data ?data;

  UserMessage({this.code, this.message, this.data});

  UserMessage.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  int? uid;
  String? username;
  String ?nickname;
  String ?gender;
  String ?birthDate;
  int ?journalCount;
  int ?journalGroupCount;
  String? location;
  String ?backgroundImage;
  String ?userProfilePicture;
  Data(
      {this.uid,
      this.username,
      this.nickname,
      this.gender,
      this.birthDate,
      this.journalCount,
      this.journalGroupCount,
      this.location,
      this.backgroundImage,
      this.userProfilePicture});

  Data.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    username = json['username'];
    nickname = json['nickname'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    journalCount = json['journalCount'];
    journalGroupCount = json['journalGroupCount'];
    location = json['location'];
    backgroundImage = json['backgroundImage'];
    userProfilePicture = json['userProfilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['nickname'] = this.nickname;
    data['gender'] = this.gender;
    data['birthDate'] = this.birthDate;
    data['journalCount'] = this.journalCount;
    data['journalGroupCount'] = this.journalGroupCount;
    data['location'] = this.location;
    data['backgroundImage'] = this.backgroundImage;
    data['userProfilePicture'] = this.userProfilePicture;
    return data;
  }
}




