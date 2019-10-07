import 'package:flutter/material.dart';
import 'package:timer/main.dart';
import 'package:timer/widgets/top_button.dart';
import 'package:timer/mainEvents.dart';

studyPage(BuildContext context) {
  return Column(
    children: <Widget>[
      AppBar(
        title: Text('学习'),
      ),
      Container(
        color: themeData.primaryColor,
        height: 128,
        child: Row(
          children: <Widget>[
            TopButton(
              title: '学习计时',
              icon: Icons.timer,
              onPressed: () => tapStudyButton(context),
            ),
            TopButton(
              title: '起床/睡觉',
              icon: Icons.brightness_high,
              onPressed: () => tapGetUpOrSleepButton(),
            ),
            TopButton(
              title: '番茄学习',
              icon: Icons.timelapse,
              onPressed: () => tapGetUpOrSleepButton(),
            ),
          ],
        ),
      ),
    ],
  );
}