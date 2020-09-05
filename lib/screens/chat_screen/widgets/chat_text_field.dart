import 'package:camel_up/models/chat_message.dart';
import 'package:camel_up/repos/chat_repo.dart';
import 'package:camel_up/repos/user_repo.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatTextField extends StatefulWidget {
  final String receiverEmail;

  ChatTextField({@required this.receiverEmail});

  @override
  _ChatTextFieldState createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final _firestore = Firestore.instance;

  final _userRepo = UserRepo();
  final _chatMessagesRepo = ChatMessageRepo();

  bool isSending = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkBackground2,
        borderRadius: BorderRadius.circular(30)
      ),
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: TextField(
                style: TextStyle(
                  color: Colors.white
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.sentiment_satisfied,
                    color: AppColors.lightGrey,
                  ),
                  hintText: "Type your message",
                  hintStyle: TextStyle(
                    color: AppColors.lightGrey
                  ),
                ),
                textInputAction: TextInputAction.send,
                onSubmitted: (message) async{
                  setState(() {
                    isSending = true;
                  });

                  final ref  = _firestore.collection("chats").document();
                  final chatMessage = ChatMessage();
                  final senderProfile = await _userRepo.getCurrentUserProfile();
                  chatMessage.id = ref.documentID;
                  chatMessage.message = message.trim();
                  chatMessage.senderName = "${senderProfile.firstName} ${senderProfile.lastName}";
                  chatMessage.senderImage = senderProfile.profileImage;
                  chatMessage.senderEmail = senderProfile.email;
                  chatMessage.receiverEmail = widget.receiverEmail;
                  await _chatMessagesRepo.postChatMessage(chatMessage);

                  setState(() {
                    isSending = false;
                  });

                },
              ),
            ),
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: !isSending,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 5),
                  child: Icon(Icons.photo_camera,
                    color: AppColors.darkBackground,
                  ),
                ),
              ),

              Visibility(
                visible: !isSending,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 5),
                  child: Icon(Icons.mic_none,
                    color: AppColors.darkBackground,
                  ),
                ),
              ),

              Visibility(
                visible: isSending,
                child: Container(
                  margin: const EdgeInsets.only(right: 5),
                  width: 15,
                  height: 15,
                  child: CustomProgressIndicator(),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}