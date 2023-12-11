import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/model/colors/colors.dart';
import '/model/textstyle/textstyles.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

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
                alignment: const Alignment(0, 0.1),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 430 * 244,
                  child: SvgPicture.asset(
                    'assets/images/background/svg/progress_indicator_body.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Loading...',
                  style: changa(35, FontWeight.w500, MainColors.mainBrown),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
