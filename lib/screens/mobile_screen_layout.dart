import 'package:docotg/screens/diagnose_screen.dart';
import 'package:docotg/screens/doctor_homescreen.dart';
import 'package:docotg/screens/homescreen.dart';
import 'package:docotg/screens/profile.dart';
import 'package:docotg/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';

class MobileScreenLayout extends StatefulWidget {
  final bool isDoctor;
   const MobileScreenLayout( this.isDoctor, {super.key});
  

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
      widget.isDoctor ?const DocHomePage() :const HomePage(),
      const DiagnoseScreen(),
      const ProfilePage()
    ];
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,),
       bottomNavigationBar: Container(
         decoration: const BoxDecoration(
           boxShadow: [BoxShadow(color: Color(0x90585be4), blurRadius: 20),],
         ),
         child: CupertinoTabBar(
          height: height*0.088,
          backgroundColor: Colors.white,
          iconSize: 40,
          items: [
            BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled,
                    color: _page == 0? primaryColor : Colors.grey,
                    shadows: [Shadow(color: primaryColor,
                        blurRadius: _page == 0? 15 : 0)],),
                label: '',
                backgroundColor: Colors.grey,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shield_rounded, color: _page == 1? primaryColor : Colors.grey,
                  shadows: [Shadow(color: primaryColor,
                      blurRadius: _page == 1? 15 : 0)],),
                label: '',
                backgroundColor: Colors.grey,
              ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded, color: _page == 2? primaryColor : Colors.grey,
                  shadows: [Shadow(color: primaryColor,
                      blurRadius: _page == 2? 15 : 0)],),
                label: '',
                backgroundColor: Colors.grey,
              ),
          ],
          onTap: navigationTapped,
         ),
       ),
       
    );
  }
}