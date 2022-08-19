import 'dart:io';

import 'package:anon_rate_app/api/post.dart';
import 'package:anon_rate_app/api/rating.dart';
import 'package:anon_rate_app/api/request.dart';
import 'package:anon_rate_app/constants.dart';
import 'package:anon_rate_app/widget/appbar.dart';
import 'package:anon_rate_app/widget/imagesDisplay.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import "package:images_picker/images_picker.dart";
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class RatingCreationPage extends StatefulWidget {
  final int recepientId;
  const RatingCreationPage({required this.recepientId, Key? key}) : super(key: key);

  @override
  State<RatingCreationPage> createState() => RatingCreationPageState();
}

class RatingCreationPageState extends State<RatingCreationPage> {
  TextEditingController contentController = TextEditingController();
  double rating = 0;

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
              int intRating = (rating*20).toInt();
              await RatingAPI.createRating(
                contentController.text,
                widget.recepientId,
                intRating
              );
              Navigator.pop(context);
            },
            child: const Text("Rate")
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
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemSize: 20,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      this.rating = rating;
                    },
                  ),
                  const SizedBox(width: 5,),
                  const Text("Tap to rate"),

                ],
              ),
              const SizedBox(height: 20,),
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

              
              
            ]
          )
        )
      ),
      
    );
  }
}


