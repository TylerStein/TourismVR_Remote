import 'package:TourismVR_Remote/pages/library.dart';
import 'package:TourismVR_Remote/pages/session.dart';
import 'package:TourismVR_Remote/widgets/nav_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TourismVRHomePage extends StatelessWidget {
  ValueNotifier<int> pageChangeNotifier = new ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return NavScaffold(
      disconnect: () {
        print('disconnect');
      },
      initialPageIndex: 0,
      onPageChanged: (index) {
        pageChangeNotifier.value = index;
      },
      pages: [
        NavScaffoldItem(
          title: 'Session',
          icon: const Icon(Icons.play_arrow),
          child: SessionPage(
            pageChangeNotifier: pageChangeNotifier,
          ),
        ),
        NavScaffoldItem(
          title: 'Library',
          icon: const Icon(Icons.video_library),
          child: LibraryPage(
            pageChangeNotifier: pageChangeNotifier,
          ),
        ),
      ],
    );
  }
}

class HomeModel extends ChangeNotifier {
  int _currentPage;
  int get currentPage => _currentPage;

  void setPage(int index) {
    _currentPage = index;
    notifyListeners();
  }
}