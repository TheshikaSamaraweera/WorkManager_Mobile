import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:workapp/pages/order.dart';
import 'package:workapp/pages/profile.dart';
import 'package:workapp/pages/wallet.dart';

import 'home.dart';

class BottomNav extends StatefulWidget{
  const BottomNav ({super.key});
  @override
  State<BottomNav> createState() => _BottomNavState();

}
class _BottomNavState extends State<BottomNav>{
  int currentTabIndex=0;

  late List<Widget>pages;
  late Widget currentPage;
  late  Home homepage;
  late  Wallet  wallet;
  late Order order;
  late Profile profile;

  @override
  void initState(){
    homepage=Home();
    order=Order();
    profile=Profile();
    wallet=Wallet();
    pages=[homepage,order,wallet,profile];
    super.initState();
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(

        height:65,
        backgroundColor: Colors.white,
          animationDuration:Duration(microseconds: 500) ,
          color: Colors.black,
          onTap: (int index){
          setState(() {
            currentTabIndex=index;
          });
          },

          items:[
        Icon(
          Icons.home_outlined,
          color:Colors.white,
        ),
        Icon(
          Icons.person_2_outlined,
          color:Colors.white,
        ),
        Icon(
          Icons.shopping_bag_outlined,
          color:Colors.white,
        ),
        Icon(
          Icons.wallet_outlined,
          color:Colors.white,
        ),

      ]

      ),

      body: pages[currentTabIndex],
    );
  }
}