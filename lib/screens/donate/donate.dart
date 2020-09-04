import 'package:camel_up/shared_widgets/donate_button.dart';
import 'package:camel_up/utils/asset_names.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class DonatePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: ListView(
        children: [
          Container(
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

          Container(
            margin: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Text("We believe in ideas.",
                    style: TextStyle(
                      color: AppColors.lightGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ), 
                  ),
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text("They deserve attention, feedbacks, validation, people ready to change and believe them.",
                  maxLines: null,
                    style: TextStyle(
                      color: AppColors.lightGrey,
                      fontSize: 18
                    ), 
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Text("We believe in people.",
                    style: TextStyle(
                      color: AppColors.lightGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ), 
                  ),
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text("Their unstoppable ability of connecting to find solutions.",
                  maxLines: null,
                    style: TextStyle(
                      color: AppColors.lightGrey,
                      fontSize: 18
                    ), 
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Text("We don't believe in unicorns.",
                    style: TextStyle(
                      color: AppColors.lightGrey,
                      fontSize: 18
                    ), 
                  ),
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text("We believe in Camels, ready to walk across deserts.",
                  maxLines: null,
                    style: TextStyle(
                      color: AppColors.lightGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ), 
                  ),
                ),
              ],
            ),
          ),  

          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: DonateButton()
            ),
          ),        

          Center(
            child: Card(
              elevation: 4.0,
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
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                      child: Text("Tell us how to improve Camel UP",
                      maxLines: null,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.lightGrey,
                          fontSize: 18,
                        ), 
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Text("info@camelup.com",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.lightGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ), 
                      ),
                    ),
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