import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavScaffoldItem {
  final String title;
  final Widget icon;
  final Widget Function(BuildContext context) builder;

  NavScaffoldItem({
    @required this.title,
    @required this.icon,
    @required this.builder,
  });
}

class NavScaffold extends StatefulWidget {
  final List<NavScaffoldItem> pages;
  final int initialPageIndex;
  final Function() disconnect;
  final Function(int index) onPageChanged;

  NavScaffold({
    Key key,
    @required this.pages,
    @required this.disconnect,
    this.onPageChanged,
    this.initialPageIndex = 0,
  }) : super(key: key);

  @override
  NavScaffoldState createState() => NavScaffoldState();
}

class NavScaffoldState extends State<NavScaffold> {
  PageController _pageController;
  int _currentIndex;
  
  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initialPageIndex);
    _currentIndex = widget.initialPageIndex;
    super.initState();
  }

  NavScaffoldItem get _currentPage {
    return widget.pages[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: buildBottomNavigationBar(),
      body: buildPageView(context),
    );
  }

  Widget buildPageView(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
          if (widget.onPageChanged != null) {
            widget.onPageChanged(index); 
          }
        });
      },
      children: widget.pages.map((page) => page.builder(context)).toList(),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text(_currentPage.title),
      leading: IconButton(
        icon: Icon(Icons.phonelink_erase),
        onPressed: () {
          widget.disconnect();
        }
      ),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
      items: widget.pages.map((page) => BottomNavigationBarItem(
        icon: page.icon,
        title: Text(page.title),
      )).toList(),
    );
  }
}