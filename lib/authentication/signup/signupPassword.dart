import 'package:anon_rate_app/api/request.dart';
import 'package:anon_rate_app/api/user.dart';
import 'package:anon_rate_app/constants.dart';
import 'package:anon_rate_app/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SignUpPasswordPage extends StatefulWidget {
  const SignUpPasswordPage({
    required this.username,
    Key? key
  }) : super(key: key);

  final String username;

  @override
  State<SignUpPasswordPage> createState() => SignUpPasswordPageState();
}

class SignUpPasswordPageState extends State<SignUpPasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  
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

              const Center(child:Text("Set the password", style: TextStyle(fontSize: TextStyleFeature.textLargeSize),)),
              const SizedBox(height: 50,),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(),
                        hintText: "Password"
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
                        child: Text('Continue', style: TextStyle(fontSize: TextStyleFeature.textLargeSize),)
                      ),
                      onPressed: () async {
                        Response response = await httpUtil().post(
                          "/user-creation/",
                          data: {
                            "username": widget.username,
                            "password": passwordController.text,
                          }
                        );
                        // AccessToken.logInToken(widget.username, passwordController.text);
                        UserAPI.logIn(widget.username, passwordController.text);

                        Navigator.pushNamed(context, "/signup/account/", arguments: {"id": response.data["id"]});
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


