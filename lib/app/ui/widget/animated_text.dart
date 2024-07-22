

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
const find = Text('+',style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 70),);
const textAnimated = 'Tab + найди файл';
const textAnimatedArray = ['Нажми', '+', 'чтобы', 'найти','файл'];
const textAnimatedArray1 = ['Чтобы найти файл','нажми +', ];
const styleTextAnimated =
    TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.grey);

class AnimatedText extends StatelessWidget {
  const AnimatedText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: AnimatedTextKit(animatedTexts: [
          for(final text in textAnimatedArray1)
          TyperAnimatedText(text,
              textAlign: TextAlign.center, textStyle: styleTextAnimated),
        ]),
      ),
    );
  }
}
