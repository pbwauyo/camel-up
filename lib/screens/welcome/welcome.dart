import 'package:camel_up/utils/asset_names.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 116,
                  width: 277,
                  child: Image(
                    image: AssetImage(AssetNames.APP_LOGO_PNG),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  child: Text(
                    "ideas. validation. network.",
                    style: TextStyle(color: AppColors.yellow, fontSize: 26),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Column(
              children: [
                Container(
                  child: Text(
                    "Thank you!",
                    style: TextStyle(
                        color: AppColors.yellow,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                  child: Text(
                    "enjoy and find solutions to start the journey for your next startup or project",
                    style: TextStyle(
                      color: AppColors.lightGrey,
                      fontSize: 26,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.black38,
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Text(
                        "LET'S START",
                        style:
                            TextStyle(color: AppColors.lightGrey, fontSize: 25),
                      ),
                    ),
                    Container(
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColors.lightGrey,
                        size: 48,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
