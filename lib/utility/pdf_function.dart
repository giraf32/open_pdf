import 'package:intl/intl.dart';
import '../app/domain/model/pdf_model.dart';

String formatterDate() {
  final dateTime = DateTime.now();
  final DateFormat formatter = DateFormat.yMd().add_Hms();
  final String formatDate = formatter.format(dateTime);
  print('dataTime : $formatDate');
  return formatDate;
}

List<PdfModel> sortListPdf(List<PdfModel> list){
  final DateFormat formatter = DateFormat.yMd().add_Hms();

  bool Sorted = false;
  while (!Sorted) {
    Sorted = true;
    for (int i = 1; list.length > i; i++) {
      var dateTimeFirst = formatter.parse(list[i - 1].dateTime);
      var dateTimeSecond = formatter.parse(list[i].dateTime);
      if (dateTimeFirst.isBefore(dateTimeSecond)) {
        var tmp = list[i];
        list[i] = list[i - 1];
        list[i - 1] = tmp;
        Sorted = false;
      }
    }
  }

  return list;
}
List<PdfModel?> comparePdfModel(
    {required List<PdfModel> listFirst, required List<PdfModel> listSecond}) {
  var list = <PdfModel?>[];

  listFirst.forEach((modelFirst) {
    listSecond.forEach((modelSecond) {
      if (modelSecond.name == modelFirst.name) {
        list.add(modelSecond);
      }
    });
  });
  print('ListTest: $list');

  return list;
}