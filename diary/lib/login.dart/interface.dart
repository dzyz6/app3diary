import 'package:diary/register.dart/interface.dart';
import 'package:flutter/material.dart';
import 'package:diary/sizecontrol.dart';

bool visible = true;

class Interface extends StatelessWidget {
  const Interface({super.key});

  @override
  Widget build(BuildContext context) {
    Adapt.initialize(context);
    return MaterialApp(
        home: Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: new BoxDecoration(
          color: Color(0xFFDCEEC4),
        ),
        child: InterfaceText(),
      ),
    ));
  }
}

class InterfaceText extends StatelessWidget {
  const InterfaceText({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    SingleChildScrollView(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Adapt.pt(490),
            height: Adapt.pt(490),
            child: Image.asset(
              'assets/images/login1.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Adapt.hpt(10)),
            alignment: Alignment.center,
            child: Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(Adapt.pt(5)),
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(
                        color: Color.fromARGB(255, 248, 248, 248), width: 0.5),
                    borderRadius: BorderRadius.circular((30.0))),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: "请输入3-8个数字、字母或汉字",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: Adapt.pt(7), horizontal: Adapt.pt(20)),
                        border: InputBorder.none)),
              ),
            ),
            height: Adapt.pt(48),
            width: Adapt.pt(295),
          ),
          visible
              ? Container(
                  width: Adapt.pt(255),
                  alignment: Alignment.centerLeft,
                  child: Text('请输入正确的用户名',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 255, 7, 7),
                          fontSize: 12)))
              : Container(),
          Container(
            margin: EdgeInsets.only(top: Adapt.hpt(10)),
            alignment: Alignment.center,
            child: Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(Adapt.pt(5)),
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(
                        color: Color.fromARGB(255, 248, 248, 248), width: 0.5),
                    borderRadius: BorderRadius.circular((30.0))),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: "请输入密码",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: Adapt.pt(7), horizontal: Adapt.pt(20)),
                        border: InputBorder.none)),
              ),
            ),
            height: Adapt.pt(48),
            width: Adapt.pt(295),
          ),
                    visible
              ? Container(
                  width: Adapt.pt(255),
                  alignment: Alignment.centerLeft,
                  child: Text('请输入正确的密码',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 255, 7, 7),
                          fontSize: 12)))
              : Container(),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text('忘记登录密码',
                        style: TextStyle(
                            color: Color(0xFF445B28), fontSize: Adapt.pt(12)))),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RInterface()));
                    },
                    child: Text('注册',
                        style: TextStyle(
                            color: Color(0xFF445B28), fontSize: Adapt.pt(12)))),
              ],
            ),
            width: Adapt.pt(295),
          ),
          Container(
            margin: EdgeInsets.only(top: Adapt.pt(10)),
            child: ElevatedButton(
              child: Text(
                '登录',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: Adapt.pt(25)),
              ),
              onPressed: () {},
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                      Size(Adapt.pt(207), Adapt.pt(60))),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
                  backgroundColor:
                      MaterialStateProperty.all(Color(0xFF7B9F4D))),
            ),
          ),
        ]),)
    ;
  }
}
