import 'package:TourismVR_Remote/models/video_model.dart';
import 'package:TourismVR_Remote/providers/library_provider.dart';
import 'package:TourismVR_Remote/widgets/media_card.dart';
import 'package:TourismVR_Remote/widgets/search_fab.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  final LibraryAPIProvider libraryAPIProvider;
  final ValueNotifier<int> pageChangeNotifier;

  LibraryPage({
    @required this.pageChangeNotifier,
    @required this.libraryAPIProvider,
  });

  @override
  LibraryPageState createState() => LibraryPageState();
}

class LibraryPageState extends State<LibraryPage> {
  List<VideoModel> filteredEntries;
  String searchValue;

  LibraryPageState();

  @override
  void initState() {
    filteredEntries = widget.libraryAPIProvider.videos ?? [];
    if (widget.libraryAPIProvider.videos.isEmpty) {
      widget.libraryAPIProvider.loadVideos()
        .then((value) => {
          setState(() {
            filteredEntries = widget.libraryAPIProvider.videos;
          })
        })
        .catchError((error) => print(error));
    }
    super.initState();
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
            filteredEntries = widget.libraryAPIProvider.videos.where(
              (entry) => entry.name.toLowerCase().contains(searchValue.toLowerCase())
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
          title: filteredEntries[index].name,
          subtitle: filteredEntries[index].location,
          onTap: () {
            print('onTap ${filteredEntries[index].name}');
          },
        ),
        growable: false
      ),
    );
  }
}