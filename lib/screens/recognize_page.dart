import 'package:extract_text/cubit/selct_language_cubit.dart';
import 'package:extract_text/helpfunction.dart';
import 'package:extract_text/widget/custom_app_bar.dart';
import 'package:extract_text/widget/recognize_page_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class RecognizePage extends StatefulWidget {
  final String path;
  final SelctLanguageCubit cubit;
  const RecognizePage({Key? key, required this.path, required this.cubit})
      : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool isBusy = true;
  @override
  void initState() {
    super.initState();
    setState(() {
      isBusy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF0F2),
        body: isBusy
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF0360E0),
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: [
                    const CustomAppBar(),
                    RecognizePageContent(
                      path: widget.path,
                      cubit: widget.cubit,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
