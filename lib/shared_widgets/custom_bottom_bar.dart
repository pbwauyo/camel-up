import 'package:camel_up/cubit/bottom_bar_button_cubit.dart';
import 'package:camel_up/utils/asset_names.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatefulWidget{
  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      color: AppColors.primaryDark.withOpacity(0.8),
      child: BlocBuilder<BottomBarButtonCubit, BottomBarButtonState>(
        builder: (context, state) {
          final cubit = context.bloc<BottomBarButtonCubit>();
          return Container(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottomBarButton(
                  onTap: (){
                    cubit.goToSearch();
                  }, 
                  isSelected: state is BottomBarButtonSearch,
                  icon: Icons.search,
                ),

                BottomBarButton(
                  onTap: (){
                    cubit.goToCreatePost();
                  }, 
                  isSelected: state is BottomBarButtonCreatePost,
                  icon: Icons.add
                ),

                BottomBarButton(
                  onTap: (){
                    cubit.goToCreateIdea();
                  }, 
                  isSelected: state is BottomBarButtonCreateIdea,
                  //image: AssetImage(AssetNames.LIGHTBULB),
                  icon: Icons.lightbulb_outline,
                ),

                BottomBarButton(
                  onTap: (){
                    cubit.goToIdeaList();
                  }, 
                  isSelected: state is BottomBarButtonIdeaList,
                  // image: SvgPicture.asset(),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}

class BottomBarButton extends StatelessWidget {
  final ImageProvider image;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  BottomBarButton({this.image, this.icon, 
          @required this.onTap, @required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.black38,
        onTap: onTap,
        child: Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              topLeft: Radius.circular(0.0),
              topRight: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ),
            // image: image == null ? null :
            //   DecorationImage(
            //     image: image,
            //     fit: BoxFit.fill
            //   ),
            color: isSelected ? AppColors.yellow : AppColors.lightGrey
          ),
          child: icon != null ? 
            Icon(icon,
              color: AppColors.darkBackground,
              size: 48,
            ) : 
            Center(
              child: SvgPicture.asset(AssetNames.CAMEL_SVG,
                color: AppColors.darkBackground,
                height: 50,
                width: 50,
                fit: BoxFit.fill,
              ),
            )
        ),
      ),
    );
  }
}

