import 'package:diary/backgroundpage.dart';
import 'package:diary/persondio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'sizecontrol.dart';
import 'package:image_picker/image_picker.dart';

class changepage extends StatefulWidget {
  const changepage({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<changepage> createState() => _changepageState(token: token);
}

class _changepageState extends State<changepage> {
  String token;


  _changepageState({required this.token});

  XFile? imagepath;
  XFile? imagepath2;
  String? value;

  final ImagePicker picker = new ImagePicker();

  Future<void>pickimage()async{
    // 选择图片
    final openalbum =  await picker.pickImage(source: ImageSource.gallery);

    if(openalbum!=null){
      imagepath=openalbum;
    }

  }

  Future<void>takeimage()async{
  //拍照
  final takephoto = await picker.pickImage(source: ImageSource.camera);
  if(takephoto!=null){
  imagepath2=takephoto;
  }
}

  Future<void> ChangeBImage(String token,XFile image) async {
    var attfile ;
    Future<FormData> FormData1() async {

      attfile = await MultipartFile.fromFile(image.path,filename: image.name);

      return FormData.fromMap({
        'file': attfile,
      });

    }
    FormData fromdata = await FormData1() ;
    Dio dio = Dio();
    String url = "https://mambaout.xyz/uploadUserBackgroundImage";
    dio.options.baseUrl = url;
    dio.options.headers['token'] = token;
    Response response = await dio.post(url,data: fromdata);

    print(response);

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

                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>backgroundpage(token: token,)),);
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
              onTap: ()async{
                await pickimage();
                await ChangeBImage(token, imagepath!);
                Navigator.of(context).pop();
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
              onTap: ()async{
                await takeimage();
                await ChangeBImage(token, imagepath2!);
                Navigator.of(context).pop();
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
