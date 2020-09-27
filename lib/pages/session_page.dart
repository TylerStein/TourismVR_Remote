import 'package:TourismVR_Remote/providers/auth_provider.dart';
import 'package:TourismVR_Remote/providers/control_provider.dart';
import 'package:code_input/code_input.dart';
import 'package:flutter/material.dart';

class SessionPage extends StatefulWidget {
  final AuthAPIProvider authAPIProvider;
  final ControlAPIProvider controlAPIProvider;
  final ValueNotifier<int> pageChangeNotifier;

  SessionPage({
    @required this.pageChangeNotifier,
    @required this.authAPIProvider,
    @required this.controlAPIProvider,
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
    if (widget.authAPIProvider.isAuthorized) {
      return buildPairedView();
    } else {
      return buildPairingView();
    }
  }

  Widget buildPairedView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text('Your session code is'),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(widget.authAPIProvider.token ?? ''),
        ),
      ],
    );
  }

  Widget buildPairingView() {
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
            widget.authAPIProvider.authenticate(value);
          },
        )
      ],
    );
  }
}