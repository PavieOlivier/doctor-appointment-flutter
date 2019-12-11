import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../sizeConfig.dart';

class AppointmentFrontCard extends StatefulWidget {
  final String patienName;
  final String patienSurname;
  final Function onInfoTapped;
  final Function onRedCloseButtonTapped;
  final Function onAccep;
  final Function onDecline;
  final String appointmentDate;
  final String appointmentTime;
  final String imgLink;
  const AppointmentFrontCard({
    Key key,
    @required this.imgLink,
    @required this.onAccep,
    @required this.onDecline,
    @required this.patienName,
    @required this.onInfoTapped,
    @required this.patienSurname,
    @required this.appointmentDate,
    @required this.appointmentTime,
    @required this.onRedCloseButtonTapped
  }) : super(key: key);
  @override
  _AppointmentFrontCardState createState() => _AppointmentFrontCardState();
}

class _AppointmentFrontCardState extends State<AppointmentFrontCard> {
  bool isinfoPressed = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff2C8BFF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.only(top: 0, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Appointment Request',
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                                  color: Colors.white),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.more_vert,color: Colors.white70,
                            size: SizeConfig.safeBlockHorizontal * 7,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            size: SizeConfig.safeBlockHorizontal * 5,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.appointmentDate + ', ' + widget.appointmentTime,
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 4.7,
                                color: Colors.white70),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          
        ),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: SizeConfig.safeBlockHorizontal * 90,
                      //color: Colors.pink,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: SizeConfig.safeBlockHorizontal * 15,
                              height: SizeConfig.safeBlockVertical * 8,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: CachedNetworkImageProvider(widget.imgLink),fit: BoxFit.fill),
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.patienSurname,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4.7,
                                      color: Colors.black87),
                                ),
                                Text(
                                  widget.patienName,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4.7,
                                      color: Colors.black87),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: (){
                                if(isinfoPressed == true)
                                {
                                  isinfoPressed = false;
                                  widget.onRedCloseButtonTapped();
                                  setState(() {});
                                }
                                else{
                                  isinfoPressed = true;
                                  widget.onInfoTapped();
                                  setState(() {});
                                }
                              },
                              child: Container(
                                //color: Colors.red,
                                child: isinfoPressed?Transform.rotate(
                                  angle: 0.7777,
                                  child: Icon(
                                  Icons.add_circle,
                                  size: SizeConfig.safeBlockHorizontal * 9,
                                  color: Colors.redAccent,
                                ),
                                )
                                
                                
                                :Icon(
                                  Icons.info,
                                  size: SizeConfig.safeBlockHorizontal * 9,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        width: SizeConfig.safeBlockHorizontal * 90,
                        //color: Colors.indigo,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: SizedBox(
                                height: SizeConfig.safeBlockVertical * 6,
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
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 5.5,
                                    ),
                                  ),
                                  onPressed: widget.onAccep,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: SizeConfig.safeBlockVertical * 6,
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
                                      color: Color(0xff878FA6) ,
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 5,
                                    ),
                                  ),
                                  onPressed: widget.onDecline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

