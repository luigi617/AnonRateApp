import 'dart:io';

import 'package:flutter/material.dart';

import "package:images_picker/images_picker.dart";
import 'package:image_cropper/image_cropper.dart' as cropper;

class ImagePicker {
  static Future getImage() async {
    List<Media>? res = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.image,
    );
    if (res == null){
      return null;
    }
    return res[0];
  }
  static Future getMultipleImages(int count) async {
    List<Media>? res = await ImagesPicker.pick(
      count: count,
      pickType: PickType.image,
    );
    return res;
  }
  static Future getCameraPhoto() async {
    List<Media>? res = await ImagesPicker.openCamera(
      pickType: PickType.image,
    );
    if (res == null){
      return null;
    }
    return res;
  }
  static Future avatarCropper(String imagePath) async {
    return cropper.ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: [
        cropper.CropAspectRatioPreset.square,
      ],
      aspectRatio: const cropper.CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      uiSettings: [
        cropper.AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: cropper.CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
        cropper.IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
  }
  // ImagesPicker.openCamera(
  //   pickType: PickType.video,
  //   maxTime: 15, // record video max time
  // );
}

Future imagePickerModal(BuildContext context, {bool avatar = false}){
  return showModalBottomSheet(
  context: context,
  builder: (context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.camera),
          title: const Text('Camera'),
          onTap: () async{
            Media image = await ImagePicker.getCameraPhoto();
            if (avatar){
              cropper.CroppedFile? img = await ImagePicker.avatarCropper(image.path);
              Navigator.pop(context, img);
              return;
            }
            Navigator.pop(context, image);
          },
        ),
        ListTile(
          leading: const Icon(Icons.photo),
          title: const Text('Choose from Album'),
          onTap: () async{
            Media image = await ImagePicker.getImage();

            if (avatar){
              cropper.CroppedFile? img = await ImagePicker.avatarCropper(image.path);
              Navigator.pop(context, img);
              return;
            }
            Navigator.pop(context, image);
            
            
          },
        ),
        Divider(thickness: 1,),
        ListTile(
          leading: const Icon(Icons.cancel),
          title: const Text('Cancel'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(height: 20,)
      ],
    );
  });
}

Future multipleImagesPickerModal(BuildContext context, {imageCount = 9}){
  return showModalBottomSheet(
  context: context,
  builder: (context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.camera),
          title: const Text('Camera'),
          onTap: () async{
            Media image = await ImagePicker.getCameraPhoto();
            List<File> resImages = [];
            resImages.add(File(image.path));
            Navigator.pop(context, resImages);
          },
        ),
        ListTile(
          leading: const Icon(Icons.photo),
          title: const Text('Choose from Album'),
          onTap: () async{
            List<Media>? images = await ImagePicker.getMultipleImages(imageCount);
            List<File> resImages = [];
            if (images != null){
              for (Media img in images){
                resImages.add(File(img.path));
              }
            }
            Navigator.pop(context, resImages);
            
            
          },
        ),
        Divider(thickness: 1,),
        ListTile(
          leading: const Icon(Icons.cancel),
          title: const Text('Cancel'),
          onTap: () {
            Navigator.pop(context, []);
          },
        ),
        const SizedBox(height: 20,)
      ],
    );
  });
}