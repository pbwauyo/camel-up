import 'package:camel_up/cubit/idea_upload_cubit.dart';
import 'package:camel_up/screens/the_idea/the_idea.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DoneButton extends StatefulWidget{
  final String text;
  final Color color;
  final VoidCallback onTap;
  final dynamic state;
  final bool enabled;

  DoneButton({this.text, this.color, 
    @required this.onTap, @required this.state, @required this.enabled});

  @override
  _DoneButtonState createState() => _DoneButtonState();
}

class _DoneButtonState extends State<DoneButton> {
  @override
  Widget build(BuildContext context) {

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.enabled ? widget.onTap : null,
        splashColor: Colors.black38,
        child: Container(
          alignment: Alignment.centerLeft,
          width: 150,
          height: 50,
          decoration: BoxDecoration (
            color: widget.color ?? AppColors.lightGrey,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(0.0),
                bottomRight: Radius.circular(45.0),
                bottomLeft: Radius.circular(45.0),
                topLeft: Radius.circular(45.0),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 4.0, left: 6.0),
                child: Text(widget.text,
                  style: TextStyle(
                    color: AppColors.darkBackground,
                    fontSize: 22
                  ),
                ),
              ),

              Visibility(
                visible: widget.state is IdeaUploadInProgress,
                child: Container(
                  child: CustomProgressIndicator(
                    size: 18,
                    color: Colors.blue,
                  ),
                ),
              ),

              AnimatedOpacity(
                opacity: widget.state is IdeaUploadDone ? 1 : 0, 
                duration: Duration(milliseconds: 500),
                child: Icon(
                  Icons.done,
                  size: 24,
                  color: Colors.green,
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}