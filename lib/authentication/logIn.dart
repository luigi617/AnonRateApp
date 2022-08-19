import 'package:anon_rate_app/api/user.dart';
import 'package:anon_rate_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class LogInUsernamePage extends StatefulWidget {
  const LogInUsernamePage({Key? key}) : super(key: key);

  @override
  State<LogInUsernamePage> createState() => _LogInUsernamePageState();
}

class _LogInUsernamePageState extends State<LogInUsernamePage> {
  final TextEditingController usernameController = TextEditingController();
  String? usernameError;
  final TextEditingController passwordController = TextEditingController();
  String? passwordError;
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
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: usernameError == null ? const Color(0xFF000000) : Theme.of(context).errorColor,
                            width: usernameError == null ? 0.4 : 1,
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: usernameError == null ? const Color(0xFF000000) : Theme.of(context).errorColor,
                            width: usernameError == null ? 0.4 : 1,
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: usernameError == null ? const Color(0xFF000000) : Theme.of(context).errorColor,
                            width: usernameError == null ? 0.4 : 1,
                          )
                        ),
                        hintText: "Username, email address",
                        // errorText: usernameError,
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
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        border: const OutlineInputBorder(),
                        hintText: "Password",
                        errorText: passwordError,
                        // errorBorder: 
                      ),
                      validator: (String? value) {
                        if (value.toString().trim().isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: (){
                    
                  },
                  child: const Text("Forgotten password?", style: TextStyle(color: Palette.blue),)
                ),
              ),
              const SizedBox(height: 20,),

              Center(
                child: Container(
                  width: 200,
                  margin: const EdgeInsets.only(bottom: 50),
                  child: ElevatedButton(
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal:10),
                      child: Text('Log In', style: TextStyle(fontSize: TextStyleFeature.textLargeSize),)
                    ),
                    onPressed: () async {
                      try {
                        await UserAPI.logIn(usernameController.text, passwordController.text);
                      } on DioError catch(e){
                        if (e.response != null) {
                          if (e.response?.data["error"] == "invalid_grant" || e.response?.data["error"] == "invalid_request"){
                            setState(() {
                              usernameError = "";
                              passwordError = e.response?.data["error_description"];
                            });
                          }
                        }
                        return;
                      }

                      // AccessToken.logInToken(usernameController.text, passwordController.text);
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
                  const Text("Do not have an account? "),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, "/signup/username/");
                    },
                    child: const Text("Sign up", style: TextStyle(color: Palette.blue),)
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


