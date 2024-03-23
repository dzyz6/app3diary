import 'package:diary/assets/icon/my_flutter_app_icons.dart';
import 'package:diary/changepage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dioclass.dart';
import 'sizecontrol.dart';
import 'package:diary/searchpage.dart';

class diarypage extends StatefulWidget {
  const diarypage({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<diarypage> createState() => _diarypageState(token: token);
}

List a = ["一", "二", "三", "四", "五", "六", "天"];

class _diarypageState extends State<diarypage> {
  String token;

  _diarypageState({required this.token});

  String _image = "lib/assets/images/rabbit8.jpg";

  String? inside = "";
  var _get = Get();
  Dio dio = Dio();
  int total = 0;

  bool _isListCreated = false;

  Future<void> createlist(String token) async {
    if (_isListCreated) {
      return; // 避免重复调用
    }
    _isListCreated = true;
    String url = "http://8.130.98.175/getJournalsByUid";
    dio.options.baseUrl = url;
    dio.options.headers['token'] = token;
    Map<String, dynamic> map = Map();
    map['page'] = 1;
    map['pageSize'] = 100;
    map['range'] = 0;
    map['date'] = null;
    Response response = await dio.get(url, queryParameters: map);
    _get = Get.fromJson(response.data);
    setState(() {
      total = _get.data!.total;
    });
    print('aaaaaaaaaaaaaaaaaaaaaaaaa');
    print(total);
  }

  @override
  void initState() {
    super.initState();
    createlist(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            //类微信头部
            automaticallyImplyLeading: false,
            // backgroundColor: Color(0xFF7B9F4D),
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: Adapt.pt(230),
            actions: [
              Row(
                children: [
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
                      size: Adapt.pt(35),
                    ),
                  ),
                ],
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Stack(
                children: [
                  Container(
                    child: Image.asset(
                      _image,
                      fit: BoxFit.cover,
                    ),
                    height: Adapt.pt(260),
                    width: Adapt.pt(430),
                  ),
                  Positioned(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        child: Image.asset("lib/assets/images/rabbit8.jpg"),
                        height: Adapt.pt(70),
                        width: Adapt.pt(70),
                      ),
                    ),
                    top: Adapt.pt(220),
                    right: Adapt.pt(25),
                  ),
                  Positioned(
                      top: Adapt.pt(240),
                      left: Adapt.pt(5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => changepage()))
                              .then((value) {
                            setState(() {
                              _image = value;
                            });
                          });
                          ;

                          ;
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.terrain,
                                size: 15,
                              ),
                              Text(
                                "更换背景",
                                style: TextStyle(fontSize: Adapt.pt(10)),
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            total = _get.data!.total;
            return FutureBuilder(
                future: createlist(token),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else {
                    inside = _get.data!.records[index].journalText;

                    var time = _get.data!.records[index].createdAt;
                    var creattime = time.substring(12, 14);
                    var creattime2 = time.substring(15, 17);
                    var creattimeday = time.substring(8, 10);
                    var creattimemonth = time.substring(6, 7);
                    var creattimeyear = time.substring(0, 4);
                    return Column(
                      children: [
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Adapt.pt(20),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: Adapt.pt(15),
                                    ),
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: "$creattimeday",
                                            style: TextStyle(
                                                fontSize: Adapt.pt(25),
                                                color: Colors.black)),
                                        TextSpan(
                                            text: "$creattimemonth",
                                            style: TextStyle(
                                                fontSize: Adapt.pt(15),
                                                color: Colors.black)),
                                        TextSpan(
                                            text: "月",
                                            style: TextStyle(
                                                fontSize: Adapt.pt(13),
                                                color: Colors.black)),
                                      ]),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: Adapt.pt(5),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: Adapt.pt(15)),
                                        child: RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: "星期",
                                              style: TextStyle(
                                                  fontSize: Adapt.pt(12),
                                                  color: Colors.black)),
                                          TextSpan(
                                            text: a[DateTime(
                                                        int.parse(
                                                            creattimeyear),
                                                        int.parse(
                                                            creattimemonth),
                                                        int.parse(creattimeday))
                                                    .weekday -
                                                1],
                                            style: TextStyle(
                                                fontSize: Adapt.pt(12),
                                                color: Colors.black),
                                          ),
                                        ])),
                                      ),
                                    ],
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              SizedBox(
                                width: Adapt.pt(20),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: Adapt.pt(22),
                                    ),
                                    Text(
                                      "$inside",
                                      style: TextStyle(
                                        fontSize: Adapt.pt(15),
                                        color: Colors.black,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(bottom: Adapt.pt(10)),
                                      child: Text(
                                        "$creattime" + ":" + "$creattime2",
                                        style: TextStyle(
                                            fontSize: Adapt.pt(8),
                                            color: Color(0xff6b6b6b)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          child: IconButton(
                                            padding: new EdgeInsets.all(0.0),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Container(
                                                    height: Adapt.pt(200),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            const Radius.circular(
                                                                20.0),
                                                        topRight:
                                                            const Radius.circular(
                                                                20.0),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        GestureDetector(
                                                          child: Container(
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: Adapt.pt(
                                                                      20),
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .format_list_bulleted,
                                                                  size: Adapt.pt(
                                                                      30),
                                                                  color: Color(
                                                                      0xffffaeae),
                                                                ),
                                                                SizedBox(
                                                                  width: Adapt.pt(
                                                                      20),
                                                                ),
                                                                Text(
                                                                  "展示当前日记串",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          Adapt.pt(
                                                                              18)),
                                                                ),
                                                              ],
                                                            ),
                                                            margin:
                                                                EdgeInsets.all(
                                                                    Adapt.pt(15)),
                                                          ),
                                                        ),
                                                        Divider(
                                                          color: Colors.grey,
                                                        ),
                                                        GestureDetector(
                                                          child: Container(
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: Adapt.pt(
                                                                      20),
                                                                ),
                                                                Icon(
                                                                  Icons.add,
                                                                  size: Adapt.pt(
                                                                      35),
                                                                  color: Color(
                                                                      0xffc3f4ff),
                                                                ),
                                                                SizedBox(
                                                                  width: Adapt.pt(
                                                                      20),
                                                                ),
                                                                Text(
                                                                  "新建日记到当前日记串",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          Adapt.pt(
                                                                              18)),
                                                                ),
                                                              ],
                                                            ),
                                                            margin:
                                                                EdgeInsets.all(
                                                                    Adapt.pt(8)),
                                                          ),
                                                        ),
                                                        Divider(
                                                          color: Colors.grey,
                                                        ),
                                                        GestureDetector(
                                                          child: Container(
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: Adapt.pt(
                                                                      20),
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .exit_to_app,
                                                                  size: Adapt.pt(
                                                                      30),
                                                                  color: Color(
                                                                      0xffffe4a8),
                                                                ),
                                                                SizedBox(
                                                                  width: Adapt.pt(
                                                                      20),
                                                                ),
                                                                Text(
                                                                  "从日记串移出",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          Adapt.pt(
                                                                              18)),
                                                                ),
                                                              ],
                                                            ),
                                                            margin:
                                                                EdgeInsets.all(
                                                                    Adapt.pt(10)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              MyFlutterApp.circle,
                                              size: Adapt.pt(18),
                                              color: Color(0xFF7B9F4D),
                                            ),
                                          ),
                                          height: Adapt.pt(25),
                                          width: Adapt.pt(25),
                                        ),
                                        SizedBox(
                                          width: Adapt.pt(10),
                                        ),
                                        SizedBox(
                                          child: IconButton(
                                            padding: new EdgeInsets.all(0.0),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Container(
                                                    height: Adapt.pt(200),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            const Radius.circular(
                                                                20.0),
                                                        topRight:
                                                            const Radius.circular(
                                                                20.0),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        GestureDetector(
                                                          child: Container(
                                                            child: Text(
                                                              "查看日记",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Adapt.pt(
                                                                          18)),
                                                            ),
                                                            margin:
                                                                EdgeInsets.all(
                                                                    Adapt.pt(15)),
                                                          ),
                                                        ),
                                                        Divider(
                                                          color: Colors.grey,
                                                        ),
                                                        GestureDetector(
                                                          child: Container(
                                                            child: Text(
                                                              "编辑日记",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Adapt.pt(
                                                                          18)),
                                                            ),
                                                            margin:
                                                                EdgeInsets.all(
                                                                    Adapt.pt(10)),
                                                          ),
                                                        ),
                                                        Divider(
                                                          color: Colors.grey,
                                                        ),
                                                        GestureDetector(
                                                          child: Container(
                                                            child: Text(
                                                              "置顶该日记",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Adapt.pt(
                                                                          18)),
                                                            ),
                                                            margin:
                                                                EdgeInsets.all(
                                                                    Adapt.pt(10)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              Icons.more_horiz,
                                              size: Adapt.pt(25),
                                              color: Color(0xFF7B9F4D),
                                            ),
                                          ),
                                          height: Adapt.pt(25),
                                          width: Adapt.pt(25),
                                        ),
                                        SizedBox(
                                          width: Adapt.pt(10),
                                        ),
                                      ],
                                    ),
                                  ],

                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: Adapt.pt(1),
                          color: Color(0xFFE3E3E3),
                        )
                      ],
                    );
                  }
                });
          }, childCount: total)),
        ],
      ),
    );
  }
}
