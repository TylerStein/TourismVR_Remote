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

  factory MediaCard.blank() => MediaCard(
    title: null,
    subtitle: null,
  );

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
                  color: title != null ? Colors.red[300] : Colors.grey[400],
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
                        child: title != null
                          ? Text(title, style: Theme.of(context).textTheme.headline6,)
                          : Container(color: Colors.grey[400], height: 18,),
                      ),
                      Flexible(
                        child: subtitle != null
                          ? Text(subtitle ?? '', style: Theme.of(context).textTheme.subtitle1,)
                          : Container(color: Colors.grey[400], height: 16, margin: const EdgeInsets.only(top: 8)),
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