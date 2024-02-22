import 'package:diary/assets/icon/my_flutter_app_icons.dart';
import 'package:diary/sizecontrol.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home: mainpage(),));
}

var colororigin=Color(0xFF445B28);
var colorclick=Color(0xFFDCEEC4);

//获取时间
DateTime dateTime= DateTime.now();

class mainpage extends StatefulWidget {
  const mainpage({super.key});

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: Adapt.pt(10),),
            Text(dateTime.month.toString(),style: TextStyle(color: Colors.white,fontSize: Adapt.pt(25)),),
            SizedBox(width: Adapt.pt(3),),
            Text("月",style: TextStyle(color: Colors.white,fontSize: Adapt.pt(25)),),
            SizedBox(width: Adapt.pt(10),),
            Text(dateTime.year.toString(),style: TextStyle(color: Colors.white,fontSize: Adapt.pt(20)),),

          ],
        ),

        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search_outlined,color: Colors.white,),padding: EdgeInsets.all(0),iconSize: 30,),
          IconButton(onPressed: (){}, icon: Icon(Icons.location_on_outlined,color: Colors.white,),padding: EdgeInsets.all(0),iconSize: 30,),
        ],

        backgroundColor: Color(0xFF7B9F4D),

      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(width: Adapt.pt(280),),
              Container(
                padding: EdgeInsets.only(left: Adapt.pt(12),right: Adapt.pt(12),top: Adapt.pt(3),bottom: Adapt.pt(3)),
                margin: EdgeInsets.all(Adapt.pt(5)),
                child: Text("今日",style: TextStyle(fontSize: Adapt.pt(13)),),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black)
                ),
              ),

              Container(
                padding: EdgeInsets.only(left: Adapt.pt(12),right: Adapt.pt(12),top: Adapt.pt(3),bottom: Adapt.pt(3)),
                margin: EdgeInsets.all(Adapt.pt(5)),
                child: Text("分享",style: TextStyle(fontSize: Adapt.pt(13)),),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black)
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("日",style: TextStyle(color: Colors.grey,fontSize: Adapt.pt(22)),),
              Text("一",style: TextStyle(color: Colors.grey,fontSize: Adapt.pt(22)),),
              Text("二",style: TextStyle(color: Colors.grey,fontSize: Adapt.pt(22)),),
              Text("三",style: TextStyle(color: Colors.grey,fontSize: Adapt.pt(22)),),
              Text("四",style: TextStyle(color: Colors.grey,fontSize: Adapt.pt(22)),),
              Text("五",style: TextStyle(color: Colors.grey,fontSize: Adapt.pt(22)),),
              Text("六",style: TextStyle(color: Colors.grey,fontSize: Adapt.pt(22)),),

            ],
          )





        ],

      ),

      bottomNavigationBar: ClipRRect(

        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), ),
        child: BottomAppBar(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              //日历图标
              IconButton(onPressed: (){},
                  icon: Icon(MyFlutterApp.calender,color: Color(0xFF445B28),size: Adapt.pt(35),)),
              //日记
              IconButton(onPressed: (){},
                  icon: Icon(MyFlutterApp.book,color: Color(0xFF445B28),size: Adapt.pt(30),)),
              //添加
              FloatingActionButton(onPressed: (){},elevation: 0,backgroundColor: Color(0xFF7B9F4D),shape: CircleBorder(),child: Icon(Icons.add,size: Adapt.pt(53),color: Colors.white,),),
              //日记串
              IconButton(onPressed: (){},
                  icon: Icon(MyFlutterApp.circle,color: Color(0xFF445B28),size: Adapt.pt(30),)),
              //用户
              IconButton(onPressed: (){},
                  icon: Icon(MyFlutterApp.head,color: Color(0xFF445B28),size: Adapt.pt(30),)),
            ],
          ),
          color: Color(0xFFDCEEC4),
        ),
      ),

      
    );
  }
}
