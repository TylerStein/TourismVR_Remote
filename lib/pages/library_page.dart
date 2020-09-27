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
  List<VideoModel> filteredEntries = [];
  String searchValue;

  LibraryPageState();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.libraryAPIProvider.reload()
        .then((value) {
          reloadAndFilter();
        });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Visibility(
        //   visible: widget.libraryAPIProvider.isLoading,
        //   child: CircularProgressIndicator(),
        // ),
        // Visibility(
        //   visible: widget.libraryAPIProvider.isLoading,
        //   child: Container(color: Colors.black38),
        // ),
        RefreshIndicator(
          onRefresh: reloadAndFilter,
          child: widget.libraryAPIProvider.lastResponse?.error != null
            ? buildErrorDisplay()
            : widget.libraryAPIProvider.isLoading == false
              ? buildLibraryList()
              : buildMockLibraryList(),
        ),
        Visibility(
          visible: widget.libraryAPIProvider.lastResponse?.value != null,
          child: Positioned(
            bottom: 16,
            right: 16,
            child: buildSearch(),
          ),
        ),
      ],
    );
  }

  Widget buildDisplay() {
    return Stack(
      children: [
        buildLibraryList(),
      ],
    );
  }

  Widget buildErrorDisplay() {
    return ListView(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 48),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text('API Error'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text('Pull down to refresh'),
            ),
          ],
        )
      ],
    );
  }

  Widget buildSearch() {
    return SearchFab(
      closeSearchNotifier: widget.pageChangeNotifier,
      onChange: (String value) {
        if (searchValue != value) {
          filterEntries(value);
        }
      },
    );
  }

  Future<void> reloadAndFilter([String search]) async {
    await widget.libraryAPIProvider.reload();
    filterEntries(search);
  }

  void filterEntries([String search]) {
    setState(() {
      if (search != null) {
        searchValue = search;
      }

      List<VideoModel> unfiltered = widget.libraryAPIProvider.lastResponse?.value ?? [];
      if (searchValue != null) {
        filteredEntries = unfiltered.where((entry) => entry.name.toLowerCase().contains(searchValue.toLowerCase())).toList();
      } else {
        filteredEntries = unfiltered;
      }
    });
  }

  Widget buildMockLibraryList() {
    return ListView(
      itemExtent: 128,
      children: List.generate(
        12,
        (index) => MediaCard.blank(),
        growable: false
      ),
    );
  }

  Widget buildLibraryList() {
    return ListView(
      physics: AlwaysScrollableScrollPhysics(),
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