import 'package:camel_up/cubit/auth_cubit.dart';
import 'package:camel_up/cubit/evaluation_percentage_cubit.dart';
import 'package:camel_up/main.dart';
import 'package:camel_up/models/comment.dart';
import 'package:camel_up/models/idea.dart';
import 'package:camel_up/repos/comment_repo.dart';
import 'package:camel_up/repos/idea_repo.dart';
import 'package:camel_up/repos/user_repo.dart';
import 'package:camel_up/screens/idea_details/widgets/comment_card.dart';
import 'package:camel_up/screens/idea_details/widgets/comment_text_field.dart';
import 'package:camel_up/screens/idea_details/widgets/idea_card.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/shared_widgets/empty_results_text.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/custom_animation_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdeaDetails extends StatelessWidget {
  final Idea idea;
  final CommentRepo _commentRepo = CommentRepo();
  final IdeaRepo _ideaRepo = IdeaRepo();
  final UserRepo _userRepo = UserRepo();

  IdeaDetails({@required this.idea});

  @override
  Widget build(BuildContext context) {
    context.bloc<EvaluationPercentageCubit>().setPercentage(double.parse(idea.averageEvaluation));
    final screenWidth = MediaQuery.of(context).size.width;

        return Scaffold(
          backgroundColor: AppColors.darkBackground,
          body: SafeArea(
            child: Column(
              children: [
                IdeaCard(idea: idea),
    
                Container(
                  margin: EdgeInsets.only(top: 15),
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
                                          Future.delayed(Duration(seconds: 2), 
                                          () async{
                                            _ideaRepo.saveIdeaEvaluation(
                                              evaluatorEmail: await _userRepo.getCurrentUserEmail(), 
                                              ideaId: idea.id, 
                                              evaluation: value.round().toString()
                                            );
                                          });
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
    
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _commentRepo.getCommentsAsStream(idea.id),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        final data = snapshot.data.docs;
    
                        if(data.length <= 0){
                          return EmptyResultsText(
                            message: "No comments yet",
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index){
                            print("INDEX: $index");
                            return Container(
                              margin: const EdgeInsets.only(top: 30),
                              child: CommentCard(
                                comment: Comment.fromMap(data[index].data())
                              ),
                            );
                          },
                        );
                      }
                      return CustomProgressIndicator();
                    }
                  ),
                ),
    
                CommentTextField(ideaId: idea.id)
          ],
        ),
      )
    );
  }

}