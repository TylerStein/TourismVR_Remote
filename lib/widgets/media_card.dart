import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MediaCard extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String subtitle;
  final EdgeInsets padding;

  MediaCard({
    Key key,
    this.onTap,
    @required this.title,
    @required this.subtitle,
    this.padding = const EdgeInsets.all(8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          padding: padding,
          child: Row(
            children: [
              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  color: Colors.red[300],
                  alignment: Alignment.center,
                  child: Icon(Icons.play_arrow, color: Colors.white,),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        child: Text(title, style: Theme.of(context).textTheme.headline6,),
                      ),
                      Flexible(
                        child: Text(subtitle, style: Theme.of(context).textTheme.subtitle1,),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}