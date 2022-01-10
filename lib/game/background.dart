import 'dart:ui';
import 'package:flame/components.dart';

class Background extends Component {
  static final Paint _paint = Paint()..color = const Color(0xFF88D093);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.largest, _paint);
  }
}
