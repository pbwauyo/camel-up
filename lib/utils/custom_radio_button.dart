import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget{
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  CustomRadioButton({@required this.isSelected, @required this.text, @required this.onTap});

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  final double bigContainerSize = 40;
  final double smallContainerSize = 20;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.black38,
            onTap: widget.onTap,
            child: Container(
              alignment: Alignment.center,
              width: bigContainerSize,
              height: bigContainerSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(bigContainerSize/2),
                border: Border.all(color: AppColors.yellow, width: 3)
              ),
              child: AnimatedOpacity(
                opacity: widget.isSelected ? 1 : 0,
                duration: Duration(milliseconds: 500),
                child: Container(
                  width: smallContainerSize,
                  height: smallContainerSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(smallContainerSize/2),
                    color: AppColors.yellow
                  ),
                ),
              ),
            ),
          ),
        ),

        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(widget.text,
            style: TextStyle(
              color: AppColors.lightGrey,
              fontSize: 25
            ),
          ),
        )
      ],
    );
  }
}