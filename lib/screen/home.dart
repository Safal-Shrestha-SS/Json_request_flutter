import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:intern_challenges/screen/post_screen.dart';
import 'package:intern_challenges/screen/todos_screen.dart';
import 'package:intern_challenges/screen/users_screen.dart';
import 'package:intern_challenges/screen_body/topbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController iControll = PageController(initialPage: 0);
  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  ShapeBorder? bottomBarShape = const BeveledRectangleBorder(
      borderRadius: BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  ));
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.pinned;
  EdgeInsets padding = const EdgeInsets.all(0);
  int _selectedItemPosition = 0;
  SnakeShape snakeShape = SnakeShape.rectangle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Colors.black;
  // Gradient selectedGradient =
  //     const LinearGradient(colors: [Colors.red, Colors.amber]);

  // Color unselectedColor = Colors.blueGrey;
  // Gradient unselectedGradient =
  // const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  Color? containerColor;
  // List<Color> containerColors = [
  //   const Color(0xFFFDE1D7),
  //   const Color(0xFFE4EDF5),
  //   const Color(0xFFE7EEED),
  //   const Color(0xFFF4E4CE),
  // ];
  void _onPageChanged(int page) {
    switch (page) {
      case 0:
        setState(() {
          snakeBarStyle = SnakeBarBehaviour.pinned;
          snakeShape = SnakeShape.rectangle;
          padding = EdgeInsets.zero;
          bottomBarShape = BeveledRectangleBorder(borderRadius: _borderRadius);
          showSelectedLabels = true;
          showUnselectedLabels = true;
        });
        break;
      case 1:
        setState(() {
          snakeBarStyle = SnakeBarBehaviour.pinned;
          snakeShape = SnakeShape.rectangle;
          padding = EdgeInsets.zero;
          bottomBarShape = BeveledRectangleBorder(borderRadius: _borderRadius);
          showSelectedLabels = true;
          showUnselectedLabels = true;
        });
        break;

      case 2:
        setState(() {
          snakeBarStyle = SnakeBarBehaviour.pinned;
          snakeShape = SnakeShape.rectangle;
          padding = EdgeInsets.zero;
          bottomBarShape = BeveledRectangleBorder(borderRadius: _borderRadius);
          showSelectedLabels = true;
          showUnselectedLabels = true;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      appBar: const TopBar(),
      body: PageView(
        controller: iControll,
        scrollDirection: Axis.horizontal,
        onPageChanged: _onPageChanged,
        children: const <Widget>[
          PostScreen(),
          UserScreen(),
          TodosScreen(),
        ],
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        height: 40,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: Colors.blueGrey,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() {
          _selectedItemPosition = index;
          iControll.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear);
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'tickets'),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle), label: 'calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.check_box), label: 'home'),
        ],
        // selectedLabelStyle: const TextStyle(fontSize: 14),
        // unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }
}
