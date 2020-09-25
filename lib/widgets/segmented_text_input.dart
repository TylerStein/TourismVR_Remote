import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SegmentedTextInput extends StatefulWidget {
  final int segments;
  final WhitelistingTextInputFormatter formatter;

  final Function(String) onSubmit;

  SegmentedTextInput({
    Key key,
    @required this.segments,
    @required this.formatter,
    @required this.onSubmit,
  }) : super(key: key);

  @override
  SegmentedTextInputState createState() => SegmentedTextInputState();
}

class SegmentedTextInputState extends State<SegmentedTextInput> {
  List<TextEditingController> textControllers;
  List<Function> textEditCallbacks;
  
  @override
  void initState() {
    textControllers = new List.generate(widget.segments, (index) => new TextEditingController());
    textControllers.forEach((ctl) => ctl.addListener(onControllerUpdate));
    super.initState();
  }

  @override
  void dispose() {
    textControllers.forEach((ctl) => ctl.removeListener(onControllerUpdate));
    super.dispose();
  }

  void onControllerUpdate() {
    String value = this.textControllers.map((ctl) => ctl.text).reduce((a, b) => a + b);
    if (value.length == widget.segments) {
      widget.onSubmit(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(),
        ],
      ),
    );
  }
}