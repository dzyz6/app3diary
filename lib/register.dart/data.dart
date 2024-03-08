import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import'package:diary/user.dart';
String encryptMd5(String str) {
 final utf = utf8.encode(str);
 final digest = md5.convert(utf);
 final encryptStr = digest.toString(); 
 return encryptStr;
}


class RegisterFunction{
  RegisterFunction();
var  user = Users();
Future<void> tokenTest(String token)async {
    Dio dio =  Dio();
    String url = "http://172.23.146.5:25565/createJournal";
    dio.options.baseUrl=url;
    dio.options.headers['token']=token;
   Map<String,dynamic> map = Map();
    map['location']='saddsd';
    map['journalTitle']='aaaaa';
    map['journalText']='aaaaa';
    map['topJournal']=0;
    Response response =  await dio.post(url,data: map);
  print(response);
  print('aaaaaaaaaaaaaaaaaaaaaaaaa');

}


 Future <void> postFunctionR(String username,String password) async{
    String url = "http://172.23.146.5:25565/register";
    Dio dio =  Dio();
    dio.options.baseUrl=url;
    dio.options.headers.addAll({'token':user.data?.token});
    Map<String,dynamic> map = Map();
    map['username']=username;
    map['password']=password;
    map['password']=encryptMd5(map['password']);
    Response response =  await dio.post(url,data: map);
 user =Users.fromJson(response.data);
  print(user.data?.uid);
  print(user.code);
  }
}
Future<String> GetFuction() async{
    String url = "http://172.23.146.5:25565/userAgreement";
    Dio dio = new Dio();
    dio.options.baseUrl=url;
    Response response = await dio.get(url);
    var text = LongText.fromJson(response.data);
    return text.data;
  }
class LongText {
  late int code;
  late String message;
  late String data;

  LongText({required this.code,required this.message,required this.data});

  LongText.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}