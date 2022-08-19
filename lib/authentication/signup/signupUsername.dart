import 'package:anon_rate_app/api/request.dart';
import 'package:anon_rate_app/constants.dart';
import 'package:anon_rate_app/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SignUpUsernamePage extends StatefulWidget {
  const SignUpUsernamePage({Key? key}) : super(key: key);

  @override
  State<SignUpUsernamePage> createState() => SignUpUsernamePageState();
}

class SignUpUsernamePageState extends State<SignUpUsernamePage> {
  final TextEditingController usernameController = TextEditingController();
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Container(),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Center(child:Text("Create an username", style: TextStyle(fontSize: TextStyleFeature.textLargeSize),)),
              const SizedBox(height: 50,),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        border: const OutlineInputBorder(),
                        hintText: "Username",
                        errorText: errorText,
                      ),
                      
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
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
                        child: Text('Continue', style: TextStyle(fontSize: TextStyleFeature.textLargeSize),)
                      ),
                      onPressed: () async {
                        if (usernameController.text.length == 0){
                          setState(() {
                            errorText = "Please, choose an username";
                          });
                          return;
                        }
                        Response response = await httpUtil().post(
                          "/username-verification/",
                          data: {
                            "username": usernameController.text
                          }
                        );
                        if (response.data["available"] == true){
                          Navigator.pushNamed(
                            context, "/signup/password/",
                            arguments: {"username": usernameController.text}
                          );
                        } else {
                          setState(() {
                            errorText = response.data["message"];
                          });
                        }
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


