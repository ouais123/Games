import 'dart:developer';

import 'package:dev_games/l10n/l10n.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyLanguage extends StatefulWidget {
  MyLanguage({Key? key}) : super(key: key);

  @override
  State<MyLanguage> createState() => _MyLanguageState();
}

class _MyLanguageState extends State<MyLanguage> {
  final List<String> items = [
    "English",
    "العربية",
    "Deutsch",
    "日本",
    "français"
  ];

  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    getLang();
    return Container(
        margin: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              AppLocalizations.of(context)!.selectLang,
              style: const TextStyle(
                fontFamily: "Raleway",
                fontWeight: FontWeight.w500,
                fontSize: 25.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25,
            ),
            DropdownSearch<String>(
              mode: Mode.DIALOG,
              isFilteredOnline: true,
              showClearButton: true,
              showSelectedItems: true,
              maxHeight: MediaQuery.of(context).size.height * 0.43,
              items: items,
              selectedItem: selectedItem,
              showSearchBox: true,
              dropdownBuilder: (ctx, str) => Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  str ?? "You must select language",
                ),
              ),
              popupItemBuilder: (context, item, isSelected) {
                return ListTile(
                  title: Text(
                    item,
                    textDirection: item == "العربية"
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                  ),
                );
              },
              onChanged: (val) {
                if (val != null) {
                  changeLanguage(val);
                }
              },
            ),
          ],
        ));
  }

  void changeLanguage(String language) async {
    String codeLang = "en";
    switch (language) {
      case "العربية":
        {
          codeLang = "ar";
          break;
        }
      case "English":
        {
          codeLang = "en";
          break;
        }
      case "Deutsch":
        {
          codeLang = "de";
          break;
        }
      case "日本":
        {
          codeLang = "ja";
          break;
        }
      case "français":
        {
          codeLang = "fr";
          break;
        }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("codeLang", codeLang).then((isSuccess) {
      if (isSuccess) Get.updateLocale(Locale(codeLang));
    });
  }

  Future<void> getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String codeLang = prefs.getString("codeLang") ?? "en";
    if (codeLang == "en") {
      setState(() {
        selectedItem = "English";
      });
    } else if (codeLang == "ar") {
      setState(() {
        selectedItem = "العربية";
      });
    } else if (codeLang == "de") {
      setState(() {
        selectedItem = "Deutsch";
      });
    } else if (codeLang == "ja") {
      setState(() {
        selectedItem = "日本";
      });
    } else {
      selectedItem = "français";
    }
  }
}
