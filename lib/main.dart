import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dev_games/db/db_helper.dart';
import 'package:dev_games/l10n/l10n.dart';
import 'package:dev_games/view/screen/details_game.dart';
import 'package:dev_games/view/screen/main_games.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDB();
  SharedPreferences.getInstance().then((instance) {
    String codeLang = instance.getString("codeLang") ?? "en";
    runApp(MyApp(codeLang: codeLang,));
  });
}

class MyApp extends StatelessWidget {
  String codeLang;
  MyApp({
    Key? key,
    required this.codeLang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      locale: Locale(codeLang),
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      getPages: [
        GetPage(
          name: "/",
          page: () => MainGames(),
        ),
        GetPage(
          name: "/detailsGame",
          page: () => DetailsGames(),
        ),
      ],
    );
  }
}
