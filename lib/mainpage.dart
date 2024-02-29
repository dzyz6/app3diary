import 'package:diary/assets/icon/my_flutter_app_icons.dart';
import 'package:diary/diarychuan.dart';
import 'package:diary/diarypage.dart';
import 'package:diary/editorpage.dart';
import 'package:diary/person.dart';
import 'package:diary/searchpage.dart';
import 'package:diary/sizecontrol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';

var colororigin = Color(0xFF445B28);
var colorclick = Color(0xFFDCEEC4);

//获取时间
DateTime dateTime = DateTime.now();

class mainpage extends StatefulWidget {
  const mainpage({super.key});

  @override
  State<mainpage> createState() => _mainpageState();
}

int _month = dateTime.month;

int _year = dateTime.year;

var firstDayOfMonth = DateTime(_year, _month, 1);
var lastDayOfMonth = DateTime(_year, _month + 1, 0);

class _mainpageState extends State<mainpage> {
  ScrollController _controllerbottom = ScrollController();

  PageController _pagecontroller = PageController(initialPage: 0);

  Color icon1Color = Color(0xFF7B9F4D);
  Color icon2Color = Color(0xFF445B28);
  Color icon3Color = Color(0xFF445B28);
  Color icon4Color = Color(0xFF445B28);

  void changeColor(int iconNumber) {
    setState(() {
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
    });
  }

  int nowpage = 0;


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
    if(_month==dateTime.month&&_year==dateTime.year)
    {_toggleItemStatus(dateTime.day + 3);};
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
                    Pickers.showDatePicker(
                        context,
                      pickerStyle: PickerStyle(
                        cancelButton: Container(
                          margin: EdgeInsets.all(Adapt.pt(10)),
                          child: Text("取消",style: TextStyle(

                          ),),
                        ),
                        textSize: Adapt.pt(25),
                        pickerTitleHeight: Adapt.pt(40),
                        pickerItemHeight: Adapt.pt(60),
                        headDecoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(Adapt.pt(20)),topLeft: Radius.circular(Adapt.pt(20))),
                          color: Colors.white
                        )

                      ),
                      mode: DateMode.YM,
                      onConfirm: (p){
                          setState(() {
                            _month=p.month as int;
                            _year=p.year as int;
                            firstDayOfMonth = DateTime(_year, _month, 1);
                            lastDayOfMonth = DateTime(_year, _month + 1, 0);
                            _itemStatuses = List.generate(42, (_) => false);

                          });

                      }
                    );

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
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => searchpage()));
                  },
                  icon: Icon(
                    Icons.search_outlined,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(0),
                  iconSize: 30,
                ),
                IconButton(
                  onPressed: () {},
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
                          _month=dateTime.month;
                          _year=dateTime.year;
                          firstDayOfMonth = DateTime(_year, _month, 1);
                          lastDayOfMonth = DateTime(_year, _month + 1, 0);
                          _toggleItemStatus(dateTime.day + 3);

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
                          color: Color(0xFFA7A7A7), fontSize: Adapt.pt(22)),
                    ),
                    SizedBox(
                      width: Adapt.pt(35),
                    ),
                    Text(
                      "一",
                      style: TextStyle(
                          color: Color(0xFFA7A7A7), fontSize: Adapt.pt(22)),
                    ),
                    SizedBox(
                      width: Adapt.pt(35),
                    ),
                    Text(
                      "二",
                      style: TextStyle(
                          color: Color(0xFFA7A7A7), fontSize: Adapt.pt(22)),
                    ),
                    SizedBox(
                      width: Adapt.pt(35),
                    ),
                    Text(
                      "三",
                      style: TextStyle(
                          color: Color(0xFFA7A7A7), fontSize: Adapt.pt(22)),
                    ),
                    SizedBox(
                      width: Adapt.pt(35),
                    ),
                    Text(
                      "四",
                      style: TextStyle(
                          color: Color(0xFFA7A7A7), fontSize: Adapt.pt(22)),
                    ),
                    SizedBox(
                      width: Adapt.pt(35),
                    ),
                    Text(
                      "五",
                      style: TextStyle(
                          color: Color(0xFFA7A7A7), fontSize: Adapt.pt(22)),
                    ),
                    SizedBox(
                      width: Adapt.pt(35),
                    ),
                    Text(
                      "六",
                      style: TextStyle(
                          color: Color(0xFFA7A7A7), fontSize: Adapt.pt(22)),
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
                    mainAxisSpacing: Adapt.pt(12),
                    crossAxisSpacing: Adapt.pt(10),
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 7,
                    children: List.generate(42, (index) {
                      var firstDayOfWeek = firstDayOfMonth.weekday;
                      int daysUntilFirstMonday = 1;
                      if (firstDayOfWeek != 1) {
                        if(firstDayOfWeek==7){
                          daysUntilFirstMonday = firstDayOfWeek-7;
                        }
                        else{
                        daysUntilFirstMonday = firstDayOfWeek;}
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
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(Adapt.pt(10)),
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
              ],
            ),
          ),
          diarypage(),
          diarychuan(),
          person(),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => editorpage()));
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
