import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchFab extends StatefulWidget {
  final ValueNotifier closeSearchNotifier;
  final Function(String) onChange;

  SearchFab({
    Key key,
    @required this.onChange,
    this.closeSearchNotifier,
  }) : super(key: key);

  @override
  SearchFabState createState() => SearchFabState();
}

class SearchFabState extends State<SearchFab> {
  TextEditingController _controller;
  FocusNode _focus;
  bool _showSearchBar;

  @override
  void initState() {
    _controller = new TextEditingController();
    _focus = new FocusNode();
    _controller.addListener(onChange);
    _showSearchBar = false;
    widget.closeSearchNotifier?.addListener(closeSearch);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(onChange);
    widget.closeSearchNotifier?.removeListener(closeSearch);
    super.dispose();
  }

  void onChange() {
    widget.onChange(_controller.text);
  }

  void closeSearch() {
    setState(() {
      _focus?.unfocus();
      _showSearchBar = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        buildSearchBar(),
        buildSearchButton(),
      ],
    );
  }

  Widget buildSearchButton() {
    return MaterialButton(
      onPressed: () {
        setState(() {
          if (_showSearchBar == true) {
            _focus.unfocus();
            _showSearchBar = false;
          } else {
            _showSearchBar = true;
            _focus?.requestFocus();
          }

          _controller.clear();
        });
      },
      elevation: 4.0,
      child: Icon(Icons.search, color: Theme.of(context).primaryColor),
      shape: CircleBorder(),
      color: Theme.of(context).colorScheme.surface,
      minWidth: 58,
      height: 58,
    );
  }

  Widget buildSearchBar() {
    Size screenSize = MediaQuery.of(context).size;
    return  AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      width: _showSearchBar == true ? screenSize.width - 32: 58,
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(58),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: const [
          const BoxShadow(color: Colors.black26, offset: const Offset(0.32, 0.42), blurRadius: 0.64),
        ]
      ),
      padding: EdgeInsets.fromLTRB(32, 8, 74, 8),
      alignment: Alignment.centerLeft,
      child: Visibility(
        visible: _showSearchBar == true,
        child: TextField(
          controller: _controller,
          focusNode: _focus,
          style: TextStyle(
            fontSize: 24,
            height: 1,
            color: Theme.of(context).colorScheme.onSurface,
          )
        )
      ),
    );
  }
}