import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timer/net/data_net.dart';
import 'page/study_page.dart';

void main() => runApp(App());

ThemeData themeData = ThemeData(
  primarySwatch: Colors.blue,
);

AnimationController controller;
Animation<double> animation;
Animation<double> alpha;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Data.init();
    return MaterialApp(
      title: 'Timer',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.easeOut);
    alpha = new Tween(begin: 1.0, end: 0.0).animate(animation); // 动画
    controller.forward();
    alpha.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      themeData = ThemeData(
          primarySwatch: Colors.blue,
          brightness: MediaQuery.of(context).platformBrightness);
    });

    List<Widget> _widgetOptions = <Widget>[
      studyPage(context),
      Column(
        children: <Widget>[
          FlatButton(
            child: Text('Fire'),
            onPressed: () {
              Data.set(context, 'itt', '你成功收到这条信息了哈哈哈哈哈哈哈哈哈哈！！！');
            },
          ),
          FlatButton(
            child: Text('Get'),
            onPressed: () {
              showDialog(
                context: context,
                child: AlertDialog(
                  title: Text('it:'),
                  content: Text(
                    Data.get(context, 'itt')['value'],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      Text(
        'Index 2: School',
        style: optionStyle,
      ),
    ];

    return Theme(
      data: themeData,
      child: Stack(
        children: <Widget>[
          Scaffold(
            body: _widgetOptions.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('首页'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.access_time),
                  title: Text('学习数据'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  title: Text('我'),
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped,
            ),
          ),
          Visibility(
            visible: alpha.value >= 0.01,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: alpha.value * 50, sigmaY: alpha.value * 50),
              child: Container(
                color: Theme.of(context)
                    .backgroundColor
                    .withAlpha((255 * alpha.value).toInt()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
