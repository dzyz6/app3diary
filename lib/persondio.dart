
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

late var getUserMessage;

Future<void> ChangePImage(String token,XFile image) async {
  var attfile ;
    Future<FormData> FormData1() async {

attfile = await MultipartFile.fromFile(image.path,filename: image.name);

      return FormData.fromMap({
      'file': attfile,
    });

    }
    FormData fromdata = await FormData1() ;
  Dio dio = Dio();
  String url = "http://8.130.98.175/uploadUserProfilePicture";
  dio.options.baseUrl = url;
  dio.options.headers['token'] = token;
  Response response = await dio.post(url,data: fromdata);

  print(response);

}
Future<void> ChangeReadyImage(String token,int imagenum) async {
  Dio dio = Dio();
  String url = "http://8.130.98.175/setDefaultPictureByNum";
  dio.options.baseUrl = url;
  dio.options.headers['token'] = token;
   Map<String,dynamic> map = Map();
    map["background"] = 0;
    map["userProfilePicture"] = imagenum;
  Response response = await dio.put(url,data: map);
    print(response);


}


Future<void> ChangeNickName(String token,String nickname) async {
  Dio dio = Dio();
  String url = "http://8.130.98.175/changeUserInfo";
  dio.options.baseUrl = url;
  dio.options.headers['token'] = token;
   Map<String,dynamic> map = Map();
    map['nickname']=nickname;
    map['gender']=0;
    map['birthDate']="2004-10-22";
    map['location']='0';
  Response response = await dio.put(url,data: map);
  print(response);
}

Future<bool> logout(String token) async {
  Dio dio = Dio();
  String url = "http://8.130.98.175/logout";
  dio.options.baseUrl = url;
  dio.options.headers['token'] = token;
  Response response = await dio.get(url);
  if (response.data['code'] == 200) {
    return true;
  } else {
    return false;
  }
}
class GetUserMessage {
 var usermessage = UserMessage();

  GetUserMessage(String token);
Future<void> getUserMessage(String token) async {
  Dio dio = Dio();
  String url = "http://8.130.98.175/getUserInfo";
  dio.options.baseUrl = url;
  dio.options.headers['token'] = token;
  Response response = await dio.get(url);
  usermessage = UserMessage.fromJson(response.data);
}
}
class UserMessage {
  int? code;
  String? message;
  Data? data;

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
  String? nickname;
  String? gender;
  String? birthDate;
  int? journalCount;
  int? journalGroupCount;
  String? location;
  String? backgroundImage;
  String? userProfilePicture;
    int ? writeDays;
    int ? textCount;
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
      this.userProfilePicture,
      this.writeDays,
      this.textCount});

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
    writeDays = json['writeDays'];
    textCount = json['textCount'];
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
