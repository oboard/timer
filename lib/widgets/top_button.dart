import 'package:flutter/material.dart';

class TopButton extends StatelessWidget {


  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const TopButton({Key key, this.title, this.icon, this.onPressed}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    
    return FlatButton(
      child: Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: Theme.of(context).primaryTextTheme.button.color,
                ),
                child:Padding(
                padding: EdgeInsets.all(10.0),
                child:Icon(icon,
                    size: 32,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Text(title,
              style:Theme.of(context).primaryTextTheme.button
            ),],
        ),
      ),
      onPressed: onPressed,
    );
  }

}