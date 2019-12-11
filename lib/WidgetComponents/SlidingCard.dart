import 'package:flutter/material.dart';

class SlidingCardController {
  Function expandCard;
  Function collapseCard;
  bool isCardSeparated;
}
///THIS IS A WORK IN PROGRESS
class SlidingCard extends StatefulWidget {
  final SlidingCardController controller;
  final Widget frontCardWidget;
  final Widget backCardWidget;
  final double visibleCardHeight;
  final double hiddenCardHeight;
  final double slidingCardWidth;
  final double slimeCardBorderRadius;
  final double slimeCardElevation;
  final Duration slidingAnimmationDuration;
  final Curve slidingAnimmationCurve;
  final bool animateOpacity;

  ///The space between the 2 cards
  final double cardsGap;
  SlidingCard(
      {this.cardsGap = 12,
      this.slimeCardBorderRadius = 25,
      this.slidingCardWidth = 150,
      this.visibleCardHeight = 100,
      this.hiddenCardHeight = 100,
      this.animateOpacity = true,
      this.slimeCardElevation = 1,
      this.slidingAnimmationCurve = Curves.elasticOut,
      this.slidingAnimmationDuration = const Duration(milliseconds: 800),
      @required this.controller,
      @required this.backCardWidget,
      @required this.frontCardWidget})
      : assert(hiddenCardHeight <= visibleCardHeight, 'The height of the hidden card shall be either equal to the visible card height or less');
  @override
  _SlidingCardState createState() => _SlidingCardState();
}

class _SlidingCardState extends State<SlidingCard>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Tween<double> separatedValue;
  Animation animationValue;
  bool isSeparated = false;
  Curve animationCurve;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller.expandCard = expandCard;
      widget.controller.collapseCard = collapseCard;
      widget.controller.isCardSeparated = false;
      print('not null');
    }
    else
    {
      print('The controller is null');
    }
    animationCurve = widget.slidingAnimmationCurve;
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    separatedValue =
        Tween(begin: 0.0, end: widget.visibleCardHeight + widget.cardsGap);
    animationValue = separatedValue.animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });
    print(separatedValue.end);
  }
  
  ///use this to expand the card
  void expandCard() {
    //well we have to repeat this peace of code because it looks like in 
    //release mode , the app is too fast and the tween does not get registered fast
    separatedValue =
        Tween(begin: 0.0, end: widget.visibleCardHeight + widget.cardsGap);
    animationCurve = widget.slidingAnimmationCurve;
    animationValue = separatedValue.animate(animationController);
    animationController.forward();
    isSeparated = true;
    widget.controller.isCardSeparated = true;
    Future.delayed(Duration(milliseconds: 500),(){
      
    });
    
  }

  ///use this to colapse the card
  void collapseCard() {
    //animationCurve = Curves.linear;
    animationController.reverse();
    isSeparated = false;
    widget.controller.isCardSeparated = false;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      //color: Colors.limeAccent,
      curve: animationCurve,
      duration: widget.slidingAnimmationDuration,
      height: isSeparated
          ? (widget.visibleCardHeight + widget.hiddenCardHeight) +
              (MediaQuery.of(context).size.height / 100) * 1.5
          : widget.visibleCardHeight,
      // color: Colors.red,
      child: Stack(
        children: <Widget>[
          //this is the back card
          Transform.translate(
              offset: Offset(0, animationValue.value),
              child: AnimatedOpacity(
                duration: isSeparated
                    ? Duration(milliseconds: 400)
                    : Duration(milliseconds: 800),
                opacity: widget.animateOpacity ? isSeparated ? 1 : 0 : 1,
                child: Card(
                  elevation: widget.slimeCardElevation,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(widget.slimeCardBorderRadius)),
                  child: Container(
                    width: widget.slidingCardWidth,
                    height: widget.hiddenCardHeight,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(
                            widget.slimeCardBorderRadius)),
                    child: widget.backCardWidget,
                  ),
                ),
              )),

          //this is the front card
          Card(
            elevation: widget.slimeCardElevation,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(widget.slimeCardBorderRadius)),
            child: Container(
              width: widget.slidingCardWidth,
              height: widget.visibleCardHeight,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius:
                      BorderRadius.circular(widget.slimeCardBorderRadius)),
              child: widget.frontCardWidget,
            ),
          ),
        ],
      ),
    );
  }
}
