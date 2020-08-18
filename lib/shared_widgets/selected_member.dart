import 'package:camel_up/models/profile.dart';
import 'package:camel_up/utils/asset_names.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class SelectedMember extends StatelessWidget{
  final String email;
  final String role;
  final double size = 60;

  SelectedMember({@required this.email, @required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Text("Chief Executive Officer",
              style: TextStyle(
                      color: AppColors.lightGrey,
                      fontSize: 18
                    ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: size,
                height: size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size/2),
                  image: DecorationImage(
                    image: AssetImage(AssetNames.APP_LOGO_PNG),
                    fit: BoxFit.fill
                  )
                ),
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text("Enrico Pandian",
                      style: TextStyle(
                        color: AppColors.lightGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),

                  Container(
                    child: Text("Move immediatedly",
                      style: TextStyle(
                        color: AppColors.lightGrey,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}