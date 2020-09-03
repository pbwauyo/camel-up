import 'package:camel_up/models/idea.dart';
import 'package:camel_up/screens/idea_details/widgets/idea_card_footer.dart';
import 'package:camel_up/screens/profile_page/profile_page.dart';
import 'package:camel_up/screens/the_idea/widgets/team_member_image.dart';
import 'package:camel_up/shared_widgets/camel_button.dart';
import 'package:camel_up/shared_widgets/custom_badge.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/navigations.dart';
import 'package:flutter/material.dart';

class IdeaCard extends StatelessWidget{
  final Idea idea;
  final double _size = 50;
  final bool isExpanded;

  IdeaCard({@required this.idea, this.isExpanded = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          color: AppColors.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          elevation: 3.0,
          child: Container(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 90,
                      child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: idea.team.length > 3 ? 3 : idea.team.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                          final email = idea.team[index]["email"].toString();
                          return TeamMemberImage(
                            email: email,
                            onTap: () {
                              Navigations.slideFromRight(
                                context: context ,
                                newScreen: ProfilePage(email: email)
                              );
                            },
                          );
                        }
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20.0),
                      width: _size,
                      height: _size,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.darkBackground, width: 4),
                        borderRadius: BorderRadius.circular(_size/2)
                      ),
                      child: Center(
                        child: Text("${idea.team.length}",
                          style: TextStyle(
                            color: AppColors.darkBackground,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                Container(
                  child: Wrap(
                    children: idea.ideaKeywords.length > 0 ? 
                    idea.ideaKeywords.map(
                        (keyword) => keyword.isNotEmpty ? 
                        CustomBadge(text: keyword) :
                        Container()
                      ).toList() :
                    
                    [Container()],
                  ),
                ),


                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Text(idea.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ), 
                        ),
                      ),

                      Container(
                        child: Text(idea.text,
                          maxLines: isExpanded ? null : 3,
                          style: TextStyle(
                            color: Colors.black,
                          ), 
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          left: 10,
          right: 10,
          bottom: -10,
          child: Center(
            child: IdeaCardFooter(
              ideaId: idea.id,
              liked: idea.liked,
            ),
          ),
        ),

        Positioned(
          bottom: 20.0,
          right: 15.0,
          child: Visibility(
            visible: !isExpanded,
            child: CamelButton(
              idea: idea
            ),
          ),
        )
      ],
    );
  }
}