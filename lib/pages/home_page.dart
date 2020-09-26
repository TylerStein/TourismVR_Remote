import 'package:TourismVR_Remote/pages/library_page.dart';
import 'package:TourismVR_Remote/pages/session_page.dart';
import 'package:TourismVR_Remote/providers/auth_provider.dart';
import 'package:TourismVR_Remote/providers/control_provider.dart';
import 'package:TourismVR_Remote/providers/library_provider.dart';
import 'package:TourismVR_Remote/widgets/nav_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TourismVRHomePage extends StatelessWidget {
  final ValueNotifier<int> pageChangeNotifier = new ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LibraryAPIProvider(authAPIProvider: null),
      child: NavScaffold(
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
            builder: (BuildContext context) => SessionPage(
              pageChangeNotifier: pageChangeNotifier,
            ),
          ),
          NavScaffoldItem(
            title: 'Library',
            icon: const Icon(Icons.video_library),
            builder: (BuildContext context) => Consumer<LibraryAPIProvider>(
              builder: (BuildContext context, LibraryAPIProvider libraryAPIProvider, Widget child) =>
                LibraryPage(
                  pageChangeNotifier: pageChangeNotifier,
                  libraryAPIProvider: libraryAPIProvider,
                ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget buildProviders({
  //   @required Widget child
  // }) {
  //   return ChangeNotifierProvider(
  //     create: (context) => AuthAPIProvider(),
  //     child: Consumer<AuthAPIProvider>(
  //       builder: (BuildContext context, AuthAPIProvider authAPIProvider, Widget child) =>
  //         MultiProvider(
  //           providers: [
  //             ChangeNotifierProvider<LibraryAPIProvider>(create: (context) => LibraryAPIProvider(authAPIProvider: authAPIProvider)),
  //             ChangeNotifierProvider<ControlAPIProvider>(create: (context) => ControlAPIProvider(authAPIProvider: authAPIProvider)),
  //           ],
  //           child: child,
  //         ),
  //     ),
  //   );
  // }
}