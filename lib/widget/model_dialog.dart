import 'package:flutter/material.dart';

//ui
void imagePickerModal(BuildContext context,
    {VoidCallback? onCameraTap, VoidCallback? onGalleryTap}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          height: MediaQuery.sizeOf(context).height * 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onCameraTap,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 213, 213, 213),
                      shape: BoxShape.circle),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 25),
              GestureDetector(
                onTap: onGalleryTap,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 213, 213, 213),
                      shape: BoxShape.circle),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.image,
                        size: 30,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
