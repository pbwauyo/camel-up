import 'package:camel_up/cubit/auth_cubit.dart';
import 'package:camel_up/models/chat_message.dart';
import 'package:camel_up/repos/chat_repo.dart';
import 'package:camel_up/screens/chat_screen/widgets/chat_screen_header.dart';
import 'package:camel_up/screens/chat_screen/widgets/chat_text_field.dart';
import 'package:camel_up/screens/chat_screen/widgets/message_receiver_widget.dart';
import 'package:camel_up/screens/chat_screen/widgets/message_sender_widget.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/shared_widgets/empty_results_text.dart';
import 'package:camel_up/shared_widgets/error_text.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  final String receiverEmail;

  ChatScreen({@required this.receiverEmail});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _chatMessagesRepo = ChatMessageRepo();

  @override
  Widget build(BuildContext context) {
   final _currentUserEmail = (context.bloc<AuthCubit>().state as AuthLoggedIn).email;

   return Scaffold(
     backgroundColor: AppColors.darkBackground,
     body: SafeArea(
       child: Container(
         padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
         child: Column(
           children: [
             Container(
               margin: const EdgeInsets.only(top: 10, bottom: 10),
               child: ChatScreenHeader()
             ),

             Expanded(
               child: StreamBuilder<QuerySnapshot>(
                 stream: _chatMessagesRepo.getSenderChatsAsStream(
                   currentUserEmail: _currentUserEmail, receiverEmail: widget.receiverEmail),

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
                        if(chatMessage.senderEmail == _currentUserEmail){
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: MessageSenderWidget(chatMessage: chatMessage)
                          );
                        }
                        else {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: MessageReceiverWidget(chatMessage: chatMessage)
                          );
                        }
                      }
                     );
                   }
                   else if(snapshot.hasError){
                     return Center(child: ErrorText(error: snapshot.error));
                   }
                   return Center(child: CustomProgressIndicator());
                 }
               )
             ),

             ChatTextField(receiverEmail: widget.receiverEmail,)
           ],
         ),
       ),
     ),
   );
  }
}