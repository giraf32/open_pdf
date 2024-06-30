

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
const find = Text('+',style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 70),);
const textAnimated = 'Tab + найди файл';
const styleTextAnimated =
    TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.grey);

class AnimatedText extends StatelessWidget {
  const AnimatedText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: AnimatedTextKit(animatedTexts: [
          TyperAnimatedText(textAnimated,
              textAlign: TextAlign.center, textStyle: styleTextAnimated),
        ]),
      ),
    );
  }
}
