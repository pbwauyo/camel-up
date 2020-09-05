import 'package:camel_up/cubit/auth_cubit.dart';
import 'package:camel_up/models/chat_message.dart';
import 'package:camel_up/repos/chat_repo.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/shared_widgets/empty_results_text.dart';
import 'package:camel_up/shared_widgets/error_text.dart';
import 'package:camel_up/screens/main_chat_screen/widgets/main_chat_screen_message.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainChatScreen extends StatefulWidget {
   
  @override
  _MainChatScreenState createState() => _MainChatScreenState();
}

class _MainChatScreenState extends State<MainChatScreen> {
  final _chatMessagesRepo = ChatMessageRepo();

  @override
  Widget build(BuildContext context) {
    final email = (context.bloc<AuthCubit>().state as AuthLoggedIn).email;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child:  StreamBuilder<QuerySnapshot>(
                stream: _chatMessagesRepo.getAllUserChatsAsStream(userEmail: email),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    final docs = snapshot.data.documents;
                    if(docs.length <= 0){
                      return Center(child: EmptyResultsText(message: "No messages yet"));
                    }
                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index){
                        final chatMessage = ChatMessage.fromMap(docs[index].data);
                        return Container(
                          margin: const EdgeInsets.only(left: 10, right: 10, top: 15,),
                          child: MainChatScreenMessage(chatMessage: chatMessage)
                        );
                      }
                    );
                  }
                  else if(snapshot.hasError){
                    return Center(
                      child: ErrorText(error: snapshot.error),
                    );
                  }
                  return Center(
                    child: CustomProgressIndicator(),
                  );
                }
              ),
            ),
            Container(
              child: Row(
                children: [

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}