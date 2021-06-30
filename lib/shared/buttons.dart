import 'package:flutter/material.dart';
import 'package:workampus/shared/styles.dart';
import './colors.dart';
import 'icons.dart';

FlatButton workampusFlatBtn(String text, onPressed) {
  return FlatButton(
    onPressed: onPressed,
    child: Text(text),
    textColor: white,
    color: primaryColor,
    disabledColor: grey,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  );
}

OutlineButton dulangOutlineBtn(String text, onPressed) {
  return OutlineButton(
    onPressed: onPressed,
    child: Text(text),
    textColor: primaryColor,
    highlightedBorderColor: highlightColor,
    borderSide: BorderSide(color: primaryColor),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  );
}

MaterialButton dulangMatButton(String text, onPressed) {
  return MaterialButton(
    onPressed: onPressed,
    color: Colors.black87,
    child: Text(text, style: whiteBoldText),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
  );
}

IconButton acceptButton(onPressed) {
  return IconButton(
    icon: Icon(Workampus.checkmark_cicle, size: 40.0, color: Colors.green),
    tooltip: 'Accept food request',
    onPressed: onPressed,
  );
}

IconButton waitingButton(onPressed) {
  return IconButton(
    icon: Icon(Workampus.clock, size: 40.0, color: Colors.green),
    tooltip: 'Waiting for accept',
    onPressed: onPressed,
  );
}

Container transparentButton(
    String text, onPressed, Color bordercolor, Color bgColor, double width,
    {Color textColor}) {
  return Container(
    height: 52.4,
    width: width,
    color: bgColor,
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: bordercolor, style: BorderStyle.solid, width: 2.0),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4.0)),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(text,
              style: TextStyle(
                  color: textColor != null ? textColor : bordercolor,
                  fontSize: 19.0,
                  fontWeight: FontWeight.w700)),
        ),
      ),
    ),
  );
}

/// A button that shows a busy indicator in place of title
class BusyButton extends StatefulWidget {
  final String title;
  final Function onPressed;
  final double height;
  final bool busy;
  final bool enabled;

  const BusyButton(
      {@required this.title,
      @required this.onPressed,
      this.height = 40.0,
      this.busy = false,
      this.enabled = true});

  @override
  _BusyButtonState createState() => _BusyButtonState();
}

class _BusyButtonState extends State<BusyButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        shadowColor: Color.fromRGBO(57, 57, 57, 5),
        color: themeColor,
        elevation: 7.0,
        child: InkWell(
          onTap: widget.onPressed,
          child: Center(
            child: !widget.busy
                ? Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  )
                : SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
