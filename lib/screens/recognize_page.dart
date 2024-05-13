import 'package:extract_text/cubit/selct_language_cubit.dart';
import 'package:extract_text/helpfunction.dart';
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
  bool _isBusy = true;

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
      setState(() {
        _isBusy = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF0F2),
        // appBar: AppBar(
        //   backgroundColor: const Color.fromARGB(234, 255, 255, 255),
        //   elevation: 0,
        //   title: const Text("Translation page"),
        // ),
        body: _isBusy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_sharp,
                              size: 20,
                              color: Color(0xFF0360E0),
                            )),
                        const SizedBox(
                          width: 60,
                        ),
                        const Text(
                          "Translation",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0360E0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SingleChildScrollView(
                      child: PhysicalModel(
                        color: Colors.white,
                        elevation: 3,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 251, 251, 251),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(20),
                          child: SelectableText(
                              textAlign: TextAlign.center,
                              widget.cubit.textAftertrans!),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                onPressed: () async {
                  //!function play the text after translate
                  await play(
                      language: widget.cubit.tolanguage ?? "en",
                      tts: tts,
                      text: widget.cubit.textAftertrans!);
                },
                shape: const CircleBorder(),
                backgroundColor: const Color(0xFF0360E0),
                label: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              FloatingActionButton.extended(
                onPressed: () {
                  tts.pause();
                },
                shape: const CircleBorder(),
                backgroundColor: const Color(0xFF0360E0),
                label: const Icon(
                  Icons.pause,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//function to extract text
}

// class PlayPauseButton extends StatefulWidget {
//   final Function()? onPause;
//   final Function()? onPlay;

//   const PlayPauseButton({Key? key, this.onPause, this.onPlay})
//       : super(key: key);

//   @override
//   _PlayPauseButtonState createState() => _PlayPauseButtonState();
// }

// class _PlayPauseButtonState extends State<PlayPauseButton> {
//   bool isPaused = false;

//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       onPressed: () {
//         setState(() {
//           isPaused = !isPaused;
//           if (isPaused) {
//             widget.onPause?.call();
//           } else {
//             widget.onPlay?.call();
//           }
//         });
//       },
//       child: Icon(isPaused ? Icons.pause : Icons.play_arrow),
//     );
//   }
// }

// floatingActionButton: PlayPauseButton(
//           onPause: () {
//             tts.pause();
//           },
//           onPlay: () async {
//             await play(
//               language: widget.cubit.tolanguage ?? "en",
//               tts: tts,
//               text: widget.cubit.textAftertrans!,
//             );
//           },
//         ),