

import 'package:docotg/screens/Diagnose_screen.dart';
import 'package:docotg/screens/doctor_homescreen.dart';
import 'package:docotg/screens/homescreen.dart';
import 'package:docotg/screens/profile.dart';
import 'package:docotg/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class MobileScreenLayout extends StatefulWidget {
  bool isDoctor;
   MobileScreenLayout( this.isDoctor, {super.key});
  

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  late PageController pageController;
 

    @override
    void initState(){
      super.initState();
      addData();

      pageController = PageController();
    }
    addData() async {
      print("updating user from mobilr sceeen");
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  // wan't working coz user ki value set hi ni ki
  }

    @override
    void dispose(){
      super.dispose();
      pageController.dispose();
    }

    void navigationTapped(int page){
      pageController.jumpToPage(page);
    }

    void onPageChanged(int page){
      setState((){
        _page = page;
      });
    }
    String name = "";
    int _page = 0;
   
  @override
  Widget build(BuildContext context) {
     var homeScreenItems = [
      widget.isDoctor ?DocHomePage() :HomePage(),
      DiagnoseScreen(),
      ProfilePage()
    ];
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,),
       bottomNavigationBar: CupertinoTabBar(
        height: height*0.078,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
                icon: Icon(Icons.home, color: _page == 0? blueColor : Colors.grey,),
              label: '',
              backgroundColor: Colors.grey,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shield, color: _page == 1? blueColor : Colors.grey,),
              label: '',
              backgroundColor: Colors.grey,
            ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: _page == 2? blueColor : Colors.grey,),
              label: '',
              backgroundColor: Colors.grey,
            ),
        ],
        onTap: navigationTapped,
       ),
       
    );
  }
}