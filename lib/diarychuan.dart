import 'dart:ui';
import 'package:diary/diarychuandio.dart';
import 'package:diary/diarychuandio2.dart';
import 'package:diary/ofeditorpage.dart';
import 'package:diary/pageanimate.dart';
import 'package:diary/register.dart/data.dart';
import 'package:diary/searchpage.dart';
import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './sizecontrol.dart';

var image1 = 'lib/assets/images/rabbit1.jpg';
var image2 = 'lib/assets/images/rabbit2.jpg';
List images = [
  'lib/assets/images/rabbit1.jpg',
  'lib/assets/images/rabbit2.jpg',
  'lib/assets/images/rabbit3.jpg',
  'lib/assets/images/rabbit5.jpg',
  'lib/assets/images/rabbit6.jpg',
  'lib/assets/images/rabbit7.jpg',
  'lib/assets/images/rabbit8.jpg',
  'lib/assets/images/rabbit9.jpg',
];
var image3 = 'lib/assets/images/add1.jpg';
var getDiaryList = GetDiaryList();
var getDiaryofDiarys = GetDiaryofDiarys();
var token;

class Diarychuan extends StatefulWidget {
  late String token;
  Diarychuan({Key? key, this.token = 'nulls'}) : super(key: key);
  @override
  State<Diarychuan> createState() => _DiarychuanState();
}

class _DiarychuanState extends State<Diarychuan> {
  @override
  var page = 1;
  void futureini() async {
    await getDiaryList.getofDiarys(widget.token, page).then((value) 
    {
      setState(() {
        imageCardCreate(getDiaryList);
      });
    });
  }

  @override
  void fatherSetState() {
    setState(() {
      futureini();
    });
  }

  void imageCardCreate(GetDiaryList getDiaryList) {
    int? a = getDiaryList.diaryslist.data!.total;
    var p = true;

    litems.clear();
    for (var i = 0; i < a!; i++) {
      if (a - i > 1) {
        litems.add(ImageListCard(imageCardList: [
          ImageBox(
              id: getDiaryList.diaryslist.data?.records![i++].journalGroupId),
          ImageBox(id: getDiaryList.diaryslist.data?.records![i].journalGroupId)
        ]));
      } else {
        p = false;
        litems.add(ImageListCard(imageCardList: [
          ImageBox(
              id: getDiaryList.diaryslist.data?.records![i].journalGroupId),
          NewImageBox(
            fatherSetState: fatherSetState,
          ),
        ]));
      }
    }
    if (p == true) {
      litems.add(ImageListCard(imageCardList: [
        NewImageBox(
          fatherSetState: fatherSetState,
        ),
        Container(
          height: Adapt.pt(200),
          width: Adapt.pt(200),
        ),
      ]));
    }
  }

  void initState() {
    token = widget.token;
    futureini();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => searchpage(
                            token: token,
                          )));
            },
            icon: Icon(
              Icons.search_outlined,
              color: Colors.white,
            ),
            padding: EdgeInsets.all(0),
            iconSize: 30,
          ),
        ],
        backgroundColor: Color(0xFF7B9F4D),
      ),
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
          child: EasyRefresh(
            child: DiaryList(),
            onRefresh: () {
              futureini();
              setState(() {});
            },
          )),
    );
  }
}

List<Widget> litems = [];
List<Widget> chuanlitems = [];

class DiaryList extends StatefulWidget {
  const DiaryList({super.key});

  @override
  State<DiaryList> createState() => _DiaryListState();
}

class _DiaryListState extends State<DiaryList> {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: litems.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return litems[index];
        });
  }
}

class ImageListCard extends StatefulWidget {
  late List<Widget> imageCardList;
  ImageListCard({
    required this.imageCardList,
    super.key,
  });

  @override
  State<ImageListCard> createState() => _ImageListCardState();
}

class _ImageListCardState extends State<ImageListCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      children: widget.imageCardList,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    ));
  }
}

class NewImageBox extends StatefulWidget {
  late var fatherSetState;
  NewImageBox({super.key, required this.fatherSetState});

  @override
  State<NewImageBox> createState() => _NewImageBoxState();
}

class _NewImageBoxState extends State<NewImageBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await createJournalGroup(token);
        widget.fatherSetState();
      },
      child: Container(
        height: Adapt.pt(200),
        width: Adapt.pt(200),
        child: Stack(
            alignment: Alignment.topRight,
            fit: StackFit.loose,
            children: [
              Align(
                alignment: Alignment(0, 0),
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 139, 139, 139)
                          .withOpacity(0.5), // 阴影的颜色
                      offset: Offset(-7, 7),
                      blurRadius: 3,
                      spreadRadius: 0.0,
                    ),
                  ], borderRadius: BorderRadius.circular((30.0))),
                  height: Adapt.pt(160),
                  width: Adapt.pt(160),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      image3,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.3, -0.3),
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 139, 139, 139)
                          .withOpacity(0.5), // 阴影的颜色
                      offset: Offset(
                        Adapt.pt(5),
                        Adapt.pt(5),
                      ),
                      blurRadius: 3,
                      spreadRadius: 0.0,
                    ),
                  ], borderRadius: BorderRadius.circular((20.0))),
                  height: Adapt.pt(160),
                  width: Adapt.pt(160),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      image3,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

class ImageBox extends StatefulWidget {
  int? id;
  ImageBox({super.key, required this.id});

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          print(widget.id);
          await getDiaryofDiarys.getofDiarys(token, widget.id!);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Diarychuan2(
                        diaryListId: widget.id,
                      )));
        },
        child: Container(
          height: Adapt.pt(200),
          width: Adapt.pt(200),
          child: Stack(
              alignment: Alignment.topRight,
              fit: StackFit.loose,
              children: [
                Align(
                  alignment: Alignment(0, 0),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 139, 139, 139)
                            .withOpacity(0.5), // 阴影的颜色
                        offset: Offset(-7, 7),
                        blurRadius: 3,
                        spreadRadius: 0.0,
                      ),
                    ], borderRadius: BorderRadius.circular((30.0))),
                    height: Adapt.pt(160),
                    width: Adapt.pt(160),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        image2,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0.3, -0.3),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 139, 139, 139)
                            .withOpacity(0.5), // 阴影的颜色
                        offset: Offset(
                          Adapt.pt(5),
                          Adapt.pt(5),
                        ),
                        blurRadius: 3,
                        spreadRadius: 0.0,
                      ),
                    ], borderRadius: BorderRadius.circular((20.0))),
                    height: Adapt.pt(160),
                    width: Adapt.pt(160),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        images[widget.id! % 7],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ]),
        ));
  }
}

List<Widget> ofdiarys = [];

class DiaryLine extends StatefulWidget {
  int diaryID = 0;
  String text = '这只是个占位的，请耐心等待加载';
  int index;
  DiaryLine(
      {super.key,
      required this.index /*required this.diaryID,required this.text*/});
  
  @override
  State<DiaryLine> createState() => _DiaryLineState();
}

class _DiaryLineState extends State<DiaryLine> {
  late ImagesofDIary imagelist;
  Future<void> getImage() async {
    int a = getDiaryofDiarys.diarys.data![widget.index].journalId!;
    Dio dio = Dio();
    String url = "http://mambaout.xyz/getJournalPictures";
    dio.options.baseUrl = url;
    dio.options.headers['token'] = token;
    Map<String, dynamic> map = Map();
    map['journalId'] = a;
    Response response = await dio.get(url, queryParameters: map);
    imagelist = ImagesofDIary.fromJson(response.data);   
    print(response.data); 
    setState(() {
    if (imagelist.data?.length == 0) {
        _diarys.removeAt(0);
      } else {
        _diarys.removeAt(0);
        for (var i = 0; i < imagelist.data!.length; i++) {
          _diarys.add(Container(
      margin: EdgeInsets.only(top: 5),
      child: Image.network(imagelist.data![i].pictureUrl!),
      width: 200,
      height: 200,
    ),);
        }
      }
    });
  }

  List<Widget> _diarys = [
    Container(
      margin: EdgeInsets.only(top: 5),
      child: Image.asset(image2),
      width: 200,
      height: 200,
    ),
  ];
  var y2k;
  @override
  void initState() {
    var y = getDiaryofDiarys.diarys.data?[widget.index].modifiedAt;
    List<String> strList = y!.split(" ");
    var year = strList[0].substring(0, 4);
    var month = strList[0].substring(5, 7);
    var days = strList[0].substring(8, 10);
    this.y2k = DateTime(int.parse(year), int.parse(month), int.parse(days));

    getImage();


    super.initState();
  }

  Widget build(BuildContext context) {
    setState(() {
      
    });
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TimeData(
            time: y2k,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.centerLeft,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getDiaryofDiarys.diarys.data![widget.index].journalText!,
                      style: TextStyle(fontSize: 17),
                    ),
                    Column(
                      children: _diarys
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

class DiaryCondition extends StatefulWidget {
  const DiaryCondition({super.key});

  @override
  State<DiaryCondition> createState() => _DiaryConditionState();
}

class _DiaryConditionState extends State<DiaryCondition> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Time',
              style: TextStyle(color: Color(0xff888888), fontSize: 10),
            ),
            Container(
                height: 20,
                width: 20,
                child: Image.asset('lib/assets/images/download.png')),
            Text(
              'your download',
              style: TextStyle(color: Color(0xff217FD6), fontSize: 10),
            )
          ],
        )),
      ],
    );
  }
}

class ChuanLine extends StatefulWidget {
  //var _x;
  //var _y;
  int itemCount = 0;
  ChuanLine({
    super.key,
  });

  @override
  State<ChuanLine> createState() => _ChuanLineState();
}

class _ChuanLineState extends State<ChuanLine> {
  late int count;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: getDiaryofDiarys.diarys.data?.length,
      itemBuilder: (BuildContext context, int index) {
        return CustomPaint(
          child: DiaryLine(
            index: index,
          ),
          foregroundPainter: CirclePainter(1000),
        );
      },
    );
  }
}

class CirclePainter extends CustomPainter {
  double ssize;
  CirclePainter(this.ssize);
  Rect stretch(Rect f, double df) {
    Rect pRect = Rect.fromLTRB(f.left, f.top + df, f.right, f.bottom + df);
    return pRect;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect pRect1 = Rect.fromLTRB(85, 25, 110, 50);
    Rect pRect2 = Rect.fromLTRB(88, 28, 107, 47);
    Paint paint1 = Paint()..color = const Color(0xFF445B28);

    Paint paint2 = Paint()..color = Color.fromARGB(255, 255, 255, 255);
    Paint paint3 = Paint()
      ..color = Color(0xff7B9F4D)
      ..strokeWidth = 2;
    canvas.drawOval(pRect1, paint1);
    canvas.drawOval(pRect2, paint2);
    canvas.drawLine(Offset(pRect1.center.dx, pRect1.bottom),
        Offset(pRect1.center.dx, pRect1.bottom + ssize), paint3);
    pRect1 = stretch(pRect1, ssize);
    pRect2 = stretch(pRect2, ssize);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class TimeData extends StatelessWidget {
  late DateTime time;
  List<String> week = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日'];
  TimeData({super.key, required this.time});
  var moon;
  var day;
  var weekday;
  @override

  Widget build(BuildContext context) {
    this.moon = time.month.toString() + '月';
    this.day = time.day.toString();
    this.weekday = week[time.weekday];
    return Container(
      margin: EdgeInsets.only(
          left: Adapt.pt(20), right: Adapt.pt(50), top: Adapt.pt(20)),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                day,
                style: TextStyle(fontSize: 25),
              ),
              Text(
                moon,
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          Text(weekday)
        ],
      ),
    );
  }
}

class Diarychuan2 extends StatefulWidget {
  late int? diaryListId;
  Diarychuan2({required this.diaryListId, super.key});

  @override
  State<Diarychuan2> createState() => _Diarychuan2State();
}

class _Diarychuan2State extends State<Diarychuan2> {
  @override
  void initState() {
    super.initState();
  }

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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_outlined,
              color: Colors.white,
            ),
            padding: EdgeInsets.all(0),
            iconSize: 30,
          ),
        ],
        backgroundColor: Color(0xFF7B9F4D),
      ),
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
            Expanded(
              child: ChuanLine(),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      SlideRoute(
                          page: Ofeditorpage(
                              token: token,
                              diaryid: widget.diaryListId.toString())));
                },
                child: Text('新建日记到当前日记串'))
          ],
        ),
      ),
    );
  }
}





















class ImagesofDIary {
    int? code;
    String? message;
    List<Data>? data;

    ImagesofDIary({this.code, this.message, this.data});

    ImagesofDIary.fromJson(Map<String, dynamic> json) {
        code = json["code"];
        message = json["message"];
        data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["code"] = code;
        _data["message"] = message;
        if(data != null) {
            _data["data"] = data?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Data {
    String? pictureId;
    String? pictureUrl;

    Data({this.pictureId, this.pictureUrl});

    Data.fromJson(Map<String, dynamic> json) {
        pictureId = json["pictureId"];
        pictureUrl = json["pictureUrl"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["pictureId"] = pictureId;
        _data["pictureUrl"] = pictureUrl;
        return _data;
    }
}