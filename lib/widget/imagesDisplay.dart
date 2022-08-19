import 'dart:io';
import 'package:anon_rate_app/widget/ImagePickerModal.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostImagesAddSection extends StatefulWidget {
  const PostImagesAddSection(
    this.images,
    {required this.onChangeImages,
      Key? key}
  ) : super(key: key);
  final List<File> images;
  final Function(List<File>) onChangeImages;

  @override
  State<PostImagesAddSection> createState() => PostImagesAddSectionState();
}
class PostImagesAddSectionState extends State<PostImagesAddSection> {
  List<File> currentImages = [];

  @override
  void initState() {
    super.initState();
    currentImages = widget.images;
  }

  @override
  Widget build(BuildContext context) {
    return imagesAddDisplay();
  }


  Widget imagesAddDisplay(){
    Widget res = GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: currentImages.length < 9 ? currentImages.length + 1 : currentImages.length,
      itemBuilder: (BuildContext ctx, index) {
        if (index == currentImages.length){
          return InkWell(
            child:Container(
              decoration: BoxDecoration(
                border: Border.all()
              ),
              width: 100,
              height: 100,
              child: const Center(
                child: Icon(
                  Icons.add_a_photo_outlined
                ),
              ),
            ),
            onTap: () async{
              List<File> images = await multipleImagesPickerModal(context, imageCount: 9 - currentImages.length);
              if (images.isNotEmpty){
                setState(() {
                  currentImages.addAll(images);
                });
              }
              widget.onChangeImages(currentImages);
            },
          );
        }
        return image(currentImages[index]);
      }
    );
    return res;
  }

  Widget image(File file){
    return Image.file(
      file,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    );
  }
}


class PostImagesDisplay extends StatelessWidget {
  const PostImagesDisplay(this.images, {Key? key}) : super(key: key);
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: (images.length == 4) ? images.length + 1 : images.length,
      itemBuilder: (BuildContext ctx, index) {
        if (images.length == 4 && index == 2){
          return Container();
        } else if (images.length == 4 && index > 2){
          return image(images[index - 1]);
        }
        return image(images[index]);
      }
    );
  }
  

  Widget image(String url){
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      height: 50,
      width: 50,
      fit: BoxFit.cover,
    );
  }
}
