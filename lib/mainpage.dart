import 'dart:math';

import 'package:diary/assets/icon/my_flutter_app_icons.dart';
import 'package:diary/diarychuan.dart';
import 'package:diary/diarypage.dart';
import 'package:diary/editorpage.dart';
import 'package:diary/kanpage.dart';
import 'package:diary/pageanimate.dart';
import 'package:diary/person.dart';
import 'package:diary/persondio.dart';
import 'package:diary/searchpage.dart';
import 'package:diary/sizecontrol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'dioclass.dart';

var colororigin = Color(0xFF445B28);
var colorclick = Color(0xFFDCEEC4);

List a = ["一", "二", "三", "四", "五", "六", "天"];

int total = 0;
late String inside;
//获取时间
DateTime dateTime = DateTime.now();

Widget getItem(int index) {
  return GestureDetector(
    onTap: () {

    },
    child: Column(
      children: [
        Container(
          height: Adapt.pt(79),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: Adapt.pt(20),),
              Column(

                children: [
                  SizedBox(
                    height: Adapt.pt(15),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "$nowday",
                          style: TextStyle(
                              fontSize: Adapt.pt(25), color: Colors.black)),
                      TextSpan(
                          text: "$_month",
                          style: TextStyle(
                              fontSize: Adapt.pt(15), color: Colors.black)
                      ),
                      TextSpan(
                          text: "月",
                          style: TextStyle(
                              fontSize: Adapt.pt(13), color: Colors.black)
                      ),

                    ]),
                  ),

                  RichText(text: TextSpan(
                      children: [
                        TextSpan(
                            text: "星期",
                            style: TextStyle(
                                fontSize: Adapt.pt(12), color: Colors.black)
                        ),
                        TextSpan(
                          text: a[DateTime(_year, _month, nowday).weekday - 1],
                          style: TextStyle(
                              fontSize: Adapt.pt(12), color: Colors.black),
                        ),
                      ]
                  )),

                ],


              ),
              RichText(text: TextSpan(children: [
                TextSpan(
                  text: "$inside", style: TextStyle(
                    fontSize: Adapt.pt(12), color: Colors.black),
                )
              ]))
            ],
          ),

        ),
        Divider(
          height: Adapt.pt(1),
          color: Color(0xFFE3E3E3),
        )
      ],
    ),
  );
}

int nowday = dateTime.day;


/// 位置服务
Future _determinePosition() async {
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
    Position position = await Geolocator.getCurrentPosition();
    longitude = position.longitude;
    latitude = position.latitude;
  } catch (e) {
    print(e);
  }
}

class mainpage extends StatefulWidget {
  const mainpage({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  State<mainpage> createState() => _mainpageState(token: token);
}

int _month = dateTime.month;

int _year = dateTime.year;

class _mainpageState extends State<mainpage> {
  var _get = Get();
  Dio dio = Dio();


  Future<void> createlist(String token) async {
    String url = "http://8.130.98.175/getJournalsByUid";
    dio.options.baseUrl = url;
    dio.options.headers['token'] = token;
    Map<String, dynamic> map = Map();
    map['page'] = 1;
    map['pageSize'] = 100;
    map['journalTitle'] = "";
    map['range'] = 0;
    map['date'] = "$_year" + "-" + "$_month" + "-" + "$nowday";
    Response response = await dio.get(url, queryParameters: map);
    _get = Get.fromJson(response.data);



    print(inside);
    print('aaaaaaaaaaaaaaaaaaaaaaaaa');
    print(total);
    print("$_year" + "-" + "$_month" + "-" + "$nowday");
  }

  String token;

  _mainpageState({required this.token});

  ScrollController _controllerbottom = ScrollController();

  PageController _pagecontroller = PageController(initialPage: 0);

  Color icon1Color = Color(0xFF7B9F4D);
  Color icon2Color = Color(0xFF445B28);
  Color icon3Color = Color(0xFF445B28);
  Color icon4Color = Color(0xFF445B28);

  void changeColor(int iconNumber) {
    if (iconNumber == 1) {
      icon1Color = Color(0xFF7B9F4D); // Change to your desired color
      // Reset other icons' colors if needed
      icon2Color = Color(0xFF445B28);
      icon3Color = Color(0xFF445B28);
      icon4Color = Color(0xFF445B28);
    } else if (iconNumber == 2) {
      icon2Color = Color(0xFF7B9F4D); // Change to your desired color
      // Reset other icons' colors if needed
      icon1Color = Color(0xFF445B28);
      icon3Color = Color(0xFF445B28);
      icon4Color = Color(0xFF445B28);
    } else if (iconNumber == 3) {
      icon3Color = Color(0xFF7B9F4D); // Change to your desired color
      // Reset other icons' colors if needed
      icon1Color = Color(0xFF445B28);
      icon2Color = Color(0xFF445B28);
      icon4Color = Color(0xFF445B28);
    } else if (iconNumber == 4) {
      icon4Color = Color(0xFF7B9F4D); // Change to your desired color
      // Reset other icons' colors if needed
      icon1Color = Color(0xFF445B28);
      icon2Color = Color(0xFF445B28);
      icon3Color = Color(0xFF445B28);
    }
    ;
  }

  int nowpage = 0;
  var firstDayOfMonth = DateTime(_year, _month, 1);
  var lastDayOfMonth = DateTime(_year, _month + 1, 0);

  List<bool> _itemStatuses = List.generate(42, (_) => false);

  void _toggleItemStatus(int index) {
    setState(() {
      _itemStatuses = List.generate(42, (_) => false);

      _itemStatuses[index] = !_itemStatuses[index];
    });
  }

  @override
  void initState() {
    super.initState();
    if (_month == dateTime.month && _year == dateTime.year) {
      _toggleItemStatus(dateTime.day + firstDayOfMonth.weekday - 1);
    }
    ;
    createlist(token);
    getUserMessage = GetUserMessage(token);
    getUserMessage.getUserMessage(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pagecontroller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Pickers.showDatePicker(context,
                        pickerStyle: PickerStyle(
                            textColor: Color(0xFF445B28),
                            cancelButton: Container(
                              margin: EdgeInsets.only(left: Adapt.pt(20)),
                              child: Text(
                                "取消",
                                style: TextStyle(
                                    fontSize: Adapt.pt(18),
                                    color: Colors.black),
                              ),
                            ),
                            commitButton: Container(
                              margin: EdgeInsets.only(right: Adapt.pt(20)),
                              child: Text(
                                "确定",
                                style: TextStyle(
                                  fontSize: Adapt.pt(18),
                                  color: Color(0xFF7B9F4D),
                                ),
                              ),
                            ),
                            textSize: Adapt.pt(25),
                            pickerTitleHeight: Adapt.pt(40),
                            pickerItemHeight: Adapt.pt(60),
                            headDecoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(Adapt.pt(20)),
                                    topLeft: Radius.circular(Adapt.pt(20))),
                                color: Colors.white)),
                        mode: DateMode.YM, onConfirm: (p) {
                          setState(() {
                            _month = p.month as int;
                            _year = p.year as int;
                            firstDayOfMonth = DateTime(_year, _month, 1);
                            lastDayOfMonth = DateTime(_year, _month + 1, 0);
                            _itemStatuses = List.generate(42, (_) => false);
                            total = 0;
                          });
                        });
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: ' ', // 空格用于调整间距，可以根据需要调整
                          style: TextStyle(
                            fontSize: Adapt.pt(25),
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: _month.toString(),
                          style: TextStyle(
                            fontSize: Adapt.pt(25),
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: '月',
                          style: TextStyle(
                            fontSize: Adapt.pt(25),
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: ' ', // 空格用于调整间距，可以根据需要调整
                          style: TextStyle(
                            fontSize: Adapt.pt(25),
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: _year.toString(),
                          style: TextStyle(
                            fontSize: Adapt.pt(20),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )),
              actions: [
                //搜素
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => searchpage()));
                  },
                  icon: Icon(
                    Icons.search_outlined,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(0),
                  iconSize: 30,
                ),

                //定位
                IconButton(
                  onPressed: () async {
                    await _determinePosition();
                  },
                  icon: Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(0),
                  iconSize: 30,
                ),
              ],
              backgroundColor: Color(0xFF7B9F4D),
            ),
            body:

            //主页面
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _month = dateTime.month;
                          _year = dateTime.year;
                          firstDayOfMonth = DateTime(_year, _month, 1);
                          lastDayOfMonth = DateTime(_year, _month + 1, 0);
                          _toggleItemStatus(
                              dateTime.day + firstDayOfMonth.weekday - 1);
                          nowday = dateTime.day;
                          createlist(token);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: Adapt.pt(12),
                            right: Adapt.pt(12),
                            top: Adapt.pt(3),
                            bottom: Adapt.pt(3)),
                        margin: EdgeInsets.all(Adapt.pt(5)),
                        child: Text(
                          "今日",
                          style: TextStyle(fontSize: Adapt.pt(13)),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Adapt.pt(12),
                          right: Adapt.pt(12),
                          top: Adapt.pt(3),
                          bottom: Adapt.pt(3)),
                      margin: EdgeInsets.all(Adapt.pt(5)),
                      child: Text(
                        "分享",
                        style: TextStyle(fontSize: Adapt.pt(13)),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black)),
                    ),
                    SizedBox(
                      width: Adapt.pt(10),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Adapt.pt(32),
                    ),
                    Text(
                      "日",
                      style: TextStyle(
                          color: Color(0xFFA7A7A7),
                          fontSize: Adapt.pt(22),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: Adapt.pt(35),
                    ),
                    Text(
                      "一",
                      style: TextStyle(
                          color: Color(0xFFA7A7A7),
                          fontSize: Adapt.pt(22),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: Adapt.pt(35),
                    ),
                    Text(
                      "二",
                      style: TextStyle(
                          color: Color(0xFFA7A7A7),
                          fontSize: Adapt.pt(22),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: Adapt.pt(35),
                    ),
                    Text(
                      "三",
                      style: TextStyle(
                          color: Color(0xFFA7A7A7),
                          fontSize: Adapt.pt(22),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: Adapt.pt(35),
                    ),
                    Text(
                      "四",
                      style: TextStyle(
                          color: Color(0xFFA7A7A7),
                          fontSize: Adapt.pt(22),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: Adapt.pt(35),
                    ),
                    Text(
                      "五",
                      style: TextStyle(
                          color: Color(0xFFA7A7A7),
                          fontSize: Adapt.pt(22),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: Adapt.pt(35),
                    ),
                    Text(
                      "六",
                      style: TextStyle(
                          color: Color(0xFFA7A7A7),
                          fontSize: Adapt.pt(22),
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: Adapt.pt(12),
                ),
                Container(
                  height: Adapt.pt(360),
                  width: Adapt.pt(390),
                  child: GridView.count(
                    mainAxisSpacing: Adapt.pt(15),
                    crossAxisSpacing: Adapt.pt(10),
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 7,
                    children: List.generate(42, (index) {
                      var firstDayOfWeek = firstDayOfMonth.weekday;
                      int daysUntilFirstMonday = 1;
                      if (firstDayOfWeek != 1) {
                        if (firstDayOfWeek == 7) {
                          daysUntilFirstMonday = firstDayOfWeek - 7;
                        } else {
                          daysUntilFirstMonday = firstDayOfWeek;
                        }
                      }

                      var day1 = firstDayOfMonth
                          .add(Duration(days: index - daysUntilFirstMonday))
                          .day;

                      var month1 = firstDayOfMonth
                          .add(Duration(days: index - daysUntilFirstMonday))
                          .month;

                      if (month1 != _month) {
                        return Container(
                          width: Adapt.pt(300) / 7,
                          decoration: BoxDecoration(color: Colors.transparent),
                        );
                      }
                      var _color1 = Color(0xFFFAE7E7);
                      var _color2 = Color(0xFFDFEEFC);
                      var _color3 = Color(0xFFFEF7DE);
                      var _color4 = Color(0xFFF9ACAC);
                      var _color5 = Color(0xFF217FD6);
                      var _color6 = Color(0xFFFFE071);

                      List<Color> colors = [_color1, _color2, _color3];
                      List<Color> colors2 = [_color4, _color5, _color6];

                      int colorIndex2 = day1 % colors.length;
                      Color containerColor2 = colors2[colorIndex2];

                      int colorIndex = day1 % colors.length;
                      Color containerColor = colors[colorIndex];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _toggleItemStatus(index);
                            nowday = day1;
                            createlist(token);
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: _itemStatuses[index]
                                ? containerColor2
                                : containerColor,
                          ),
                          child: Center(
                            child: Text(
                              '$day1',
                              style: TextStyle(
                                  fontSize: Adapt.pt(23),
                                  fontWeight: FontWeight.w500,
                                  color: _itemStatuses[index]
                                      ? Colors.white
                                      : Color(0xFFC8C8C8)),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                      "自定义日历图",
                      style: TextStyle(fontSize: 12, color: Color(0xFF217FD6)),
                    ),
                  ),
                ),
                SizedBox(
                  height: Adapt.pt(10),
                ),
                Divider(
                  height: Adapt.pt(2),
                  color: Color(0xFFE3E3E3),
                ),
                FutureBuilder(future: createlist(token),
                    builder: (BuildContext context,
                        AsyncSnapshot<void> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child: Container(

                            ),
                          );

                        case ConnectionState.done:

                            if (_get != null &&
                                _get.data != null &&
                                _get.data!.records.isNotEmpty &&
                                _get.data?.total != 0) {
                              total = _get.data!.total;
                            } else {
                              total = 0;
                              inside = "";
                            }

                          return Expanded(
                            child: ListView.builder(
                                itemCount: total,
                                itemExtent: Adapt.pt(80),
                                itemBuilder: (BuildContext context, int index) {
                                  inside = _get.data!.records[index].journalText;
                                  var time = _get.data!.records[index].createdAt;
                                  var creattime = time.substring(12, 14);
                                  var creattime2 = time.substring(15, 17);
                                  return GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  Kanpage(token: token,
                                                    month: _month,
                                                    year: _year,
                                                    nowday: nowday,)));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: Adapt.pt(79),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: Adapt.pt(20),
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: Adapt.pt(15),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: "$nowday",
                                                          style: TextStyle(
                                                              fontSize: Adapt.pt(25),
                                                              color: Colors.black)),
                                                      TextSpan(
                                                          text: "$_month",
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
                                                  RichText(
                                                      text: TextSpan(children: [
                                                        TextSpan(
                                                            text: "星期",
                                                            style: TextStyle(
                                                                fontSize: Adapt.pt(12),
                                                                color: Colors.black)),
                                                        TextSpan(
                                                          text: a[
                                                          DateTime(_year, _month, nowday)
                                                              .weekday -
                                                              1],
                                                          style: TextStyle(
                                                              fontSize: Adapt.pt(12),
                                                              color: Colors.black),
                                                        ),
                                                      ])),
                                                ],
                                              ),
                                              SizedBox(
                                                width: Adapt.pt(20),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "$inside",
                                                      style: TextStyle(
                                                        fontSize: Adapt.pt(15),
                                                        color: Colors.black,
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      softWrap: false,
                                                    ),
                                                    Text(
                                                      "$creattime" + ":" + "$creattime2",
                                                      style: TextStyle(
                                                          fontSize: Adapt.pt(8),
                                                          color: Color(0xff6b6b6b)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: Adapt.pt(1),
                                          color: Color(0xFFE3E3E3),
                                        )
                                      ],
                                    ),
                                  );

                                }),
                          );
                        case ConnectionState.none:
                          return Container();
                        case ConnectionState.active:
                          return Container();
                      }
                    })
              ],
            ),
          ),

          diarypage( token: token,),
          Diarychuan(token),
          Person(token: token),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //日历图标
              IconButton(
                  onPressed: () {
                    setState(() {
                      changeColor(1);
                      _pagecontroller.jumpToPage(0);
                    });
                  },
                  icon: Icon(
                    MyFlutterApp.calender,
                    color: icon1Color,
                    size: Adapt.pt(35),
                  )),
              //日记
              IconButton(
                  onPressed: () {
                    setState(() {
                      changeColor(2);
                      _pagecontroller.jumpToPage(1);
                    });
                  },
                  icon: Icon(
                    MyFlutterApp.book,
                    color: icon2Color,
                    size: Adapt.pt(30),
                  )),
              //添加
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      SlideRoute(page: editorpage(
                        token: token,)));
                },
                elevation: 0,
                backgroundColor: Color(0xFF7B9F4D),
                shape: CircleBorder(),
                child: Icon(
                  Icons.add,
                  size: Adapt.pt(53),
                  color: Colors.white,
                ),
              ),
              //日记串
              IconButton(
                  onPressed: () {
                    setState(() {
                      changeColor(3);
                      _pagecontroller.jumpToPage(2);
                    });
                  },
                  icon: Icon(
                    MyFlutterApp.circle,
                    color: icon3Color,
                    size: Adapt.pt(30),
                  )),
              //用户
              IconButton(
                  onPressed: () {
                    setState(() {
                      changeColor(4);
                      _pagecontroller.jumpToPage(3);
                    });
                  },
                  icon: Icon(
                    MyFlutterApp.head,
                    color: icon4Color,
                    size: Adapt.pt(30),
                  )),
            ],
          ),
          color: Color(0xFFDCEEC4),
        ),
      ),
    );
  }
}
