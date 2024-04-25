import 'package:flutter/material.dart';

import '../../style/style.dart';

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    super.key,
    required this.type,
    required this.title,
    required this.hintText,
    required this.controller,
    this.data,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final String? data;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title,
              style: textBoldB,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            child: TextFormField(
              controller: controller,
              cursorColor: Colors.black,
              keyboardType:
                  type == 'bio' ? TextInputType.multiline : TextInputType.name,
              maxLines: type == 'bio' ? 5 : 1,

              // ! validation
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'enter valid $type';
                }
                return null;
              },
              // ! validation
              decoration: InputDecoration(
                // * adds border radius without adding black border arounf widget
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                isDense: true,
                filled: true,
                fillColor: const Color.fromARGB(18, 0, 0, 5),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                hintText: hintText,
                hintStyle: textfieldText,
              ),
              // controller: cpfcontroller,
            ),
          ),
        ],
      ),
    );
    // ! name
  }
}
