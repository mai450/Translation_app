import 'package:extract_text/cubit/selct_language_cubit.dart';
import 'package:extract_text/screens/recognize_page.dart';
import 'package:extract_text/widget/droupdowento.dart';
import 'package:extract_text/widget/droupdownfrom.dart';
import 'package:extract_text/widget/image_crop.dart';
import 'package:extract_text/widget/image_picker.dart';
import 'package:extract_text/widget/model_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<SelctLanguageCubit>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(234, 255, 255, 255),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Extract Text',
                style: TextStyle(
                    fontSize: 26,
                    color: Color.fromARGB(255, 68, 68, 68),
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                'From Your Image',
                style: TextStyle(
                    fontSize: 26,
                    color: Color.fromARGB(255, 68, 68, 68),
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 50,
              ),
              PhysicalModel(
                color: Colors.white60,
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 251, 251, 251),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.swap_vert_outlined),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownMenuLanguageFrom(),
                            const SizedBox(
                              height: 5,
                            ),
                            const DroupDownLangageTo(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                    color: const Color(0xFF0360E0),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                          onPressed: () {
                            imagePickerModal(
                              context,
                              onCameraTap: () {
                                //pick image and return path image
                                pickImage(source: ImageSource.camera)
                                    .then((value) {
                                  if (value != '') {
                                    //crop image and retern path crop image
                                    imageCropperView(value, context)
                                        .then((value) {
                                      if (value != '') {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (_) => RecognizePage(
                                              path: value,
                                              cubit: cubit,
                                            ),
                                          ),
                                        );
                                      }
                                    });
                                  }
                                });
                              },
                              onGalleryTap: () {
                                pickImage(source: ImageSource.gallery)
                                    .then((value) {
                                  if (value != '') {
                                    imageCropperView(value, context)
                                        .then((value) {
                                      if (value != '') {
                                        Navigator.push(
                                          context,
                                          //like ios
                                          CupertinoPageRoute(
                                            builder: (_) => RecognizePage(
                                              path: value,
                                              cubit: cubit,
                                            ),
                                          ),
                                        );
                                      }
                                    });
                                  }
                                });
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Color(0xFF0360E0),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Upload Image',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(247, 255, 255, 255),
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'You can upload your image from Gallery or Scanning with your camera',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 230, 230, 230),
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
