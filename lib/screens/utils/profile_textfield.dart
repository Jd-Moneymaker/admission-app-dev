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
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
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
            // ? so every textfield , dropdown n date picker is uniform height

            SizedBox(
              child: TextFormField(
                controller: controller,
                cursorColor: Colors.black,
                keyboardType: type == 'bio'
                    ? TextInputType.multiline
                    : TextInputType.name,
                maxLines: type == 'bio' ? 3 : 1,

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
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
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
      ),
    );
    // ! name
  }
}

class DropDownSelector extends StatefulWidget {
  const DropDownSelector(
      {super.key,
      required this.title,
      required this.hintText,
      required this.onGenderSelected});

  final String title, hintText;
  final Function(String) onGenderSelected;
  // ? Declare the callback function type here

  @override
  State<DropDownSelector> createState() => _DropDownSelectorState();
}

class _DropDownSelectorState extends State<DropDownSelector> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.42,
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
          DropdownButtonFormField<String>(
            value: _selectedGender,
            onChanged: (String? newValue) {
              setState(() {
                _selectedGender = newValue;
              });
              // ? Call the callback function with the selected gender
              widget.onGenderSelected(newValue!);
            },
            items: <String?>['Male', 'Female', 'Other']
                .map<DropdownMenuItem<String>>((String? value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value ?? ''),
              );
            }).toList(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color.fromARGB(18, 0, 0, 5),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
              hintText: widget.hintText,
              hintStyle: textSmallB,
            ),
          ),
        ],
      ),
    );
  }
}

class DateSelector extends StatefulWidget {
  const DateSelector({
    super.key,
    required this.title,
    required this.onDateSelected,
  });
  final String title;
  final ValueChanged<DateTime> onDateSelected;

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime? selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
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
          width: MediaQuery.of(context).size.width * 0.42,
          child: GestureDetector(
            onTap: () async {
              final DateTime? dateTime = await showDatePicker(
                context: context,
                initialDate: DateTime(2002),
                firstDate: DateTime(1995),
                lastDate: DateTime(3000),
              );
              if (dateTime != null) {
                setState(() {
                  selectedDate = dateTime;
                });
                // Notify parent widget about the selected date
                widget.onDateSelected(dateTime);
              }
            },
            child: TextFormField(
              enabled: false,
              cursorColor: Colors.black,
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
                prefixIcon: const Icon(Icons.calendar_month_rounded),
                hintText:
                    '${selectedDate?.day} / ${selectedDate?.month} / ${selectedDate?.year}',
                hintStyle: textfieldText,
              ),
              // controller: cpfcontroller,
            ),
          ),
        ),
      ],
    );
  }
}
