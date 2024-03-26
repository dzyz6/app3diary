import 'package:flutter/material.dart';
import 'dioclass.dart';
import 'sizecontrol.dart';
import 'package:dio/dio.dart';

class searchpage extends StatefulWidget {
  const searchpage({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  State<searchpage> createState() => _searchpageState(token:
  token);
}

class _searchpageState extends State<searchpage> {
  String token;

  _searchpageState({required this.token});

  TextEditingController _textcirl = TextEditingController();

  List a = ["一", "二", "三", "四", "五", "六", "天"];

  var _get = Get();
  Dio dio = Dio();

  late String inside="";
  int total = 0;

  Future<void> createlist(String token) async {
    String url = "https://mambaout.xyz/getJournalsByUid";
    dio.options.baseUrl = url;
    dio.options.headers['token'] = token;
    Map<String, dynamic> map = Map();
    map['page'] = 1;
    map['pageSize'] = 100;
    map['journalTitle'] = "";
    map['range'] = 0;
    Response response = await dio.get(url, queryParameters: map);
    _get = Get.fromJson(response.data);

    print(inside);
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
      appBar: AppBar(
        toolbarHeight: Adapt.pt(80),
        automaticallyImplyLeading: false,
        title: Container(
          height: Adapt.pt(35),
          width: Adapt.pt(280),
          child: TextField(
            style: TextStyle(fontSize: Adapt.pt(13), ),
            controller: _textcirl,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search_outlined,color: Color(0xFF939393),),
                fillColor: Color(0xFFD5D5D5),
                filled: true,

                contentPadding: EdgeInsets.only(left: Adapt.pt(15),right: Adapt.pt(15)),
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFD5D5D5),
                    width: 0,


                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),

              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFD5D5D5),
                  width: 0,


                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ) ,
              hintText: "今天想搜些什么呢₍ᐢ..ᐢ₎♡",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFD5D5D5),
                    width: 0,

                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),

                suffixIcon: IconButton(
              icon:Icon(Icons.cancel,color: Color(0xFFB4B4B4),),
              onPressed: () {
                _textcirl.clear();
              },
            )),
          ),
        ),
        backgroundColor: Color(0xFFFFFFFF),
        leading: Row(
          children: [
            SizedBox(
              width: Adapt.pt(5),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF445B28),
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Adapt.pt(20)),
            child: GestureDetector(
              onTap: (){

              },
              child: Text("搜索",style: TextStyle(fontSize: Adapt.pt(15),color: Color(0xFF7B9F4D)),),
            ),
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,

                colors: [Colors.white, Color(0xFFEFFCDE)])),
        child: FutureBuilder(future: createlist(token),
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

                  return ListView.builder(
                      itemCount: total,
                      itemExtent: Adapt.pt(80),
                      itemBuilder: (BuildContext context, int index) {
                        inside = _get.data!.records[index].journalText;

                        var time = _get.data!.records[index].createdAt;
                        var creattime = time.substring(12, 14);
                        var creattime2 = time.substring(15, 17);
                        var creattimeday = time.substring(8, 10);
                        var creattimemonth = time.substring(6, 7);
                        var creattimeyear = time.substring(0, 4);
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
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
                                        RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: "星期",
                                                  style: TextStyle(
                                                      fontSize: Adapt.pt(12),
                                                      color: Colors.black)),
                                              TextSpan(
                                                text: a[
                                                DateTime(int.parse(creattimeyear), int.parse(creattimemonth), int.parse(creattimeday))
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

                      });
                case ConnectionState.none:
                  return Container();
                case ConnectionState.active:
                  return Container();
              }
            }),
      ),
    );
  }
}
