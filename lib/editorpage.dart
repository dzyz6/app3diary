import 'dart:io';
import 'package:diary/dioclass.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'sizecontrol.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'user.dart';

var textcontroller;

/// 位置服务
Future _determinePosition() async {
  Position position;
  bool serviceEnabled;
  LocationPermission permission;
  double longitude = 0;
  double latitude = 0;
  try {
    /// 手机GPS服务是否已启用。
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //定位服务未启用，要求用户启用定位服务
      var res = await Geolocator.openLocationSettings();
      if (!res) {
        /// 被拒绝
        return;
      }
    }

    /// 是否允许app访问地理位置
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      /// 之前访问设备位置的权限被拒绝，重新申请权限
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        /// 再次被拒绝。根据Android指南，你的应用现在应该显示一个解释性UI。
        return;
      }
    } else if (permission == LocationPermission.deniedForever) {
      /// 之前权限被永久拒绝，打开app权限设置页面
      await Geolocator.openAppSettings();
      return;
    }

    /// 允许访问地理位置，获取地理位置
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    longitude = position.longitude;
    latitude = position.latitude;
  } catch (e) {
    print(e);
  }
}

XFile? imagepath;
ImagePicker picker = ImagePicker();

String formatTime(String time) {
  return time.padLeft(2, '0');
}



class editorpage extends StatefulWidget {
  const editorpage({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  State<editorpage> createState() => _editorpageState(token: token);
}

List a = ["一", "二", "三", "四", "五", "六", "天"];

class _editorpageState extends State<editorpage> {


  List<XFile> imagePaths = [];

  int currentImageIndex = 0;

  void deleteimage(int index){
    setState(() {
      currentImageIndex=index;
      imagePaths.removeAt(currentImageIndex);

    });

  }


  DateTime datetime = DateTime.now();
  var editor = Editor();

  String token;




  Future<void> pickimage() async {
    // 选择图片
    final openalbum = await picker.pickImage(source: ImageSource.gallery);

    if (openalbum != null) {
      setState(() {
        imagepath = openalbum;
        imagePaths.add(imagepath!);
      });
    }
  }

  _editorpageState({required this.token});

  @override
  void initState() {
    super.initState();
    textcontroller = TextEditingController();
    textcontroller.addListener(() {});
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: Adapt.pt(95),
            ),
            Text(
              "新建日记",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Color(0xFF7B9F4D),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
            });
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color(0xFFEFFCDE)])),
        child: SingleChildScrollView(
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
                        style: TextStyle(
                            fontSize: Adapt.pt(20), color: Colors.black),
                      ),
                      TextSpan(
                        text: "月",
                        style: TextStyle(
                            fontSize: Adapt.pt(20), color: Colors.black),
                      ),
                      TextSpan(
                        text: datetime.day.toString(),
                        style: TextStyle(
                            fontSize: Adapt.pt(20), color: Colors.black),
                      ),
                      TextSpan(
                        text: "日",
                        style: TextStyle(
                            fontSize: Adapt.pt(20), color: Colors.black),
                      ),
                      TextSpan(
                        text: "  ", // SizedBox的宽度转换为空格
                        style: TextStyle(
                            fontSize: Adapt.pt(20), color: Colors.black),
                      ),
                      TextSpan(
                        text: "星期",
                        style: TextStyle(
                            fontSize: Adapt.pt(20), color: Colors.black),
                      ),
                      TextSpan(
                        text: a[datetime.weekday - 1],
                        style: TextStyle(
                            fontSize: Adapt.pt(20), color: Colors.black),
                      ),
                      TextSpan(
                        text: "  ", // SizedBox的宽度转换为空格
                        style: TextStyle(
                            fontSize: Adapt.pt(20), color: Colors.black),
                      ),
                      TextSpan(
                        text: datetime.hour.toString(),
                        style: TextStyle(
                            fontSize: Adapt.pt(20), color: Colors.black),
                      ),
                      TextSpan(
                        text: ":",
                        style: TextStyle(
                            fontSize: Adapt.pt(20), color: Colors.black),
                      ),
                      TextSpan(
                        text: "  ", // SizedBox的宽度转换为空格
                        style: TextStyle(
                            fontSize: Adapt.pt(20), color: Colors.black),
                      ),
                      TextSpan(
                        text: formatTime(datetime.minute.toString()),
                        style: TextStyle(
                            fontSize: Adapt.pt(20), color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Adapt.pt(10),
              ),
              Text(
                "注意：对以前的日记进行编辑时，时间显示第一次创建该日记的时刻",
                style:
                    TextStyle(fontSize: Adapt.pt(12), color: Color(0xFF888888)),
              ),
              SizedBox(
                height: Adapt.pt(12),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: Color(0xFF7B9F4D),
                  cursorWidth: 2,
                  maxLength: 1000,
                  controller: textcontroller,
                  maxLines: 20,
                  minLines: 3,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(Adapt.pt(20)),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xFF7B9F4D),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF7B9F4D), width: Adapt.pt(1.5)))),
                ),
              ),
              Container(
                  height: 300,
                  child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: Adapt.pt(10),
                    crossAxisSpacing: Adapt.pt(5),
                      children: List.generate(
                        imagePaths.length,
                        (index) {
                          if (imagePaths[index] != null) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  child: Image.file(File(imagePaths[index].path),fit: BoxFit.cover,),
                                  padding: EdgeInsets.all(Adapt.pt(5)),
                                ),
                                Positioned(
                                  child: SizedBox(
                                    child: IconButton(
                                        onPressed: () {
                                          deleteimage(index);
                                        },
                                        icon: Icon(
                                          Icons.backspace_outlined,
                                          color: Colors.black,
                                          size: Adapt.pt(15),
                                        ),
                                    padding: EdgeInsets.all(0),),
                                    height: Adapt.pt(25),
                                    width: Adapt.pt(25),
                                  ),
                                  top: Adapt.pt(0),
                                  right: Adapt.pt(0),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      )))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: Adapt.pt(60),
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          children: [
            IconButton(
                onPressed: () async {
                  await _determinePosition();
                },
                icon: Icon(Icons.location_on_outlined)),
            IconButton(
                onPressed: () {
                  pickimage();
                },
                icon: Icon(Icons.image)),
            IconButton(onPressed: () {}, icon: Icon(Icons.mic_none_rounded)),
            Expanded(child: Container(),),
            IconButton(
                onPressed: () async{
                  if (textcontroller.text.toString() != null &&
                      textcontroller.text.toString() != "") {
                    FocusScope.of(context).unfocus();
                    await editor.tokenTest(token,imagePaths);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pop(context);
                    });
                  } else {
                    showGeneralDialog(
                        context: context,
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return AlertDialog(
                            content: Container(
                                height: Adapt.pt(40),
                                child: Center(
                                    child: Text(
                                  "请填写内容૮꒰ ˶• ༝ •˶꒱ა",
                                  style: TextStyle(fontSize: Adapt.pt(20)),
                                ))),
                            actions: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    child: Text(
                                      "好的捏",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF7B9F4D),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Adapt.pt(20)))),
                                    padding: EdgeInsets.all(Adapt.pt(10)),
                                  ))
                            ],
                          );
                        });
                  }
                },
                icon: Icon(Icons.check)),
          ],
        ),
      ),
    );
  }
}

class Editor {
  Editor();
  Future<void> tokenTest(String token,List<XFile> files) async {
    // 创建 Dio 实例
    Dio dio = Dio();
    // 设置请求的 URL（注意：您不需要在这里设置 baseUrl，因为我们会直接在 post 方法中传入完整的 URL）
    String url = "https://mambaout.xyz/createJournal";


    // 创建 FormData 对象
      FormData formData = FormData.fromMap({
        'location': '1',
        'journalTitle': '',
        'journalText': textcontroller.text,
        'topJournal': '0',
      });

    for (int i = 0; i < files.length; i++) {
        MultipartFile multipartFile = await MultipartFile.fromFile(files[i].path, filename: files[i].name);
        formData.files.add(MapEntry('files', multipartFile));
    }
    // 设置请求头
    Options options = Options(
        headers: {
          'token': token, // 设置认证 token
        }
    );

    // 发送 POST 请求
    try {
      Response response = await dio.post(url, data: formData, options: options);
      print(response); // 打印服务器返回的数据
      print(formData.files);
      print('请求成功');
    } catch (e) {
      // 错误处理
      print('请求失败: $e');
    }
  }
  
  Future<void> ofDiarys(String token,String journalGroupCount) async {
    // 创建 Dio 实例
    Dio dio = Dio();


    // 设置请求的 URL（注意：您不需要在这里设置 baseUrl，因为我们会直接在 post 方法中传入完整的 URL）
    String url = "https://mambaout.xyz/createJournalAtJournalGroup";

    // 创建 FormData 对象
      FormData formData = FormData.fromMap({
        'location': '1', // 假设 location 是一个字符串
        'journalTitle': '', // 如果 journalTitle 是可选的并且没有值，可以留空
        'journalText': textcontroller.text, // 使用 TextEditingController 的 text 属性
        'topJournal': '0',
        'journalGroupIdAt':journalGroupCount,  // 假设 topJournal 是一个字符串格式的整数
      });




    // 设置请求头
    Options options = Options(
        headers: {
          'token': token, // 设置认证 token
        }
    );

    // 发送 POST 请求
    try {
      Response response = await dio.post(url, data: formData, options: options);
      print(response.data); // 打印服务器返回的数据
      print('请求成功');
    } catch (e) {
      // 错误处理
      print('请求失败: $e');
    }
  }
}





