import 'package:flutter/material.dart';
import 'sizecontrol.dart';

class editorpage extends StatefulWidget {
  const editorpage({super.key});

  @override
  State<editorpage> createState() => _editorpageState();
}

List a = ["一", "二", "三", "四", "五", "六", "天"];

class _editorpageState extends State<editorpage> {
  DateTime datetime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: Adapt.pt(95),
            ),
            Text(
              "编辑日记",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Color(0xFF7B9F4D),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white,Color(0xFFEFFCDE)]
          )
        ),
        child: Column(
          children: [
            SizedBox(
              height: Adapt.pt(10),
            ),
             Container(
               child: RichText(
                 text: TextSpan(
                   children: [
                     TextSpan(
                       text: datetime.month.toString(),
                       style: TextStyle(fontSize: Adapt.pt(20),color: Colors.black),
                     ),
                     TextSpan(
                       text: "月",
                       style: TextStyle(fontSize: Adapt.pt(20),color: Colors.black),
                     ),
                     TextSpan(
                       text: datetime.day.toString(),
                       style: TextStyle(fontSize: Adapt.pt(20),color: Colors.black),
                     ),
                     TextSpan(
                       text: "日",
                       style: TextStyle(fontSize: Adapt.pt(20),color: Colors.black),
                     ),
                     TextSpan(
                       text: "  ", // SizedBox的宽度转换为空格
                       style: TextStyle(fontSize: Adapt.pt(20),color: Colors.black),
                     ),
                     TextSpan(
                       text: "星期",
                       style: TextStyle(fontSize: Adapt.pt(20),color: Colors.black),
                     ),
                     TextSpan(
                       text: a[datetime.weekday - 1],
                       style: TextStyle(fontSize: Adapt.pt(20),color: Colors.black),
                     ),
                     TextSpan(
                       text: "  ", // SizedBox的宽度转换为空格
                       style: TextStyle(fontSize: Adapt.pt(20),color: Colors.black),
                     ),
                     TextSpan(
                       text: datetime.hour.toString(),
                       style: TextStyle(fontSize: Adapt.pt(20),color: Colors.black),
                     ),
                     TextSpan(
                       text: ":",
                       style: TextStyle(fontSize: Adapt.pt(20),color: Colors.black),
                     ),
                     TextSpan(
                       text: "  ", // SizedBox的宽度转换为空格
                       style: TextStyle(fontSize: Adapt.pt(20),color: Colors.black),
                     ),
                     TextSpan(
                       text: datetime.minute.toString(),
                       style: TextStyle(fontSize: Adapt.pt(20),color: Colors.black),
                     ),
                   ],
                 ),
               ),
             ),
            SizedBox(
              height: Adapt.pt(10),
            ),
            Text("注意：对以前的日记进行编辑时，时间显示第一次创建该日记的时刻",style: TextStyle(
              fontSize: Adapt.pt(12),color: Color(0xFF888888)
            ),),
            TextField(

            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: Adapt.pt(60),
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.location_on_outlined)),
          ],
        ),
      ),
    );
  }
}
