import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../style/style.dart';

class UploadUserImage extends StatefulWidget {
  final double? width;
  final double? height;
  final bool coverPic;
  const UploadUserImage(
      {super.key, this.width, this.height, required this.coverPic});

  @override
  State<UploadUserImage> createState() => _UploadUserImageState();
}

class _UploadUserImageState extends State<UploadUserImage> {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  File? imageUrl;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return const Placeholder();
      final imageTemporary = File(image.path);
      setState(() => imageUrl = imageTemporary);

      String updateType =
          widget.coverPic != false ? 'coverPic.jpg' : 'profilePic.jpg';

      final imageType = widget.coverPic != false ? 'coverPic' : 'profilePic';

      // * this line below uploads the image to firebase Storage
      TaskSnapshot uploadImage = await FirebaseStorage.instance
          .ref()
          .child('images')
          .child(uid)
          .child(updateType)
          .putFile(imageTemporary);
      log('$updateType uploaded');

      // * this gets the download url
      String downloadUrl = await uploadImage.ref.getDownloadURL();
      // * this gets the download url

      log(downloadUrl);

      // * this updates user document's cover and profile pic wit new url
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
        imageType: downloadUrl,
      });
      log('$updateType updated in user document');
    } catch (error) {
      log("error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        imageUrl != null
            ? Image.file(
                imageUrl!,
                fit: BoxFit.cover,
                width: widget.width,
                height: widget.height,
              )
            : Container(),
        widget.coverPic == false
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, elevation: 0),
                onPressed: () {
                  pickImage();
                },
                child: Image.asset(
                  'assets/png/user.png',
                  color: Colors.white,
                  height: 32,
                  width: 32,
                  fit: BoxFit.cover,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, elevation: 0),
                    onPressed: () {
                      pickImage();
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "upload photo",
                          style: textBoldW,
                        )
                      ],
                    ),
                  ),
                ],
              )
      ],
    );
  }
}
