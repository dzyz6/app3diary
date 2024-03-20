import 'package:diary/assets/icon/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'sizecontrol.dart';
import 'dioclass.dart';
import 'package:dio/dio.dart';

class Kanpage extends StatefulWidget {
  const Kanpage({
    Key? key,
    required this.token,
    required this.year,
    required this.month,
    required this.nowday,
  }) : super(key: key);

  final String token;
  final int year;
  final int nowday;
  final int month;

  @override
  State<Kanpage> createState() =>
      _KanpageState(token: token, month: month, year: year, nowday: nowday);
}

List a = ["一", "二", "三", "四", "五", "六", "天"];
int total = 0;

class _KanpageState extends State<Kanpage> {
  var _get = Get();
  Dio dio = Dio();
  String? inside;

  Future<void> createlist(String token) async {
    String url = "http://8.130.98.175/getJournalsByUid";
    dio.options.baseUrl = url;
    dio.options.headers['token'] = token;
    Map<String, dynamic> map = Map();
    map['page'] = 1;
    map['pageSize'] = 100;
    map['journalTitle'] = "";
    map['range'] = 0;
    map['date'] = "$year" + "-" + "$month" + "-" + "$nowday";
    Response response = await dio.get(url, queryParameters: map);
    _get = Get.fromJson(response.data);

    print(inside);
    print('aaaaaaaaaaaaaaaaaaaaaaaaa');
    print(total);
    print("$year" + "-" + "$month" + "-" + "$nowday");
  }

  int year;
  int nowday;
  int month;
  String token;

  _KanpageState({
    required this.token,
    required this.year,
    required this.month,
    required this.nowday,
  });

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SizedBox(
                width: Adapt.pt(95),
              ),
              Text(
                "查看日记",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          backgroundColor: Color(0xFF7B9F4D),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit_calendar_outlined,
                  color: Colors.white,
                  size: Adapt.pt(22),
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  MyFlutterApp.circle,
                  color: Colors.white,
                  size: Adapt.pt(20),
                )),
          ],
        ),
        body: FutureBuilder<void>(
            future: createlist(token),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [Colors.white, Color(0xFFEFFCDE)])),
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

                  return Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [Colors.white, Color(0xFFEFFCDE)])),
                    child: Column(
                      children: [
                        Divider(
                          height: Adapt.pt(2),
                          color: Color(0xFFE3E3E3),
                        ),
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: total,
                              itemExtent: Adapt.pt(80),
                              itemBuilder: (BuildContext context, int index) {
                                inside = _get.data!.records[index].journalText;
                                var time = _get.data!.records[index].createdAt;
                                var creattime = time.substring(12, 14);
                                var creattime2 = time.substring(15, 17);
                                return GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {},
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
                                                            fontSize:
                                                                Adapt.pt(25),
                                                            color:
                                                                Colors.black)),
                                                    TextSpan(
                                                        text: "$month",
                                                        style: TextStyle(
                                                            fontSize:
                                                                Adapt.pt(15),
                                                            color:
                                                                Colors.black)),
                                                    TextSpan(
                                                        text: "月",
                                                        style: TextStyle(
                                                            fontSize:
                                                                Adapt.pt(13),
                                                            color:
                                                                Colors.black)),
                                                  ]),
                                                ),
                                                RichText(
                                                    text: TextSpan(children: [
                                                  TextSpan(
                                                      text: "星期",
                                                      style: TextStyle(
                                                          fontSize:
                                                              Adapt.pt(12),
                                                          color: Colors.black)),
                                                  TextSpan(
                                                    text: a[DateTime(year,
                                                                month, nowday)
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: false,
                                                  ),
                                                  Text(
                                                    "$creattime" +
                                                        ":" +
                                                        "$creattime2",
                                                    style: TextStyle(
                                                        fontSize: Adapt.pt(8),
                                                        color:
                                                            Color(0xff6b6b6b)),
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
                                ;
                              }),
                        )
                      ],
                    ),
                  );
                case ConnectionState.none:
                  return Container();
                case ConnectionState.active:
                  return Container();
              }
            }));
  }
}
