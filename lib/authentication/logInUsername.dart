import 'package:anon_rate_app/api/request.dart';
import 'package:anon_rate_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:anon_rate_app/widget/appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LogInUsernamePage extends StatefulWidget {
  const LogInUsernamePage({Key? key}) : super(key: key);

  @override
  State<LogInUsernamePage> createState() => _LogInUsernamePageState();
}

class _LogInUsernamePageState extends State<LogInUsernamePage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100,),
              const Center(child:Text("AnonRate", style: TextStyle(fontSize: TextStyleFeature.textXLargeSize, fontWeight: TextStyleFeature.boldTextWeight))),
              const SizedBox(height: 50,),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(),
                        hintText: "Username, email address"
                      ),
                      validator: (String? value) {
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
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
                        if (value.toString().trim().isEmpty) {
                          return 'Password is required';
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: (){
                    
                  },
                  child: Text("Forgotten password?", style: TextStyle(color: Palette.blue),)
                ),
              ),
              SizedBox(height: 20,),

              Center(
                child: Container(
                  width: 200,
                  margin: const EdgeInsets.only(bottom: 50),
                  child: ElevatedButton(
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal:10),
                      child: Text('Log In', style: TextStyle(fontSize: TextStyleFeature.textLargeSize),)
                    ),
                    onPressed: () {
                      AccessToken.logInToken(usernameController.text, passwordController.text);
                      Navigator.popAndPushNamed(context, "/home/");
                    },
                  )
                ),
              ),
              Row(
                children: const [
                  Expanded(
                      child: Divider()
                  ),
                  SizedBox(width: 10,),       
                  Text("OR", style: TextStyle(fontSize: TextStyleFeature.textXSmallSize),),
                  SizedBox(width: 10,),       

                  Expanded(
                      child: Divider()
                  ),
                ]
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Do not have an account? "),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, "/signup/username/");
                    },
                    child: Text("Sign up", style: TextStyle(color: Palette.blue),)
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


