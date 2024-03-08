import 'dart:ui';
import 'package:diary/register.dart/data.dart';
import 'package:flutter/material.dart';
import './sizecontrol.dart';
var image1 = 'lib/assets/images/rabbit1.jpg';
var image2 = 'lib/assets/images/rabbit2.jpg';

class Diarychuan extends StatefulWidget {
  const Diarychuan({super.key});
  @override
  State<Diarychuan> createState() => _DiarychuanState();
}

class _DiarychuanState extends State<Diarychuan> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: DiaryList(),
    );
  }
}

List<Widget> litems = [ImageListCard(), ImageListCard()];
List<Widget> chuanlitems=[];


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
  const ImageListCard({super.key});

  @override
  State<ImageListCard> createState() => _ImageListCardState();
}

class _ImageListCardState extends State<ImageListCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      children: [ImageBox(), ImageBox()],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    ));
  }
}

class ImageBox extends StatefulWidget {
  const ImageBox({super.key});

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {

                 Navigator.push(context,
                     MaterialPageRoute(builder: (context) => Diarychuan2()));
          
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
                        image1,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ]),
        ));
  }
}

class DiaryLine extends StatefulWidget {
  const DiaryLine({super.key});

  @override
  State<DiaryLine> createState() => _DiaryLineState();
}
  
  

class _DiaryLineState extends State<DiaryLine> {
  @override

  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TimeData(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '哈哈哈哈哈！',
                    style: TextStyle(fontSize: 17),
                  ),
                  Container(
                    child: Image.asset(image2),
                    width: 200,
                    height: 200,
                  ),
                 Text(
                      '哈哈哈哈哈！哈哈哈哈哈！kkkkkkk',
                      style: TextStyle(fontSize: 17),
                    ),
                  DiaryCondition()
                ],
              ),
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

class ChuanLine extends StatelessWidget {
  //var _x;
  //var _y;
 ChuanLine({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomPaint(
          foregroundPainter: CirclePainter(),
          child: DiaryLine(),
        ),
         CustomPaint(
          foregroundPainter: CirclePainter(),
          child: DiaryLine(),
        ), CustomPaint(
          foregroundPainter: CirclePainter(),
          child: DiaryLine(),
        ), CustomPaint(
          foregroundPainter: CirclePainter(),
          child: DiaryLine(),
        ),
      ],
    );
  }
}

List painterdata = [300];

class CirclePainter extends CustomPainter {  
Rect stretch(Rect f,int df)
{
  Rect pRect = Rect.fromLTRB(f.left, f.top+df, f.right, f.bottom+df);
  return pRect;
}
  @override
  void paint(Canvas canvas, Size size) {
    Rect pRect1 = Rect.fromLTRB(90, 25, 115, 50);
    Rect pRect2 = Rect.fromLTRB(93, 28, 112, 47);
    Paint paint1 = Paint()
    ..color = const Color(0xFF445B28);

    Paint paint2 = Paint()..color = Color.fromARGB(255, 255, 255, 255);
    Paint paint3 =Paint()..color =Color(0xff7B9F4D)..strokeWidth=2;
for (var element in painterdata) {
  canvas.drawOval(pRect1, paint1);
    canvas.drawOval(pRect2, paint2);
    canvas.drawLine(Offset(pRect1.center.dx, pRect1.bottom), Offset(pRect1.center.dx,pRect1.bottom+element), paint3);
    pRect1=stretch(pRect1, element);
    pRect2 =stretch(pRect2, element);
}       
    

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}


class TimeData extends StatelessWidget {
  TimeData({super.key});
  var moon = '1月';
  var day = '18';
  var weekday = '星期六';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Adapt.pt(20), right: Adapt.pt(50),top: Adapt.pt(20)),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                day,
                style: TextStyle(fontSize: 30),
              ),
              Text(
                moon,
                style: TextStyle(fontSize: 18),
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
  const Diarychuan2({super.key});

  @override
  State<Diarychuan2> createState() => _Diarychuan2State();
}

class _Diarychuan2State extends State<Diarychuan2> {
  var register =RegisterFunction();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
          onPressed: () {
          //  register.tokenTest();
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
        backgroundColor: Color(0xFF7B9F4D),),
      body: ChuanLine(),
    
    );
  }
}
