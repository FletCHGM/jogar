import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/model/colors/colors.dart';
import '/model/textstyle/textstyles.dart';

class Rules extends StatelessWidget {
  const Rules({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background/png/back.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/background/png/glow.png',
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: const Alignment(0, -0.65),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 430 * 222,
                  height: MediaQuery.of(context).size.height / 932 * 79,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/button/button.svg',
                        fit: BoxFit.contain,
                      ),
                      Center(
                        child: Text(
                          'RULES',
                          style:
                              changa(43, FontWeight.w500, MainColors.mainBrown),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 430 * 38,
                  top: MediaQuery.of(context).size.height / 932 * 80,
                ),
                child: GestureDetector(
                  onTapDown: (_) {
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width / 430 * 38,
                        height: MediaQuery.of(context).size.height / 932 * 38,
                        child:
                            SvgPicture.asset('assets/images/button/back.svg')),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 430 * 44,
                    right: MediaQuery.of(context).size.width / 430 * 44,
                    top: MediaQuery.of(context).size.height / 932 * 230),
                child: ListView(
                  shrinkWrap: true,
                  children: const [
                    Center(
                      child: OutlinedText(
                        text:
                            'Rules of the game "Three in a Row":\n\nThe player is given a starting field on which random elements appear.\n\nThe goal of the game is to collect a certain number of specific elements as specified in the task.\n\nMoving elements:\nPlayers are allowed to move elements around the field, exchanging their positions to create rows of three or more identical elements. Elements can be moved vertically or horizontally, but cannot jump over other elements.\n\nCreating rows:\nWhen a player creates a row of three or more identical elements, these elements disappear from the field, and the player earns points.\n\nTasks:\nAt the bottom of the screen, a task is displayed that the player needs to complete.\n\nVictory:\nThe player wins when they achieve all the goals in the game.',
                        textColor: MainColors.mainCream,
                        outlineColor: MainColors.mainOragne,
                        shadowColor: Color.fromARGB(255, 6, 7, 61),
                        fontSize: 28,
                        textFamily: 'Nerko',
                        outlineSize: 1,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
//'Rules of the game "Three in a Row":\n\nThe player is given a starting field on which random elements appear.\n\nThe goal of the game is to collect a certain number of specific elements as specified in the task.\n\nMoving elements:\nPlayers are allowed to move elements around the field, exchanging their positions to create rows of three or more identical elements. Elements can be moved vertically or horizontally, but cannot jump over other elements.\n\nCreating rows:\nWhen a player creates a row of three or more identical elements, these elements disappear from the field, and the player earns points.\n\nTasks:\nAt the bottom of the screen, a task is displayed that the player needs to complete.\n\nVictory:\nThe player wins when they achieve all the goals in the game.'