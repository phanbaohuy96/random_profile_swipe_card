import 'package:flutter/material.dart';
import 'package:random_profile_swipe_card/blocs/profile_card_page_bloc.dart';
import 'package:random_profile_swipe_card/ui/screen/profile_card/card_animations.dart';
import 'package:random_profile_swipe_card/ui/screen/profile_card/profile_card_item.dart';

Size backCardSize, contextSize;
double maxPerWidthBack = 0.9, maxPerHeightBack = 0.7;

class CardSection extends StatefulWidget {
  final ProfileCardBloc profileCardBloc;
  
  CardSection (BuildContext context, this.profileCardBloc)
  {
    contextSize = Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    backCardSize = Size(contextSize.width * maxPerWidthBack, contextSize.height * maxPerHeightBack);
  }

  @override  
  _CardSectionState createState() => _CardSectionState();
}

class _CardSectionState extends State<CardSection>  with SingleTickerProviderStateMixin{

  List<ProfileCardItem> cards = List();
  AnimationController _controller;

  @override
  void initState() {
    widget.profileCardBloc.users.forEach((user) {
      cards.add(ProfileCardItem(
        onCardPanUpdateCallBack: _onFontCardPanUpdate, 
        onReleaseCallback: changeCardOder, 
        onCardRollBackCallBack: _onCardRollBack,
        onComplete: _onCardReleaseCompleted,
        user: user,)
      );
    });

    _controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _controller.addListener(() => setState( () {} ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[ 
          backCard(),
          frontCard()
        ],
      ),
    );
  }

  _onFontCardPanUpdate(double perbackCard)
  {
    setState(() {
      backCardSize = Size(
        contextSize.width * (maxPerWidthBack + (1 - maxPerWidthBack) * perbackCard * 2), 
        contextSize.height * (maxPerHeightBack + (1 - maxPerHeightBack) * perbackCard / 2)
      );
    });
  }

  _onCardReleaseCompleted() {
    setState(() {
      cards.removeAt(0);
    });
  }

  _onCardRollBack()
  {
    _controller.stop();
    _controller.value = 0.0;
    _controller.forward(); 
  }

  frontCard()
  {
    if(widget.profileCardBloc.users.length == 0) {
      return Align(      
        child: Text("Nobody Else!")
      );
    } else {
      return Align(
        child: SizedBox.fromSize(
          child: cards[0],
        )
      );
    }
  }

  backCard()
  {
    if(widget.profileCardBloc.users.length < 1) {
      return SizedBox();
    } else {
      return Align(      
        child: SizedBox.fromSize(
          size: _controller.status == AnimationStatus.forward ? CardsAnimation.backCardRollBackResizeAnim(_controller, backCardSize, Size(contextSize.width * maxPerWidthBack, contextSize.height * maxPerHeightBack)).value : backCardSize,
          child: cards[1],
        )
      );
    }
  } 

  void changeCardOder() {
    widget.profileCardBloc.addUserMock().then((user) {
      if(user != null) {
        cards.add(ProfileCardItem(
          onCardPanUpdateCallBack: _onFontCardPanUpdate, 
          onReleaseCallback: changeCardOder, 
          onCardRollBackCallBack: _onCardRollBack,
          onComplete: _onCardReleaseCompleted,
          user: widget.profileCardBloc.users.last,
          )
        );   
        backCardSize = Size(contextSize.width * maxPerWidthBack, contextSize.height * maxPerHeightBack);
      }
    });
  }
}
