import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Donate extends StatefulWidget {
  Donate({super.key});

  @override
  State<Donate> createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  static const _number = '40817810808002606916';
 final numberClipBoard =  ClipboardData(text: _number);

  // String _history = 'history';
  // String _folder = 'folder';


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      // color: Colors.white,
      height: 250,
      width: 300,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: theme.canvasColor,
          //Theme.of(context).cardColor,
         // border: Border.all(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
            const Text(
             'Номер карты сбера:',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
         const SizedBox(height: 20,),
          Text(
            _number,
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
          const SizedBox(height: 60,),
           OutlinedButton(onPressed: () => {
             Clipboard.setData(numberClipBoard)
             //   FlutterClipboard.copy(_number)
           },
               child: const Text('Копировать'))

        ],
      ),
    );
  }
}
