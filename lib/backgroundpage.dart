import 'package:diary/persondio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'diarypage.dart';
import 'sizecontrol.dart';
import 'package:image_picker/image_picker.dart';

class backgroundpage extends StatefulWidget {
  const backgroundpage({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<backgroundpage> createState() => _backgroundpageState(token:token);
}

class _backgroundpageState extends State<backgroundpage> {

  String token;


  _backgroundpageState({required this.token});



  Future<void> ChangeReadyImage(String token,int imagenum) async {
    Dio dio = Dio();
    String url = "http://mambaout.xyz/setDefaultPictureByNum";
    dio.options.baseUrl = url;
    dio.options.headers['token'] = token;
    Map<String,dynamic> map = Map();
    map["background"] = imagenum;
    map["userProfilePicture"] = 0;
    Response response = await dio.put(url,data: map);
    print(response);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: Adapt.pt(90),),
            Text("选择背景图",style: TextStyle(fontSize: Adapt.pt(25),color: Colors.white,fontWeight: FontWeight.bold),),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF7B9F4D),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.white,Color(0xFFEFFCDE)]
            )
        ),
        child: Container(
          margin: EdgeInsets.only(top: 20,left: 20,right: 20),
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 25,
            children: [
             GestureDetector(
               onTap: ()async{
                   await ChangeReadyImage(token, 1);
                   Navigator.of(context)..pop()..pop();
               },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.network('http://8.130.98.175/images/1.jpg'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: ()async{
                  await ChangeReadyImage(token, 2);
                  Navigator.of(context)..pop()..pop();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.network('http://8.130.98.175/images/2.jpg'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: ()async{
                  await ChangeReadyImage(token, 3);
                  Navigator.of(context)..pop()..pop();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.network('http://8.130.98.175/images/3.jpg'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: ()async{
                  await ChangeReadyImage(token, 4);
                  Navigator.of(context)..pop()..pop();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.network('http://8.130.98.175/images/4.jpg'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: ()async{
                  await ChangeReadyImage(token, 5);
                  Navigator.of(context)..pop()..pop();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.network('http://8.130.98.175/images/5.jpg'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: ()async{
                  await ChangeReadyImage(token, 6);
                  Navigator.of(context)..pop()..pop();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.network('http://8.130.98.175/images/6.jpg'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: ()async{
                  await ChangeReadyImage(token, 7);
                  Navigator.of(context)..pop()..pop();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.network('http://8.130.98.175/images/7.jpg'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: ()async{
                  await ChangeReadyImage(token, 18);
                  Navigator.of(context)..pop()..pop();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.network('http://8.130.98.175/images/8.jpg'),
                  ),
                ),
              ),


            ],
          ),
        ),

      ),
    );
  }
}
