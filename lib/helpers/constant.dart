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
