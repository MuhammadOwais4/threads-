import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationDialog extends StatelessWidget {
  final primaryColor = const Color(0xff4338CA);
  final accentColor = const Color(0xffffffff);
  final String title;
  final String message;
  final VoidCallback callback;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
            color: const Color(0xff242424),
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 3.5,
            ),
            Text(
              message,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimpleBtn1(
                  text: "Cancel",
                  onPressed: () => Get.back(),
                  invertedColors: true,
                ),
                SimpleBtn1(
                  text: "Yes Continue",
                  onPressed: callback,
                  invertedColors: false,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SimpleBtn1 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool invertedColors;
  final primaryColor = Colors.red;
  final accentColor = const Color(0xffffffff);

  const SimpleBtn1(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.invertedColors});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        alignment: Alignment.center,
        side: BorderSide(
          width: 1,
          color: primaryColor,
        ),
        padding: const EdgeInsets.only(
          right: 25,
          left: 25,
          top: 0,
          bottom: 0,
        ),
        backgroundColor: invertedColors ? accentColor : primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: invertedColors ? primaryColor : accentColor,
          fontSize: 16,
        ),
      ),
    );
  }
}
