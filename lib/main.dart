import 'package:flutter/material.dart';
import 'package:open_pdf/app/app_key_value.dart';
import 'package:open_pdf/app/data/db_app/db_services_folder.dart';
import 'package:open_pdf/app/data/db_app/init_db.dart';
import 'package:open_pdf/app/domain/provider/provider_folder.dart';
import 'package:open_pdf/app_router/app_router.dart';
import 'package:open_pdf/my_shared_preferences.dart';
import 'package:open_pdf/utility/pdf_function.dart';
import 'package:provider/provider.dart';
import 'app/app_const.dart';
import 'app/domain/provider/provider_folder_pdf.dart';
import 'app/domain/provider/provider_pdf.dart';


//String settingsKeyFirstPages = 'firstPages';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitDb.create().database;
  await initFolderStart(DbServicesFolder(InitDb.create()));
  String? firstPage = await MySharedPreferences().getFirstPage(AppKeyValue.settingsKeyFirstPages);
  if (firstPage == null) {
    await MySharedPreferences().setFirstPage(AppKeyValue.settingsKeyFirstPages,NAME_FIRST_PAGES_HISTORY);
  }else{
    AppKeyValue.settingsValueFirstPages = firstPage;
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderPDF(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderFolder(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderFolderPdf(),
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
  void initState() {
    context.read<ProviderPDF>().updatePdfListModelHistory();
    context.read<ProviderFolder>().updateListFolder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      builder: (context, child) {
        final deviceData = MediaQuery.of(context);
        final constraintDataText = MediaQuery.textScalerOf(context).clamp(
            minScaleFactor: minPossibleTsf, maxScaleFactor: maxPossibleTsf);

        return MediaQuery(
            data: deviceData.copyWith(textScaler: constraintDataText),
            child: child ?? const SizedBox.shrink());
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.black, fontSize: 20),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.cyan, width: 5)),
        ),
        cardColor: Colors.grey.shade200,
        canvasColor: Colors.white,
        primaryColor: Colors.red.shade600,
        scaffoldBackgroundColor: Colors.white,
        // textTheme: TextTheme(),
        useMaterial3: true,
      ),
      routerConfig: _router.config(),
    );
  }
}
