import 'package:dio/dio.dart';
import 'dart:convert';

void main() {
postRequestFunction2();
}
void postRequestFunction2() async{
    String url = "http://192.168.124.13:4523/m1/3967937-0-default/register";
    ///创建Dio
    Dio dio = new Dio();
    ///创建Map 封装参数
    Map<String,dynamic> map = Map();
    map['username']="1205874457";
    map['password']="1234";
    print(map);
    ///发起post请求
    Response response =  await dio.post(url,data: map);

    var data= jsonDecode(response.toString());//3
    print(response);
  }

