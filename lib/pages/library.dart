import 'package:TourismVR_Remote/widgets/media_card.dart';
import 'package:TourismVR_Remote/widgets/search_fab.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  final ValueNotifier<int> pageChangeNotifier;
  final List<String> entries = const [
    'A1',
    'A2',
    'A3',
    'B1',
    'B2',
    'B3',
    'C1',
    'C2',
    'C3',
  ];

  LibraryPage({
    @required this.pageChangeNotifier,
  });

  @override
  LibraryPageState createState() => LibraryPageState(initialEntries: entries);
}

class LibraryPageState extends State<LibraryPage> {
  List<String> filteredEntries;
  String searchValue;

  LibraryPageState({
    List<String> initialEntries = const [],
  }) {
    filteredEntries = List.from(initialEntries);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildLibraryList(),
        Positioned(
          bottom: 16,
          right: 16,
          child: buildSearch(),
        ),
      ],
    );
  }

  Widget buildSearch() {
    return SearchFab(
      closeSearchNotifier: widget.pageChangeNotifier,
      onChange: (String value) {
        if (searchValue != value) {
          setState(() {
            searchValue = value;
            filteredEntries = widget.entries.where(
              (entry) => entry.toLowerCase().contains(searchValue.toLowerCase())
            ).toList();
          });
        }
      },
    );
  }

  Widget buildLibraryList() {
    return ListView(
      itemExtent: 128,
      children: List.generate(
        filteredEntries.length,
        (index) => MediaCard(
          title: filteredEntries[index],
          subtitle: 'Subtitle Here',
          onTap: () {
            print('onTap $index');
          },
        ),
        growable: false
      ),
    );
  }
}