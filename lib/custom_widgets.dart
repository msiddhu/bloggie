import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleProgress extends StatelessWidget {
  const CircleProgress({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child:CircularProgressIndicator(

        backgroundColor: Colors.red,
        strokeWidth: 10.0,

      ),
    );
  }
}


class CircleProgressBox extends StatelessWidget {
  const CircleProgressBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(30)),
      height:100,
      child:CircleProgress(),
      alignment: Alignment.center,
    );
  }
}