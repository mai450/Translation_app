import 'package:extract_text/cubit/selct_language_cubit.dart';
import 'package:extract_text/helpfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class RecognizePageContent extends StatefulWidget {
  const RecognizePageContent({
    super.key,
    required this.path,
    required this.cubit,
  });
  final String path;
  final SelctLanguageCubit cubit;
  @override
  State<RecognizePageContent> createState() => _RecognizePageContentState();
}

class _RecognizePageContentState extends State<RecognizePageContent> {
  bool isPlay = false;
  FlutterTts tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    final InputImage inputImage = InputImage.fromFilePath(widget.path);

    processImage(inputImage).then((value) async {
      if (value == "") {
        value = "You have not selected any text";
      }
      await widget.cubit.translat(text: value);
      //translat(from: "de", to: "ja", text: value);
    });

    tts.setCompletionHandler(
      () {
        setState(() {
          isPlay = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PhysicalModel(
        color: Colors.white,
        elevation: 3,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Extracted Text",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 157, 157, 157),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.cubit.fromlanguage ?? "en",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 157, 157, 157),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SelectableText(
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black54),
                    widget.cubit.textbefortrans!),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey.shade300,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Translated ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 157, 157, 157),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () async {
                        if (isPlay) {
                          // لو الصوت شغال → أوقفه
                          tts.pause();
                          setState(() {
                            isPlay = false;
                          });
                        } else {
                          // لو الصوت واقف → شغّله
                          await play(
                            language: widget.cubit.tolanguage ?? "en",
                            tts: tts,
                            text: widget.cubit.textAftertrans!,
                          );
                          setState(() {
                            isPlay = true;
                          });
                        }
                      },
                      icon: Icon(
                        isPlay
                            ? Icons.volume_up_rounded
                            : Icons.volume_off_rounded,
                        size: 16,
                        color: isPlay
                            ? Colors.blueAccent
                            : const Color.fromARGB(255, 157, 157, 157),
                      ),
                    ),
                    Text(
                      widget.cubit.tolanguage ?? 'ar',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 157, 157, 157),
                      ),
                    ),
                  ],
                ),
                SelectableText(
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.blueAccent),
                    widget.cubit.textAftertrans!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
