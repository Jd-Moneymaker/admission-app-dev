import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../style/style.dart';

class CustomTextfield extends StatefulWidget {
  final String type;
  final String title;
  final String hintText;
  final TextEditingController controller;

  final String? data;

  const CustomTextfield(
      {super.key,
      required this.hintText,
      required this.type,
      required this.title,
      required this.controller,
      this.data});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  // * var to show and hide password
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case 'emailField':
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.title,
                  style: textBoldB,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 60,
                child: TextFormField(
                  controller: widget.controller,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.emailAddress,

                  // ! validation
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('.com')) {
                      return 'enter valid email';
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 15),
                    hintText: widget.hintText,
                    hintStyle: textfieldText,
                  ),
                  // controller: cpfcontroller,
                ),
              ),
            ],
          ),
        );

      // ! phone
      case 'phoneField':
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.title,
                  style: textBoldB,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: widget.controller,
                cursorColor: Colors.black,
                // * numbers keyboard
                keyboardType: TextInputType.number,
                // * max length at 10 digits
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                // ! validation
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  } else if (value.length < 10) {
                    return 'Please enter valid phone number';
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
                  hintText: widget.hintText,
                  hintStyle: textfieldText,
                ),
                // controller: cpfcontroller,
              ),
            ],
          ),
        );

      // ! password
      case 'passwordField':
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.title,
                  style: textBoldB,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: widget.controller,
                cursorColor: Colors.black,

                autocorrect: false,
                enableSuggestions: false,
                // ! shows and hides password
                obscureText: _obscureText,
                // ! validation
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  } else if (value.length < 6) {
                    return 'password has to be atlease 6 letters';
                  }
                  return null;
                },
                // ! validation
                decoration: InputDecoration(
                  // ! shows and hides password
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    // ! shows and hides password
                    // * makes icon smaller
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(
                        _obscureText
                            ? 'assets/png_assets/visibility_on.png'
                            : 'assets/png_assets/visibility_off.png',
                        height: 28,
                        width: 28,
                      ),
                    ),
                  ),
                  // ! shows and hides password

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
                  hintText: widget.hintText,
                  hintStyle: textfieldText,
                ),

                // controller: cpfcontroller,
              ),
            ],
          ),
        );
      // ! password

      // ! name

      case 'nameField':
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.title,
                  style: textBoldB,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 60,
                child: TextFormField(
                  controller: widget.controller,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.name,

                  // ! validation
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter valid name';
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 15),
                    hintText: widget.hintText,
                    hintStyle: textfieldText,
                  ),
                  // controller: cpfcontroller,
                ),
              ),
            ],
          ),
        );

      // ! name

      // ! bio

      case 'bioField':
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.title,
                  style: textBoldB,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                child: TextFormField(
                  controller: widget.controller,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,

                  // ! validation
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter valid bio';
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 15),
                    hintText: widget.hintText,
                    hintStyle: textfieldText,
                  ),
                  // controller: cpfcontroller,
                ),
              ),
            ],
          ),
        );

// ! bio

      default:
        return (const Text('error'));
    }
  }
}
