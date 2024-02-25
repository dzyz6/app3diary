import 'package:flutter/material.dart';
import 'sizecontrol.dart';


class diarypage extends StatefulWidget {
  const diarypage({super.key});

  @override
  State<diarypage> createState() => _diarypageState();
}

class _diarypageState extends State<diarypage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CustomScrollView(
        slivers:<Widget> [
          SliverAppBar(//类微信头部
            backgroundColor: Color(0xFF7B9F4D),
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight:200,
            actions: [
              Row(
                children: [
                  IconButton(onPressed: (){},icon: Icon(Icons.search_outlined,size: Adapt.pt(35),),),
                ],
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Image.asset("lib/assets/images/rabbit1.jpg",fit: BoxFit.cover,),
            ),

          ),
          

        ],
      )

    );
  }
}
