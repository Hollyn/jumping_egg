import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

TextStyle kDefaultTextStyle = TextStyle(
  fontFamily: 'GamePlay',
);

final kDefaultTextGamePlayOverlayStyle = TextPaint(
  style: const TextStyle(
    fontSize: 18,
    fontFamily: 'GamePlay',
    // color: BasicPalette.white.color,

    color: Color(0xff8F563B),
  ),
);

const double kPlayerGravity = 800.0;
const double kPlayerBoost = -600.0;
const double kSpriteSize = 128.0;
const double kSpeedParallax = 150.0;
const double kSpeedY = 300.0;
const double kSpeedBasket = 75.0;
const kStartHealth = 6;
const kStartScore = 0;
const kStartRelativePosition = 0;
const kTopRelativePosition = 2;
const kBoxScoreName = 'playerdata';
const kCharacterColor = Color(0xff8F563B);
const kMainTitleColor = Color(0xff663931);
const kCardBackgroundColor = Color(0xffffecd3);
const kCoinSize = 40.0;
const kEggSize = 96.0;
const kBgComponentWidth = 144.0;
const kBgComponentHeight = 80.0;
const kBgComponentMargin = 0.0;
const kTextMargin = 3.0;
Vector2 kGameResolution = Vector2(360.0, 640);
const kDefaultOverlayTitleStyle = TextStyle(
  fontSize: 24.0,
  color: kMainTitleColor,
);
const kDefaultDialongButtonStyle = TextStyle(
  color: kCharacterColor,
);
const kGameTitleStyle = TextStyle(
  fontSize: 48.0,
  color: Color(0xff663931),
);

const kGameSubTitleStyle = TextStyle(
  fontSize: 18.0,
  color: kCharacterColor,
);
const kDialogSubTitleStyle = TextStyle(
  fontSize: 14.0,
  color: kCharacterColor,
);

const kInstructionTextStyle = TextStyle(
  fontSize: 24.0,
  color: kCharacterColor,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(1.0, 1.0),
      // blurRadius: 10.0,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
    // Shadow(
    //   offset: Offset(10.0, 10.0),
    //   blurRadius: 8.0,
    //   color: Color.fromARGB(125, 0, 0, 255),
    // ),
  ],
);

BoxDecoration kDefaultOverlayBoxDecoration = BoxDecoration(
  border: Border.all(
    color: Color(0xff663931),
    width: 8,
  ),
  borderRadius: BorderRadius.circular(12),
  color: Color(0xccfde2be),
);
BoxDecoration kListItemBoxDecoration = BoxDecoration(
  border: Border.all(
    color: Color(0xff663931),
    width: 4,
  ),
  borderRadius: BorderRadius.circular(6),
  color: Color(0xfffde2be),
);
const kMultiPlayerInstruction =
    'If you want to play with your friend, you can choose to be the host and you friend to be the guest or vice versa.';
const kSelectGuestText = 'Select a guest: ';
const kTryAgainText = 'Retry if you cannot see your friend';
Vector2 kBasketContainerSize = Vector2(250.0, 150.0);
