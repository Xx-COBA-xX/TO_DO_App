import 'package:flutter/material.dart';

import '../theme.dart';

class MyButton extends StatelessWidget {
  final Function()? onPressed;
  final String label ;
  const MyButton({
    super.key, this.onPressed, required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryClr),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 13, horizontal: 20))
        ),
        child: Text(label, style: subTitleStyle,),
      ),
    );
  }
}