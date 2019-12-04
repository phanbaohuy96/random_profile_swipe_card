import 'package:flutter/material.dart';
import 'package:random_profile_swipe_card/ui/screen/profile_card/card_section.dart';

class ProfilCardPage extends StatefulWidget {
  final double appbarHeigh;

  const ProfilCardPage({Key key, this.appbarHeigh}) : super(key: key);

  @override
  _ProfilCardPageState createState() => _ProfilCardPageState();
}

class _ProfilCardPageState extends State<ProfilCardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: widget.appbarHeigh ?? 56, bottom: 80),
      child: CardSection(context),
    );
  }
}