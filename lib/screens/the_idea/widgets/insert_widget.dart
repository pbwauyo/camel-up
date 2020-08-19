import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class InsertWidget extends StatelessWidget{
  final TextEditingController controller;
  final String text;
  final bool isMedia;
  final VoidCallback onTap;
  final bool showInfoIcon;
  final IconData icon;
  final bool isEnabled;

  InsertWidget({this.controller, @required this.text, 
                this.isMedia = false, @required this.onTap, this.showInfoIcon = false, 
                @required this.icon, this.isEnabled});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.8,
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      child: Row(
        children: [
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(left: 4.0),
            child: Icon(icon,
              color: AppColors.darkGrey,
              size: 48,
            ),
          ),
          
          isMedia ? Expanded(
            child: Container(
              height: 40,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  splashColor: Colors.black38,
                  child: Text(text,
                    style: TextStyle(
                      color: AppColors.darkGreyTextColor,
                      fontSize: 25
                    ),
                  ),
                ),
              ),
            ),
          ) :
          Expanded(
            child: Container(
              child: TextField(
                maxLines: 3,
                enabled: isEnabled,
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: text,
                  hintStyle: TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontSize: 25,
                  ),
                ),
                style: TextStyle(
                  color: AppColors.lightGrey
                ),
              ),
            ),
          ),

          Visibility(
            visible: showInfoIcon,
            child: Container(
              margin: const EdgeInsets.only(right: 4.0, ),
              child: Icon(Icons.help,
                color: AppColors.lightGrey,
              ),
            ) 
          )
        ],
      ),
    );
  }
}