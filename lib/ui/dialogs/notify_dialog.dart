import 'package:flutter/material.dart';

class NotifyDialog extends StatelessWidget {
  final Text  titlePopup;
  final Icon  iconPopup;
  final Text  content;
  final double height;
  final double width;
  final List<Widget> buttonActions;

  NotifyDialog({
    Key key,
    this.titlePopup,
    this.iconPopup,
    this.content,
    this.width,
    this.height,
    this.buttonActions
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded( 
                flex: 4,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    Icons.wifi,
                    color: Colors.red,
                    size: 150,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Expanded( 
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      titlePopup,
                      content,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: buttonActions,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}