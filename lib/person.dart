import 'package:diary/diarychuan.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'sizecontrol.dart';

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.5, 1.0],
            tileMode: TileMode.decal,
            colors: [
              Colors.white,
              Color(0xffEFFCDE),
            ],
          ),
        ),
        child: Column(
          children: [
            PersonNews(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MessageBox(),
                MessageBox(),
                MessageBox(),
              ],
            ),
            Spacer(),
            Container(
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    _UserBreakDialog(context);
                  },
                  child: Text(
                    '注销账号',
                    style: TextStyle(
                        color: Color(0xff445B28), fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffDCEEC4))),
                ))
          ],
        ),
      ),
    );
  }
}

class PersonNews extends StatefulWidget {
  const PersonNews({super.key});

  @override
  State<PersonNews> createState() => _PersonNewsState();
}

class _PersonNewsState extends State<PersonNews> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfilePhoto(),
            Container(
                height: Adapt.pt(100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: Adapt.pt(40)),
                      child: Text(
                        'Username',
                        style: TextStyle(
                            fontSize: Adapt.pt(25),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      'ID',
                      style: TextStyle(color: Color(0xff888888)),
                    ),
                  ],
                )),
          ],
        ),
        Container(
          margin: EdgeInsets.only(right: Adapt.pt(20)),
          height: Adapt.pt(30),
          child: TextButton(
            onPressed: () {
              _modelBottomSheet(context);
            },
            child: Text(
              '编辑资料',
              style: TextStyle(color: Color(0xff888888), fontSize: 12),
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 255, 255, 255)),
              side: MaterialStateProperty.all(
                BorderSide(color: Color(0xff888888), width: 2),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({super.key});

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
      width: Adapt.pt(100),
      height: Adapt.pt(100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(360),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(image1),
        ),
      ),
    );
  }
}

class MessageBox extends StatefulWidget {
  const MessageBox({super.key});

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.pt(90),
      width: Adapt.pt(95),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(
            flex: 4,
          ),
          Text(
            '2',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: Color(0xff445B28),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: Adapt.pt(5)),
            child: Text(
              'xx数量',
              style: TextStyle(
                color: Color(0xff445B28),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(0xffDCEEC4)),
    );
  }
}

_modelBottomSheet(BuildContext context) async {
  var result = await showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 140,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                '更换头像',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangeImage()));
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                '修改昵称',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                _ChangeNameDialog(context);
              },
            ),
          ],
        ),
      );
    },
  );
}

class ChangeImage extends StatelessWidget {
  ChangeImage({super.key});

  String? imagepath;
  String? imagepath2;
  String? value;

  final ImagePicker picker = new ImagePicker();

  Future<void> pickimage() async {
    // 选择图片
    final openalbum = await picker.pickImage(source: ImageSource.gallery);

    if (openalbum != null) {
      imagepath = openalbum.path;
    }
  }

  Future<void> takeimage() async {
    //拍照
    final takephoto = await picker.pickImage(source: ImageSource.camera);
    if (takephoto != null) {
      imagepath2 = takephoto.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Text(
            '更换头像',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 255, 255)),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF7B9F4D),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.5, 1.0],
              tileMode: TileMode.decal,
              colors: [
                Colors.white,
                Color(0xffEFFCDE),
              ],
            ),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReadyImage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 8, 5),
                      child: Text(
                        '系统图片',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(15, 5, 8, 8),
                        height: Adapt.pt(30),
                        width: Adapt.pt(30),
                        child: Image.asset('lib/assets/images/wayward.png'))
                  ],
                ),
              ),
              Divider(
                color: Color(0xffECECEC),
              ),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 8, 5),
                      child: Text(
                        '从手机相册选择',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(15, 5, 8, 8),
                        height: Adapt.pt(30),
                        width: Adapt.pt(30),
                        child: Image.asset('lib/assets/images/wayward.png'))
                  ],
                ),
                onTap: () async {
                  await pickimage();
                },
              ),
              Divider(
                color: Color(0xffECECEC),
              ),
              InkWell(
                onTap: () async {
                  await takeimage();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 8, 5),
                      child: Text(
                        '拍一张',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(15, 5, 8, 8),
                        height: Adapt.pt(30),
                        width: Adapt.pt(30),
                        child: Image.asset('lib/assets/images/wayward.png'))
                  ],
                ),
              ),
              Divider(
                color: Color(0xffECECEC),
              ),
            ],
          ),
        ));
  }
}

class ReadyImage extends StatefulWidget {
  const ReadyImage({super.key});

  @override
  State<ReadyImage> createState() => _ReadyImageState();
}

class _ReadyImageState extends State<ReadyImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          '更换头像',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF7B9F4D),
      ),
      body: Wrap(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/images/rabbit2.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(15)),
            width: Adapt.pt(110),
            height: Adapt.pt(110),
          ),
          Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/images/rabbit2.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(15)),
            width: Adapt.pt(110),
            height: Adapt.pt(110),
          ),
          Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/images/rabbit2.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(15)),
            width: Adapt.pt(110),
            height: Adapt.pt(110),
          ),
        ],
      ),
    );
  }
}

_ChangeNameDialog(BuildContext context) async {
  var result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Center(child: Text('修改昵称')),
            content: Container( 
              decoration: BoxDecoration(

              color:const Color(0xFFEAEAEA),
                borderRadius: BorderRadius.circular(30),),
              alignment: Alignment.center,
              height: 30,
              child: TextField(
                  //   controller: _controllerId,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Color(0xff888888)),
                      hintText: "请输入3-8个数字、字母或汉字",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: Adapt.pt(7), horizontal: Adapt.pt(10)),
                      border: InputBorder.none)),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(150, 20)),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff7B9F4D))),
                      child: Text(
                        '确认修改',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ]);
      });
}

_UserBreakDialog(BuildContext context) async {
  var result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            margin: EdgeInsets.only(top: 30),
            height: 70,
            child: Text(
              '确认注销该账号？',
              style: TextStyle(fontSize: 18),
            ),
            alignment: Alignment.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spacer(),
                TextButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(90, 20)),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff7B9F4D))),
                    child: Text(
                      '取消',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255)),
                    ),
                    onPressed: () {
                      Navigator.pop(context, "取消");
                    }),
                Spacer(
                  flex: 2,
                ),
                TextButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(90, 20)),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff7B9F4D))),
                  child: Text(
                    '确定',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255)),
                  ),
                  onPressed: () {
                    Navigator.pop(context, "确定");
                  },
                ),
                Spacer(),
              ],
            ),
          ],
        );
      });
}
