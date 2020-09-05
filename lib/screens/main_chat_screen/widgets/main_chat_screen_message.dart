import 'package:camel_up/models/chat_message.dart';
import 'package:camel_up/screens/chat_screen/chat_screen.dart';
import 'package:camel_up/shared_widgets/dot.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:camel_up/utils/navigations.dart';
import 'package:flutter/material.dart';

class MainChatScreenMessage extends StatelessWidget{
  final ChatMessage chatMessage;

  MainChatScreenMessage({@required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigations.slideFromRight(
          context: context, 
          newScreen: ChatScreen(receiverEmail: chatMessage.senderEmail)
        );
      },
      child: Row(
        children: [

          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: showImage(chatMessage.senderImage),
                ),
                Positioned(
                  right: 12,
                  bottom: 5,
                  child: Dot(color: AppColors.green,)
                )  
              ],
            ),
          ),

          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(chatMessage.senderName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18
                      ), 
                    ),
                  ),

                  Container(
                    child: Text(chatMessage.message,
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.lightGrey,
                        fontSize: 16
                      ), 
                    ),
                  )
                ],
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Text("now",
                    maxLines: 1,
                    style: TextStyle(
                      color: AppColors.lightGrey
                    ), 
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}