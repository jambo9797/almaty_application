import 'package:almaty_app/ui/map_page/map_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:almaty_app/ui/user_screen.dart';
import 'package:almaty_app/ui/task_page/task_screen.dart';
import 'package:almaty_app/ui/login_page/login_screen.dart';
import 'package:almaty_app/ui/question_form/question_form_screen.dart';

import '../report_page.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  static int currentIndex = 0;

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: MapScreen(),
          icon: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(
              'assets/svg/mapSvg.svg',
              color: currentIndex == 0 ? Colors.white : Color(0xff90C5F2),
              width: 20,
              height: 17,
            ),
          ),
          title: Text("Карта"),
        ),
        TabNavigationItem(
          page: TaskScreen(),
          icon: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(
              'assets/svg/taskSvg.svg',
              color: currentIndex == 1 ? Colors.white : Color(0xff90C5F2),
              width: 16,
              height: 20,
            ),
          ),
          title: Text("Задание"),
        ),
        TabNavigationItem(
          page: QuestionFormPage(),
          icon: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(
              'assets/svg/questionFormSvg.svg',
              color: currentIndex == 2 ? Colors.white : Color(0xff90C5F2),
              width: 18,
              height: 20,
            ),
          ),
          title: Text("Анкета"),
        ),
        TabNavigationItem(
          page: ReportPage(),
          icon: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(
              'assets/svg/message.svg',
              color: currentIndex == 3 ? Colors.white : Color(0xff90C5F2),
              width: 20,
              height: 20,
            ),
          ),
          title: Text("Сообщить"),
        ),
        TabNavigationItem(
          page: UserScreen(),
          icon: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(
              'assets/svg/user.svg',
              color: currentIndex == 4 ? Colors.white : Color(0xff90C5F2),
              width: 20,
              height: 20,
            ),
          ),
          title: Text("Профиль"),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          for (final tabItem in items) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Color(0xff90C5F2),
        selectedLabelStyle: TextStyle(fontSize: 12, color: Colors.white),
        unselectedLabelStyle: TextStyle(fontSize: 12, color: Color(0xff90C5F2)),
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xff2C98F0),
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedIconTheme: IconThemeData(color: Colors.red),
        currentIndex: currentIndex,
        onTap: (int index) => setState(() => currentIndex = index),
        items: [
          for (final tabItem in items)
            BottomNavigationBarItem(
              icon: tabItem.icon,
              title: tabItem.title,
            )
        ],
      ),
    );
  }
}

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Container icon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });
}
