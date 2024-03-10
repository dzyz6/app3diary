import 'package:diary/backgroundpage.dart';
import 'package:flutter/material.dart';
import 'sizecontrol.dart';
import 'package:image_picker/image_picker.dart';

class changepage extends StatefulWidget {
  const changepage({super.key});

  @override
  State<changepage> createState() => _changepageState();
}

class _changepageState extends State<changepage> {

  String? imagepath;
  String? imagepath2;
  String? value;

  final ImagePicker picker = new ImagePicker();

  Future<void>pickimage()async{
    // 选择图片
    final openalbum =  await picker.pickImage(source: ImageSource.gallery);

    if(openalbum!=null){
      imagepath=openalbum.path;
    }

  }

  Future<void>takeimage()async{
  //拍照
  final takephoto = await picker.pickImage(source: ImageSource.camera);
  if(takephoto!=null){
  imagepath2=takephoto.path;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: Adapt.pt(90),),
            Text("更换背景",style: TextStyle(fontSize: Adapt.pt(25),color: Colors.white,fontWeight: FontWeight.bold),),
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
        child: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>backgroundpage()),);
                ;
                },
              child: Container(
                  width: double.infinity,
                child: Row(
                  children: [
                    Text("选择背景图",style: TextStyle(fontSize: Adapt.pt(20))),
                    SizedBox(width: Adapt.pt(250),),
                    Icon(Icons.arrow_forward_ios_outlined,size: Adapt.pt(20),)
                  ],
                ),
                padding: EdgeInsets.only(top: 20,left: 25,bottom: 20,)
              ),
            ),
            Divider(
              height: 0,
              color: Color(0xFFD7D7D7),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                pickimage();

              },
              child: Container(
                  child: Row(
                    children: [
                      Text("从手机相册选择",style: TextStyle(fontSize: Adapt.pt(20))),
                      SizedBox(width: Adapt.pt(210),),
                      Icon(Icons.arrow_forward_ios_outlined,size: Adapt.pt(20),)
                    ],
                  ),
                  padding: EdgeInsets.only(top: 20,left: 25,bottom: 20,)
              ),
            ),
            Divider(
              height: 0,
              color: Color(0xFFD7D7D7),
            ),
            GestureDetector(
              onTap: (){
                takeimage();
                value=imagepath2;
                Navigator.of(context).pop(value);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                  child: Row(
                    children: [
                      Text("拍一张",style: TextStyle(fontSize: Adapt.pt(20))),
                      SizedBox(width: Adapt.pt(290),),
                      Icon(Icons.arrow_forward_ios_outlined,size: Adapt.pt(20),)
                    ],
                  ),
                  padding: EdgeInsets.only(top: 20,left: 25,bottom: 20,)
              ),
            ),
            Divider(
              height: 0,
              color: Color(0xFFD7D7D7),
            ),
          ],
        ),
      ),
    );
  }
}
