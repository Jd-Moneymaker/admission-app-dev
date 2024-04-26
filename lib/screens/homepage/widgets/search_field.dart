import 'package:flutter/material.dart';

class HomepageSearchField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon prefix;
  final IconButton? suffix;
  final void Function()? onPressed;

  const HomepageSearchField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.prefix,
      this.suffix,
      this.onPressed});

  @override
  State<HomepageSearchField> createState() => _HomepageSearchFieldState();
}

class _HomepageSearchFieldState extends State<HomepageSearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        onChanged: (value) => setState(() {}),
        // ! adds styling
        decoration: InputDecoration(
          filled: true, //<-- SEE HERE
          fillColor: Colors.white,
          // ! changes border when validation is wrong
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.5,
            ),
          ),
          errorStyle: const TextStyle(height: 0, color: Colors.black),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.5,
            ),
          ),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.5),
          ),
          hintText: widget.hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: widget.prefix,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            // ! hides clear button from search field. and shows it whenn text is entered
            child: widget.controller.text.isEmpty
                ? null
                : IconButton(
                    onPressed: widget.onPressed,
                    icon: const Icon(Icons.clear),
                  ),
          ),
        ),
      ),
    );
  }
}
