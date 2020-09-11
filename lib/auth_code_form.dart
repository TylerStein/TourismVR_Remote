import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@immutable
class AuthCodeForm extends StatefulWidget {
  final Function(String) onSubmit;

  AuthCodeForm({
    @required this.onSubmit,
  }) {
    //
  }

  @override
  AuthCodeFormState createState() => AuthCodeFormState();
}

class AuthCodeFormState extends State<AuthCodeForm> {
  TextEditingController authCodeController;

  AuthCodeFormState() {
    //
  }

  void _submit() {
    if (authCodeController.text?.isNotEmpty == true) {
      widget.onSubmit(authCodeController.text);
    }
  }

  @override
  void initState() {
    authCodeController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Enter the code displayed on your connected VR device"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 48),
            child: TextField(
              controller: authCodeController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
              ),
              textAlign: TextAlign.center,
              onSubmitted: (String value) {
                if (value != null && value.isNotEmpty) {
                  Focus.of(context).unfocus();
                  _submit();
                }
              },
            ),
          ),
          RaisedButton(
            child: Text('Submit'),
            onPressed: authCodeController.text != null ? () {
                _submit();
            } : null,
          )
        ],
      ),
    );
  }
}