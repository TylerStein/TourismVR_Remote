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
    return ChangeNotifierProvider<AuthAPIProvider>(
      create: (BuildContext context) => AuthAPIProvider(),
      child: Consumer<AuthAPIProvider>(
        builder: (BuildContext context, AuthAPIProvider authAPIProvider, Widget child) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (BuildContext context) => LibraryAPIProvider(authAPIProvider: authAPIProvider)),
            ChangeNotifierProvider(create: (BuildContext context) => ControlAPIProvider(authAPIProvider: authAPIProvider)),
          ],
          child: buildNavScaffold(authAPIProvider),
        ),
      ),
    );
  }

  Widget buildNavScaffold(AuthAPIProvider authAPIProvider) {
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
          builder: (BuildContext context) => Consumer<ControlAPIProvider>(
            builder: (BuildContext context, ControlAPIProvider controlAPIProvder, Widget child) => SessionPage(
              controlAPIProvider: controlAPIProvder,
              authAPIProvider: authAPIProvider,
              pageChangeNotifier: pageChangeNotifier,
            ),
          ),
        ),
        NavScaffoldItem(
          title: 'Library',
          icon: const Icon(Icons.video_library),
          builder: (BuildContext context) => Consumer2<LibraryAPIProvider, ControlAPIProvider>(
            builder: (BuildContext context, LibraryAPIProvider libraryAPIProvider, ControlAPIProvider controlAPIProvider, Widget child) =>
              LibraryPage(
                pageChangeNotifier: pageChangeNotifier,
                libraryAPIProvider: libraryAPIProvider,
                controlAPIProvider: controlAPIProvider,
              ),
          ),
        ),
      ],
    );
  }
}