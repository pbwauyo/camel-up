import 'package:camel_up/utils/colors.dart';
import 'package:flutter/widgets.dart';

class YellowDot extends StatelessWidget{
  final double size;

  YellowDot({@required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.circular(size/2)
      ),
    );
  }

}