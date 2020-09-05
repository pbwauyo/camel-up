import 'package:camel_up/models/chat_message.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class MessageReceiverWidget extends StatelessWidget {
  final ChatMessage chatMessage;

  MessageReceiverWidget({@required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.yellow.withOpacity(0.6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20)
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 200),
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(chatMessage.message,
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
          Container(
            child: Text("17:45",
              style: TextStyle(
                color: AppColors.lightGrey,
                fontSize: 12
              ),
            ),
          )
        ],
      ),
    );
  }
}