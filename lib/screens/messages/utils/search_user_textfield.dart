import 'package:flutter/material.dart';

import '../../../style/style.dart';

class SearchUserTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final void Function()? onTap;

  const SearchUserTextfield(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        SizedBox(
          height: 60,
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.white,
            keyboardType: TextInputType.emailAddress,

            // ! search button

            // ! search button

            // ! validation
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please enter user';
              }
              return null;
            },
            // ! validation
            decoration: InputDecoration(
              suffixIconConstraints: const BoxConstraints(
                minWidth: 45,
                minHeight: 45,
              ),
              suffixIcon: GestureDetector(
                onTap: onTap, // Call the onTap function
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),

              // * adds border radius without adding black border arounf widget
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              errorBorder: InputBorder.none,
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
              hintText: hintText,
              hintStyle: textBoldB,
            ),
            // controller: cpfcontroller,
          ),
        ),
      ],
    );
  }
}
