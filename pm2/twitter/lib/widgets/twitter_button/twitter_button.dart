import 'package:flutter/material.dart';

class TwitterButton extends StatelessWidget {
  final Color fillColor;
  final Color borderColor;
  final String text;
  final Color textColor;
  final Function onTap;
  final IconData icon;
  final Color iconColor;

  TwitterButton({
    @required this.fillColor,
    this.borderColor,
    @required this.text,
    @required this.textColor,
    @required this.onTap,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
        side: BorderSide(
          color: onTap != null ? (borderColor ?? fillColor) : Colors.grey,
          width: 1,
        ),
      ),
      shadowColor: Colors.grey,
      elevation: 3,
      color: onTap != null ? fillColor : Colors.grey,
      child: InkWell(
        splashColor: onTap != null ? Colors.blueGrey.withOpacity(0.3) : null,
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
        onTap: () => onTap(),
        child: Container(
          height: 46.0,
          alignment: FractionalOffset.center,
          child: Padding(
            padding: EdgeInsets.all(11.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: icon == null
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      icon != null
                          ? Icon(
                              icon,
                              color: iconColor,
                            )
                          : Container(),
                      icon != null
                          ? SizedBox(
                              width: 10.0,
                            )
                          : Container(),
                      Text(
                        text,
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
