import 'package:flutter/material.dart';
import 'package:diary/sizecontrol.dart';

TextEditingController _controllerId = TextEditingController();
TextEditingController _controllerS = TextEditingController();

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
        child: RInterfaceText(),
      ),
    ));
  }
}

class RInterfaceText extends StatelessWidget {
  const RInterfaceText({super.key});

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
              onPressed: () {

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
              onPressed: () {},
              child: Text('注册代表同意《用户协议》',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF445B28),
                      fontSize: Adapt.pt(12)))),
        ]);
  }
}
