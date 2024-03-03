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
class LoginFunction{
 var user =Users();
  LoginFunction();
 Future <void> postFunctionR(String username,String password) async{
    String url = "http://172.23.146.5:25565/login";
    Dio dio = new Dio();
    dio.options.baseUrl=url;
    Map<String,dynamic> map = Map();
    map['username']=username;
    map['password']=password;
    map['password']=encryptMd5(map['password']);
    Response response =  await dio.post(url,data: map);
   user = Users.fromJson(response.data);
    print(user.message);
  }
}
