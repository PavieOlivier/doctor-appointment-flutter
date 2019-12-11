import 'package:doctor_companion/Screens/appointmentDetailScreen/AppointmentDetailScreen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:doctor_companion/WidgetComponents/MiniAppointmentCard.dart';
import 'package:doctor_companion/WidgetComponents/AppointmentCard.dart';
import 'package:doctor_companion/WidgetComponents/SlidingCard.dart';
import 'package:doctor_companion/Logic/AppointmentManager.dart';
import 'package:page_transition/page_transition.dart';
import 'package:doctor_companion/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  bool isFirstTime = false;
  bool isLoading = true;
  List<Widget> topHeader;
  List<Widget> currentAppointment;
  List<Widget> midHeader;
  List<Widget> futureAppointment;
  List<Widget> finalList;

  @override
  void initState() {
    super.initState();
    topHeader = [];
    currentAppointment = [];
    midHeader = [];
    futureAppointment = [];
    finalList = [];

    AppointmentManager.generateAppointmentList();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (isFirstTime == false) {
      initiateList();
      isFirstTime = true;
    }
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color(0xffF3F6FF).withOpacity(0.134),
        elevation: 0,
        leading: Icon(
          Icons.menu,
          color: Colors.black54,
          size: SizeConfig.horizontalBloc * 8,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.sync,
              color: Colors.black54,
              size: SizeConfig.horizontalBloc * 8,
            ),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });

              topHeader..clear();
              currentAppointment..clear();
              midHeader..clear();
              futureAppointment.clear();
              finalList..clear();
              AppointmentManager.appointmentList.clear();
              //print(finalList.length);
              AppointmentManager.generateAppointmentList();
              initiateList();

              Future.delayed(Duration(milliseconds: 375), () {
                isLoading = false;
                setState(() {});
              });
            },
          )
        ],
      ),
      body: isLoading
          ? SizedBox()
          : Container(
              color: Color(0xffF3F6FF).withOpacity(0.134),
              child: AnimationLimiter(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: finalList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (isFirstTime == false) {
                      setState(() {});
                    }

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: -20,
                        child: FadeInAnimation(child: finalList[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  ///I use this function to make an aggragated list
  ///this list will then be feeded into the listview"builder
  ///IMPORTANT : Using this function i understood
  ///that gicving keys to child widget is important if you are
  ///panning on rebuilding them dynamically by adding custom parameters
  Future<bool> initiateList() async {
    //First we work on the header of the list
    topHeader.add(
      Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 9, top: 7),
        child: new Container(
          width: SizeConfig.safeBlockHorizontal * 90,
          height: SizeConfig.verticalBloc * 3,
          //color: Colors.pink,
          child: Text(
            'Welcome Back !',
            style: TextStyle(
                fontSize: SizeConfig.horizontalBloc * 6, color: Colors.black45),
          ),
        ),
      ),
    );
    topHeader.add(
      Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 15),
        child: new Container(
          width: SizeConfig.safeBlockHorizontal * 90,
          height: SizeConfig.verticalBloc * 5,
          //color: Colors.pink,
          child: Text(
            'Dr. @emilecode',
            style: TextStyle(
              fontSize: SizeConfig.horizontalBloc * 9.5,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );

    //now we create the card comming from the appointment manager
    for (var anElement in AppointmentManager.appointmentList) {
      if (anElement.isFuture == false) {
        ///not obliged to be this way , can directly be passed at time of initialization
        SlidingCardController aController = new SlidingCardController();
        print('adding big card');
        currentAppointment.add(Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AppointmentCard(
            onCardTapped: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: AppointmentDetailScreen(
                        appointmentData: anElement,
                      )));
            },
            key: Key(Random().nextInt(4000).toString()),
            slidingCardController: aController,
            appointmentData: anElement,
          ),
        )));
      } else {
        print('adding mini card');
        futureAppointment.add(Center(
            child: MiniAppointmentCard(
          onCardTapped: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: AppointmentDetailScreen(
                      appointmentData: anElement,
                    )));
          },
          appointmentData: anElement,
        )));
      }
    }
    midHeader.add(
      Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 9, left: 20),
        child: Container(
          width: SizeConfig.safeBlockHorizontal * 90,
          height: SizeConfig.verticalBloc * 3,
          //color: Colors.pink,
          child: Text(
            'Next appointments',
            style: TextStyle(
                fontSize: SizeConfig.horizontalBloc * 5, color: Colors.black45),
          ),
        ),
      ),
    );

    // We create the final list that will be passed to the
    //listView.builder
    finalList.addAll(topHeader);
    finalList.addAll(currentAppointment);
    finalList.addAll(midHeader);
    finalList.addAll(futureAppointment);
    if (isFirstTime == false) {
      isLoading = false;
      setState(() {});
    }
    setState(() {});
    return true;
  }
}
