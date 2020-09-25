import 'package:TourismVR_Remote/widgets/search_fab.dart';
import 'package:code_input/code_input.dart';
import 'package:flutter/material.dart';

class SessionPage extends StatefulWidget {
  final ValueNotifier<int> pageChangeNotifier;

  SessionPage({
    @required this.pageChangeNotifier,
  });

  @override
  SessionPageState createState() => SessionPageState();
}

class SessionPageState extends State<SessionPage> {
  FocusNode _focus;

  @override
  void initState() {
    _focus = new FocusNode();
    widget.pageChangeNotifier?.addListener(closeEntry);
    super.initState();
  }

  @override
  void dispose() {
    widget.pageChangeNotifier?.removeListener(closeEntry);
    super.dispose();
  }

  void closeEntry() {
    setState(() {
      _focus?.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text('Enter Pairing Code'),
        ),
        CodeInput(
          length: 6,
          focusNode: _focus,
          keyboardType: TextInputType.text,
          builder: CodeInputBuilders.darkRectangle(),
          onFilled: (value) {
            print('filled $value');
          },
        )
      ],
    );
  }
}