import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/model/audio_controll/audio.dart';
import '/model/settings/setting.dart';
import '/model/colors/colors.dart';
import '/model/textstyle/textstyles.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late double soundSettingPos =
      (MediaQuery.of(context).size.width / 430 * 161) * soundVolume;
  late double themeSettingPos =
      (MediaQuery.of(context).size.width / 430 * 161) * themeVolume;
  setThemeSettingVolume(double x) {
    setState(() {
      themeSettingPos += x;
      var coaf =
          themeSettingPos / (MediaQuery.of(context).size.width / 430 * 161);
      setThemeVolume(coaf);
    });
    if (themeSettingPos >= MediaQuery.of(context).size.width / 430 * 161) {
      setState(() {
        themeSettingPos = MediaQuery.of(context).size.width / 430 * 161;

        setThemeVolume(1);
      });
    } else if (themeSettingPos <= 0) {
      setState(() {
        themeSettingPos = 0;
        setThemeVolume(0);
      });
    }
  }

  setSoundSettingVolume(double x) {
    setState(() {
      soundSettingPos += x;
      var coaf =
          soundSettingPos / (MediaQuery.of(context).size.width / 430 * 161);
      setSoundVolume(coaf);
    });
    if (soundSettingPos >= MediaQuery.of(context).size.width / 430 * 161) {
      setState(() {
        soundSettingPos = MediaQuery.of(context).size.width / 430 * 161;

        setSoundVolume(1);
      });
    } else if (soundSettingPos <= 0) {
      setState(() {
        soundSettingPos = 0;
        setSoundVolume(0);
      });
    }
  }

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
                alignment: const Alignment(0, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 430 * 334,
                  height: MediaQuery.of(context).size.height / 932 * 260,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/background/svg/settings_back.svg',
                        fit: BoxFit.contain,
                      ),
                      Align(
                        alignment: const Alignment(0, -0.7),
                        child: Text(
                          'sound',
                          style:
                              changa(37, FontWeight.w500, MainColors.mainBrown),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0, -0.2),
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).size.height / 932 * 27.5,
                          width: MediaQuery.of(context).size.width / 430 * 179,
                          child: Stack(
                            children: [
                              Center(
                                child: SvgPicture.asset(
                                  'assets/images/background/svg/progress_indicator_body.svg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height /
                                    932 *
                                    3,
                                left: soundSettingPos,
                                child: GestureDetector(
                                  onHorizontalDragUpdate: (details) {
                                    setSoundSettingVolume(details.delta.dx);
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    width: MediaQuery.of(context).size.width /
                                        430 *
                                        20,
                                    child: SvgPicture.asset(
                                      'assets/images/button/setting_drag.svg',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0, 0.15),
                        child: Text(
                          'music',
                          style:
                              changa(37, FontWeight.w500, MainColors.mainBrown),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0, 0.6),
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).size.height / 932 * 27.5,
                          width: MediaQuery.of(context).size.width / 430 * 179,
                          child: Stack(
                            children: [
                              Center(
                                child: SvgPicture.asset(
                                  'assets/images/background/svg/progress_indicator_body.svg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height /
                                    932 *
                                    3,
                                left: themeSettingPos,
                                child: GestureDetector(
                                  onHorizontalDragUpdate: (details) {
                                    setThemeSettingVolume(details.delta.dx);
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    width: MediaQuery.of(context).size.width /
                                        430 *
                                        20,
                                    child: SvgPicture.asset(
                                      'assets/images/button/setting_drag.svg',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, -0.5),
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
                          'OPTIONS',
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
                      child: SvgPicture.asset(
                        'assets/images/button/home.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
