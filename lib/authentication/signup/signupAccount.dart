import 'dart:io';

import 'package:anon_rate_app/api/request.dart';
import 'package:anon_rate_app/constants.dart';
import 'package:anon_rate_app/widget/ImagePickerModal.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SignUpAccountPage extends StatefulWidget {
  const SignUpAccountPage({
    required this.id,
    Key? key
  }) : super(key: key);

  final int id;

  @override
  State<SignUpAccountPage> createState() => SignUpAccountPageState();
}

class SignUpAccountPageState extends State<SignUpAccountPage> {
  File? avatar;
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Center(child:Text("Account information", style: TextStyle(fontSize: TextStyleFeature.textLargeSize),)),
              const SizedBox(height: 30,),
              Center(
                child: InkWell(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.0),
                    child: avatar == null
                    ? CachedNetworkImage(
                      imageUrl: "https://via.placeholder.com/100",
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      height: 100,
                      width: 100,
                    )
                    : Image.file(
                      avatar!,
                      width: 100,
                      height: 100,
                    )
                    ,

                  ),
                  onTap: () async{
                    dynamic image = await imagePickerModal(context, avatar: true);
                    if (image != null){
                      setState(() {
                        avatar = File(image.path);
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 30,),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: lastNameController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(),
                        hintText: "Last name"
                      ),
                      validator: (String? value) {
                        return null;
                      
                      },
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: TextFormField(
                      controller: firstNameController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(),
                        hintText: "First name"
                      ),
                      validator: (String? value) {
                        return null;
                      
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(),
                        hintText: "Email"
                      ),
                      validator: (String? value) {
                        return null;
                      
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal:10),
                        child: Text('Create Account', style: TextStyle(fontSize: TextStyleFeature.textLargeSize),)
                      ),
                      onPressed: () async {
                        FormData formData = FormData.fromMap({
                          "last_name": lastNameController.text,
                          "first_name": firstNameController.text,
                          "avatar": await MultipartFile.fromFile(avatar!.path),
                        });
                        await httpUtil().put(
                          "/user/profile/${widget.id}/",
                          data: formData
                        );
                        Navigator.of(context).pushNamedAndRemoveUntil("/home/", (Route<dynamic> route) => false);
                      },
                    )
                  ),
                ]
              ),
              
            ]
          )
        )
      ),
      
    );
  }
}


