import 'package:camel_up/utils/asset_names.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DonateButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 9.0,
          shadowColor: AppColors.yellow.withOpacity(0.8),
          color: AppColors.darkBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), 
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            )
          ),
          child: Container(
            height: 120,
            width: 200,
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              child: Text("Donate to Camel UP!",
              maxLines: null,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.yellow,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ), 
              ),
            ),
          ),
        ),

        Positioned(
          right: -15,
          bottom: -15,
          child: Material(
            color: Colors.transparent,
            elevation: 4.0,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              topLeft: Radius.circular(0.0),
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                color: AppColors.darkBackground
              ),
              child: SvgPicture.asset(AssetNames.CAMEL_SVG,
                  color: AppColors.yellow,
                  fit: BoxFit.fill,
                )
            ),
          ),
        ),
      ],
    );
  }
}