import 'package:flutter/material.dart';

import '../../../style/style.dart';

class AddContactBtn extends StatelessWidget {
  const AddContactBtn({super.key});

  @override
  Widget build(BuildContext context) => Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add new contact',
                        style: textBoldB,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Contacts are automatically \nstored and backed up in the cloud ...  ',
                        style: textSmallB,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
