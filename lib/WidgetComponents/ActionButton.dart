import 'package:doctor_companion/sizeConfig.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Function onAcceptPressed, onDecinePressed;
  const ActionButton({
    Key key,
    @required this.onAcceptPressed,
    @required this.onDecinePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22.0, right: 22, bottom: 8),
      child: Container(
        height: SizeConfig.safeBlockVertical * 10,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: SizedBox(
                height: SizeConfig.safeBlockVertical * 6.6,
                child: RaisedButton(
                  disabledElevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                  hoverElevation: 0,
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text(
                    'accept',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 5.5,
                    ),
                  ),
                  onPressed: onAcceptPressed,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: SizeConfig.safeBlockVertical * 6.6,
                child: RaisedButton(
                    disabledElevation: 0,
                    focusElevation: 0,
                    highlightElevation: 0,
                    hoverElevation: 0,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    textColor: Colors.black26,
                    color: Color(0xffEBEFFB),
                    child: Text(
                      'Decline',
                      style: TextStyle(
                        color: Color(0xff878FA6),
                        fontSize: SizeConfig.safeBlockHorizontal * 5,
                      ),
                    ),
                    onPressed: onDecinePressed),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
