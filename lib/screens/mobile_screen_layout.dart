import 'package:docotg/screens/diagnose_screen.dart';
import 'package:docotg/screens/doctor_homescreen.dart';
import 'package:docotg/screens/homescreen.dart';
import 'package:docotg/screens/profile.dart';
import 'package:docotg/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';

class MobileScreenLayout extends StatefulWidget {
  final bool isDoctor = false;

  const MobileScreenLayout(isDoctor, {super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    addData();
    pageController = PageController();
  }

  addData() async {
    await Provider.of<UserProvider>(context, listen: false).refreshUser();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  String name = "";
  int _page = 0;
  List headers = ["Doc-OTG", "Clinical Inputs", "Profile"];

  @override
  Widget build(BuildContext context) {
    var homeScreenItems = [
      widget.isDoctor ? const DocHomePage() : const HomePage(),
      const DiagnoseScreen(),
      const ProfilePage()
    ];
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      appBar: AppBar(
          title: Text(
            headers[_page].toString(),
            style: TextStyle(
                fontSize: height * 0.036,
                fontWeight: FontWeight.bold,
                color: darkPurple),
          ),
          backgroundColor: screenBgColor,
          actions: [
            IconButton(
              icon: Icon(
                Icons.menu_rounded,
                color: darkPurple,
                size: 28.0,
              ),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  useSafeArea: true,
                  context: context,
                  builder: (BuildContext bc) {
                    return Expanded(
                      child: Container(
                        // height: height * 0.5,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: screenBgColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Wrap(
                          children: [
                            // Settings
                            ListTile(
                              leading: Icon(
                                Icons.settings,
                                color: darkPurple,
                              ),
                              title: Text(
                                "Settings",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: darkPurple,
                                ),
                              ),
                            ),
                            // Support
                            ListTile(
                              leading: Icon(
                                Icons.support_agent,
                                color: darkPurple,
                              ),
                              title: Text(
                                "Support",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: darkPurple,
                                ),
                              ),
                            ),
                            // About Us
                            ListTile(
                              leading: Icon(
                                Icons.info_outline_rounded,
                                color: darkPurple,
                              ),
                              title: Text(
                                "About Us",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: darkPurple,
                                ),
                              ),
                            ),
                            // Share
                            ListTile(
                              leading: Icon(
                                Icons.share,
                                color: darkPurple,
                              ),
                              title: Text(
                                "Share",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: darkPurple,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: primaryColorLight, blurRadius: 20),
          ],
        ),
        child: CupertinoTabBar(
          height: height * 0.088,
          backgroundColor: Colors.white,
          iconSize: 40,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                color: _page == 0 ? primaryColor : Colors.grey,
                shadows: [
                  Shadow(
                      color: primaryColorLight, blurRadius: _page == 0 ? 20 : 0)
                ],
              ),
              label: '',
              backgroundColor: Colors.grey,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.health_and_safety_rounded,
                color: _page == 1 ? primaryColor : Colors.grey,
                shadows: [
                  Shadow(
                      color: primaryColorLight, blurRadius: _page == 1 ? 20 : 0)
                ],
              ),
              label: '',
              backgroundColor: Colors.grey,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_rounded,
                color: _page == 2 ? primaryColor : Colors.grey,
                shadows: [
                  Shadow(
                      color: primaryColorLight, blurRadius: _page == 2 ? 20 : 0)
                ],
              ),
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
