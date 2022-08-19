import 'dart:io';

import 'package:anon_rate_app/api/post.dart';
import 'package:anon_rate_app/api/request.dart';
import 'package:anon_rate_app/constants.dart';
import 'package:anon_rate_app/widget/appbar.dart';
import 'package:anon_rate_app/widget/imagesDisplay.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import "package:images_picker/images_picker.dart";
import 'package:cached_network_image/cached_network_image.dart';


class PostCreationPage extends StatefulWidget {
  const PostCreationPage({Key? key}) : super(key: key);

  @override
  State<PostCreationPage> createState() => PostCreationPageState();
}

class PostCreationPageState extends State<PostCreationPage> {
  List<File> images = [];
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Container(),
        automaticallyImplyLeading: true,
        elevation: 0,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
            margin: const EdgeInsets.only(right: 5),
            child: ElevatedButton(
            onPressed: () async{
              List<MultipartFile> processedImages = [];
              for (File img in images){
                processedImages.add(await MultipartFile.fromFile(img.path));
              }
              await PostAPI.createPost(contentController.text, processedImages);
              Navigator.pop(context);
              
            },
            child: const Text("Post")
          ),
          )
          
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: contentController,
                      decoration: const InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none,
                        hintText: "Write something...",
                      ),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Content cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 1,),
              const SizedBox(height: 20,),

              PostImagesAddSection(
                images,
                onChangeImages: (newImages){
                  images = newImages;
                },
              ),
              
            ]
          )
        )
      ),
      
    );
  }
}


