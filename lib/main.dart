import 'package:flutter/material.dart';
import 'package:open_pdf/app/data/db_app/init_db.dart';
import 'package:open_pdf/app/ui/page/home_page_pdf.dart';
import 'package:provider/provider.dart';
import 'app/domain/provider/provider_pdf.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await DbServices.db.database;
  await InitDb.create().database;

  runApp(
    ChangeNotifierProvider(
      create: (context) => ProviderPDF(),
      child: const MyApp(),
    ),
  );
}

const maxPossibleTsf = 1.1;
const minPossibleTsf = 0.8;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        final deviceData = MediaQuery.of(context);
        final constraintDataText = MediaQuery.textScalerOf(context).clamp(
            minScaleFactor: minPossibleTsf, maxScaleFactor: maxPossibleTsf);
        // final newTextScaleFactor = min(maxPossibleTsf,deviceData.textScaleFactor);
        return MediaQuery(
            data: deviceData.copyWith(textScaler: constraintDataText),
            child: child ?? const SizedBox.shrink());
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        cardColor: Colors.grey.shade100,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade300),
        primaryColor: Colors.red.shade600,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const HomePagePdf(title: 'Open PDF'),
    );
  }
}
