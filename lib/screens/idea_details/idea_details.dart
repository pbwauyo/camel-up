import 'package:camel_up/cubit/evaluation_percentage_cubit.dart';
import 'package:camel_up/main.dart';
import 'package:camel_up/models/comment.dart';
import 'package:camel_up/models/idea.dart';
import 'package:camel_up/screens/idea_details/widgets/comment_card.dart';
import 'package:camel_up/screens/idea_details/widgets/idea_card.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdeaDetails extends StatelessWidget {
  final Idea idea;

  IdeaDetails({@required this.idea});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            IdeaCard(idea: idea),

            Container(
              margin: EdgeInsets.only(top: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Text("Evaluate this idea from 1 to 100",
                      style: TextStyle(
                        color: AppColors.lightGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                  ),

                  Container(
                    width: screenWidth * 0.8,
                    child: BlocBuilder<EvaluationPercentageCubit, EvaluationPercentageState>(
                      builder: (context, state) {
                        return Card(
                          color: AppColors.lightGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 4.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    activeTrackColor: AppColors.yellow,
                                    inactiveTrackColor: AppColors.darkGrey,
                                    thumbColor: AppColors.yellow,
                                    overlayColor: Colors.amber.withOpacity(0.5),  
                                  ), 
                                  child: Slider(
                                    min: 0,
                                    max: 100,
                                    divisions: 100,
                                    value: state.percentage, 
                                    onChanged: (value){
                                      context.bloc<EvaluationPercentageCubit>().setPercentage(value.round().toDouble());
                                    },
                                  )
                                ),
                              ),

                              Container(
                                margin: const EdgeInsets.only(right: 0),
                                child: Card(
                                  color: AppColors.lightGrey,
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0),
                                    )
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                                    margin: const EdgeInsets.only(right: 10, left: 10),
                                    child: Text("${state.percentage}"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    ),
                  ),
                  
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 4.0,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.lightGrey,
                  ),
                  width: screenWidth * 0.8,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Add your comment here..",
                      border: InputBorder.none,
                    ),
                    cursorColor: AppColors.yellow,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  // CommentCard(comment: null)
                ],
              ),
            )
          ],
        ),
      )
    );
  }

}