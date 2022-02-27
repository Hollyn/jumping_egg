import 'package:flutter/cupertino.dart';
import 'package:jumping_egg/helpers/constant.dart';

class GuestListItemWidget extends StatelessWidget {
  const GuestListItemWidget({
    Key? key,
    required this.title,
    this.onPress,
  }) : super(key: key);

  final String title;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Center(
        child: Container(
          width: 100,
          height: 50,
          margin: const EdgeInsets.all(10.0),
          decoration: kListItemBoxDecoration,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: kCharacterColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
