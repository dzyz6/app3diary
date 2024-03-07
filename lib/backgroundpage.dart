import 'package:flutter/material.dart';
import 'sizecontrol.dart';
import 'package:image_picker/image_picker.dart';

class backgroundpage extends StatefulWidget {
  const backgroundpage({super.key});

  @override
  State<backgroundpage> createState() => _backgroundpageState();
}

class _backgroundpageState extends State<backgroundpage> {
  String value='lib/assets/images/rabbit2.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: Adapt.pt(90),),
            Text("选择背景图",style: TextStyle(fontSize: Adapt.pt(25),color: Colors.white,fontWeight: FontWeight.bold),),
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
        child: Container(
          margin: EdgeInsets.only(top: 20,left: 20,right: 20),
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 25,
            children: [
             GestureDetector(
               onTap: (){
                 setState(() {
                   value='lib/assets/images/rabbit2.jpg';
                   Navigator.of(context)..pop(value)..pop(value);
                 });
               },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.asset('lib/assets/images/rabbit2.jpg'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    value='lib/assets/images/rabbit3.jpg';
                    Navigator.of(context)..pop(value)..pop(value);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.asset('lib/assets/images/rabbit3.jpg'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    value='lib/assets/images/rabbit5.jpg';
                    Navigator.of(context)..pop(value)..pop(value);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.asset('lib/assets/images/rabbit5.jpg'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    value='lib/assets/images/rabbit6.jpg';
                    Navigator.of(context)..pop(value)..pop(value);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.asset('lib/assets/images/rabbit6.jpg'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    value='lib/assets/images/rabbit7.jpg';
                    Navigator.of(context)..pop(value)..pop(value);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.asset('lib/assets/images/rabbit7.jpg'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    value='lib/assets/images/rabbit8.jpg';
                    Navigator.of(context)..pop(value)..pop(value);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.asset('lib/assets/images/rabbit8.jpg'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    value='lib/assets/images/rabbit1.jpg';
                    Navigator.of(context)..pop(value)..pop(value);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.asset('lib/assets/images/rabbit1.jpg',fit: BoxFit.cover,),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    value='lib/assets/images/rabbit9.jpg';
                    Navigator.of(context)..pop(value)..pop(value);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.asset('lib/assets/images/rabbit9.jpg'),
                  ),
                ),
              ),

            ],
          ),
        ),

      ),
    );
  }
}
