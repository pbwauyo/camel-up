import 'dart:async';

import 'package:camel_up/cubit/team_results_cubit.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';


class SearchTextField extends StatefulWidget {
  final bool performTeamSearch;

  SearchTextField({@required this.performTeamSearch});

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
  
}

class _SearchTextFieldState extends State<SearchTextField> {

  final onTextChangedStream = PublishSubject<String>();

  @override
  void initState() {
    super.initState();
    
    onTextChangedStream
      .distinct()
      .debounceTime(Duration(seconds: 1))
      .listen((keyword) {
          if(widget.performTeamSearch && keyword.isNotEmpty){
            print("Keyword: $keyword");
            context.bloc<TeamResultsCubit>().fetchUsersByKeyword(keyword);
          }
       });
   
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: AppColors.lightGrey
      ),
      margin: const EdgeInsets.fromLTRB(40, 5.0, 40, 5.0),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter keyword",
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.darkGrey,
            size: 24,
          ),    
        ),
        onChanged: (string){
          onTextChangedStream.add(string.trim());
        },
      ),
    );
  }
}