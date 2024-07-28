

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

const textAnimatedArray1 = ['Чтобы создать папку','нажми +', ];
const styleTextAnimated =
    TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.grey);

class AnimatedTextFolder extends StatelessWidget {
  const AnimatedTextFolder({super.key});

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
