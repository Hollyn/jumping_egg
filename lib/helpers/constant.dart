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

const double kSpriteSize = 128.0;
const kStartHealth = 6;
const kStartScore = 0;
const kStartRelativePosition = 0;
const kTopRelativePosition = 2;
const kBoxScoreName = 'playerdata';
const kCharacterColor = Color(0xff8F563B);
const kCoinSize = 40.0;
const kEggSize = 96.0;
const kBgComponentWidth = 144.0;
const kBgComponentHeight = 80.0;
const kBgComponentMargin = 10.0;
const kTextMargin = 3.0;
Vector2 kGameResolution = Vector2(360.0, 640);
const kDefaultOverlayTitleStyle = TextStyle(
  fontSize: 24.0,
  backgroundColor: Colors.red,
);

BoxDecoration kDefaultOverlayBoxDecoration = BoxDecoration(
  border: Border.all(
    color: Colors.black,
    width: 8,
  ),
  borderRadius: BorderRadius.circular(12),
  color: Colors.blue,
);
