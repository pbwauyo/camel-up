import 'package:camel_up/models/idea.dart';
import 'package:camel_up/repos/idea_repo.dart';
import 'package:camel_up/screens/idea_details/widgets/idea_card.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/shared_widgets/empty_results_text.dart';
import 'package:camel_up/shared_widgets/error_text.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class IdeaList extends StatefulWidget{
  @override
  _IdeaListState createState() => _IdeaListState();
}

class _IdeaListState extends State<IdeaList> {
  final IdeaRepo _ideaRepo = IdeaRepo();
  Future<List> ideasFuture;

  @override
  void initState() {
    super.initState();
    ideasFuture = _ideaRepo.getAllIdeas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: FutureBuilder<List<Idea>>(
        future: ideasFuture,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            final data = snapshot.data;
            if(data.length <= 0){
              return Center(child: EmptyResultsText());
            }
            return Container(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index){
                  return IdeaCard(idea: data[index]);
                }
              ),
            );
          }else if(snapshot.hasError){
            return Center(child: ErrorText(error: snapshot.error));
          }

          return Center(child: CustomProgressIndicator());
        }
      ),
    );
  }
}