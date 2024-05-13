import 'dart:developer';

import 'package:extract_text/cubit/selct_language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownMenuLanguageFrom extends StatefulWidget {
  @override
  _DropdownMenuLanguageState createState() => _DropdownMenuLanguageState();
}

class _DropdownMenuLanguageState extends State<DropdownMenuLanguageFrom> {
  String? selectedLanguage;
  final Map<String, String> languages = {
    "English": "en",
    "Italian": "it",
    "French": "fr",
    "German": "de",
    "Turkish": "tr",
    "Spanish": "es",
  };

  @override
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<SelctLanguageCubit>(context);

    log("$selectedLanguage");
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: DropdownButton<String>(
        hint: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("From"),
        ),
        dropdownColor: const Color.fromARGB(255, 199, 215, 245),
        value: selectedLanguage, //القيمه النهائيه الي ظهرت
        items: languages.entries
            .map<DropdownMenuItem<String>>((MapEntry<String, String> entry) {
          return DropdownMenuItem<String>(
            value: entry.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: Text(entry.key),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          cubit.fromlanguage = newValue;
          setState(() {
            selectedLanguage = newValue;
          });
        },
      ),
    );
  }
}
