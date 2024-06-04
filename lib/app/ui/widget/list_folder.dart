
import 'package:flutter/material.dart';

import 'package:open_pdf/app/ui/widget/pdf_list_history.dart';


class ListFolder extends StatelessWidget {
  const ListFolder({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(10),
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        Card(
          color: Colors.amberAccent,
          child: ListTile(
            //subtitle: Text(pdfModel.dateTime.toString()),
            title: Text(
              'Просмотренные',
              style: TextStyle(fontSize: 14),
            ),
            // subtitle: Text('$dateCreateFile | $sizeFile'),
            onTap: () {
              debugPrint('HI VICTOR');
              PDFListHistory();
            },
            // trailing: Icon(Icons.access_alarm),

            // leading: Icon(Icons.ac_unit),
            onLongPress: () {},
          ),
        ),
        Card(
          color: Colors.amberAccent,
          child: ListTile(
            //subtitle: Text(pdfModel.dateTime.toString()),
            title: Text(
              'Избранное',
              style: TextStyle(fontSize: 14),
            ),
            // subtitle: Text('$dateCreateFile | $sizeFile'),
            onTap: () {
               debugPrint('HI VICTOR');
               },
           // trailing: Icon(Icons.access_alarm),

           // leading: Icon(Icons.ac_unit),
            onLongPress: () {},
          ),
        ),

      ],
    );
  }
}
