import 'dart:io';

import 'package:diary/mainpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diary/sizecontrol.dart';
import './data.dart';

var visible = false;
TextEditingController _controllerId = TextEditingController();
TextEditingController _controllerS = TextEditingController();
void _doExit() {
  exit(0);
}

class RInterface extends StatelessWidget {
  const RInterface({super.key});

  @override
  Widget build(BuildContext context) {
    Adapt.initialize(context);
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF7B9F4D),
      ),
      body: Container(
          width: double.maxFinite,
          decoration: new BoxDecoration(
            color: Color(0xFFDCEEC4),
          ),
          child: 
          RInterfaceText(),
          ),
    ));
  }
}

class RInterfaceText extends StatelessWidget {
  RInterfaceText({super.key});
  var register = RegisterFunction();
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: Adapt.hpt(57)),
            alignment: Alignment.center,
            child: Row(
              children: [
                Text(
                  '用户名',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Adapt.pt(20),
                    color: Color(0xFF445B28),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(Adapt.pt(5)),
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(
                            color: Color.fromARGB(255, 248, 248, 248),
                            width: 0.5),
                        borderRadius: BorderRadius.circular((30.0))),
                    child: TextField(
                        controller: _controllerId,
                        decoration: InputDecoration(
                            hintText: "请输入3-8个数字、字母或汉字",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: Adapt.pt(7),
                                horizontal: Adapt.pt(10)),
                            border: InputBorder.none)),
                  ),
                )
              ],
            ),
            height: Adapt.pt(35),
            width: Adapt.pt(349),
          ),
          Container(
            margin: EdgeInsets.only(top: Adapt.hpt(57)),
            alignment: Alignment.center,
            child: Row(
              children: [
                Text(
                  '  密 码 ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Adapt.pt(20),
                      color: Color(0xFF445B28)),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(Adapt.pt(5)),
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(
                            color: Color.fromARGB(255, 248, 248, 248),
                            width: 0.5),
                        borderRadius: BorderRadius.circular((30.0))),
                    child: TextField(
                        controller: _controllerS,
                        decoration: InputDecoration(
                            hintText: "请输入密码",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: Adapt.pt(7),
                                horizontal: Adapt.pt(10)),
                            border: InputBorder.none)),
                  ),
                )
              ],
            ),
            height: Adapt.pt(35),
            width: Adapt.pt(349),
          ),
          Container(
            margin: EdgeInsets.only(top: Adapt.pt(70)),
            child: ElevatedButton(
              child: Text(
                '立即注册',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: Adapt.pt(25)),
              ),
              onPressed: () async{
               await register.postFunctionR(
                    _controllerId.text, _controllerS.text);
                if ( register.user.code == 200) {
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context) => mainpage()));
                } 
                else {
                  String? text = register.user.message;
                 showMessage(context,text!);
                }
              },
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                      Size(Adapt.pt(207), Adapt.pt(60))),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
                  backgroundColor:
                      MaterialStateProperty.all(Color(0xFF7B9F4D))),
            ),
          ),
          TextButton(
              onPressed: () async {
                showMyMaterialDialog(context, await GetFuction());
              },
              child: Text('注册代表同意《用户协议》',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF445B28),
                      fontSize: Adapt.pt(12)))),
        ]);
  }
}

void showMyMaterialDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          title: Center(child: Text("服务协议和隐私政策")),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          content: Container(
            height: 300,
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Text(text),
                  ),
                ),
                height: 250,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  width: 2, color: Color(0xffDCDCDC))),
                        ),
                        alignment: Alignment.bottomCenter,
                        height: 40,
                        child: Text(
                          '暂不使用',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        _doExit();
                      },
                    ),
                  ),
                  Expanded(
                      child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top:
                                BorderSide(width: 2, color: Color(0xffDCDCDC))),
                      ),
                      alignment: Alignment.bottomCenter,
                      height: 40,
                      child: Text(
                        '同意',
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff1563BF)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ))
                ],
              )
            ]),
          ));
    },
  );
}

void showMessage(BuildContext context, String  text) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("注册失败"),
        content:  Text(text),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("确定")),
        ],
      );
    },
  );
}
