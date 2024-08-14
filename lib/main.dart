
import 'package:flutter/material.dart';
import 'package:open_pdf/app/data/db_app/db_services_folder.dart';
import 'package:open_pdf/app/data/db_app/init_db.dart';
import 'package:open_pdf/app/domain/provider/provider_folder.dart';
import 'package:open_pdf/app_router/app_router.dart';
import 'package:open_pdf/utility/pdf_function.dart';
import 'package:provider/provider.dart';
import 'app/app_const.dart';
import 'app/domain/provider/provider_pdf.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await InitDb.create().database;
  await initFolderStart(DbServicesFolder(InitDb.create()));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderPDF(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderFolder(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = AppRouter();
  @override
  Widget build(BuildContext context) {
    context.read<ProviderPDF>().updatePdfListModelHistory();
   // context.read<ProviderPDF>().updatePDFListModelFavourites();
    context.read<ProviderFolder>().updateListFolder();


    return MaterialApp.router(
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
        //buttonTheme: ButtonThemeData() ,
        cardColor: Colors.grey.shade200,
        primaryColor: Colors.red.shade600,
        scaffoldBackgroundColor: Colors.white,
        // textTheme: TextTheme(),
        useMaterial3: true,
      ),
      routerConfig: _router.config(),
    );
  }
}
