import 'package:flutter/material.dart';

class SlidingCardController {
  ///This is to slide the card down
  Function expandCard;

  ///This is to slide the card up
  Function collapseCard;

  ///Whether the card is collapsed or not
  bool isCardSeparated;
}

///THIS IS A WORK IN PROGRESS
class SlidingCard extends StatefulWidget {
  final SlidingCardController controller;

  ///Widget to be displayed on the front;
  ///note that It's parent widget is a container
  final Widget frontCardWidget;

  ///Widget to be displayed on the back
  ///It's hight shhall be <= height of the front card;
  ///Note that it's parent widget is a container
  final Widget backCardWidget;

  ///Height of the front card
  final double visibleCardHeight;

  ///height of the back card
  final double hiddenCardHeight;

  ///width of the overal card
  final double slidingCardWidth;

  ///Border radious of the card
  final double slimeCardBorderRadius;

  ///The elevation of the SlimeCard
  final double slimeCardElevation;

  ///The time it will take for the card to slide down
  final Duration slidingAnimmationDuration;

  ///The curve of the slidingAnimation when expanding
  ///it is preferable to leave it to it's default value
  final Curve slidingAnimmationForwardCurve;

  ///The curve of the slidingAnimation when reserving
  ///it is preferable to leave it to it's default value
  final Curve slidingAnimationReverseCurve;

  ///This gives a good visual effect
  ///Leave this to true for a more realistic
  final bool animateOpacity;

  /// this will enable coloring of the cards
  /// use this to make sure your widgets are aligned properly
  final bool showColors;

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
      this.showColors = true,
      this.slidingAnimmationForwardCurve = Curves.elasticOut,
      this.slidingAnimationReverseCurve = Curves.elasticOut,
      this.slidingAnimmationDuration = const Duration(milliseconds: 800),
      @required this.controller,
      @required this.backCardWidget,
      @required this.frontCardWidget})
      : assert(hiddenCardHeight <= (visibleCardHeight * 90) / 100,
            'The height of the hidden card shall be less than or equal to 90% of the frontCard Widget ');

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
    } else {
      print(
          'Sliding Card: The controller is null, the sliding card action will not be triggered');
    }
    animationCurve = widget.slidingAnimmationForwardCurve;
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
    animationCurve = widget.slidingAnimmationForwardCurve;
    animationValue = separatedValue.animate(animationController);
    animationController.forward();
    isSeparated = true;
    widget.controller.isCardSeparated = true;
  }

  ///use this to colapse the card
  void collapseCard() {
    animationCurve = widget.slidingAnimationReverseCurve;
    animationController.reverse();
    isSeparated = false;
    widget.controller.isCardSeparated = false;
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
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
                        color: widget.showColors ? Colors.yellow : null,
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
                  color: widget.showColors ? Colors.green : null,
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
