import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

tapAdd() {}

tapStudyButton(BuildContext context) {
  showDialog(
    context: context,
    child: AlertDialog(
      title: Text('本次学习内容'),
      content: Column(
        children: <Widget>[
          TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: '如：背单词',
            ),
          ),
          CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm, //可以设置时分、时分秒和分秒三种模式
            initialTimerDuration: Duration(hours: 1, minutes: 35, seconds: 50), // 默认显示的时间值
            minuteInterval: 5, // 分值间隔，必须能够被initialTimerDuration.inMinutes整除
            secondInterval: 10, // 秒值间隔，必须能够被initialTimerDuration.inSeconds整除，此时设置为10，则选择项为0、10、20、30、40、50六个值
            onTimerDurationChanged: (duration) {

              print('当前选择了：${duration.inHours}时${duration.inMinutes-duration.inHours*60}分${duration.inSeconds-duration.inMinutes*60}秒');
            },
          )
        ],
      ),
    ),
  );
}

tapGetUpOrSleepButton() {}
