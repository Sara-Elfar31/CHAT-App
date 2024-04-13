
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../component/textField.dart';

const Color primaryColor =  Color(0xff1a75bc) ;

class Login extends StatefulWidget {

   Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email ;

  String? password ;

   bool isLoading = false ;

   GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: primaryColor ,
        body: Form(
          key:formKey,
          child: ListView(
            children: [
              Image.asset('img/chat.jpg'),
              const Center(
                child: Text('Chat App',style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,

                ),),
              ),
              const SizedBox(height: 80,),
              const Padding(
                padding: EdgeInsets.only(left: 16,bottom: 16),
                child: Text('Login',style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 16),
                child: textField(
                  hint: 'Email',
                  onChange: (val) {
                  email = val ;
                },) ,
              ),
              const SizedBox(height: 20,),
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 16),
                child: textField(hint: 'Password',onChange: (val) {
                  password = val ;
                },),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true ;
                      });
                      try {
                        var auth = FirebaseAuth.instance;
                        UserCredential user  = await auth.signInWithEmailAndPassword(email: email!, password: password!);
                        Navigator.pushNamed(context, 'chat',arguments: email);
                      } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found')
                        {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No user found for that email')));
                        }
                      else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                      }catch(e)
                    {
                      print(e);
                    }
                      setState(() {
                        isLoading =false ;
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: Text('Login',style: TextStyle(color: primaryColor),)),
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account ?',style: TextStyle(
                      color: Colors.white
                  ),),
                  const SizedBox(width: 5,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'Register');
                    },
                    child: const Text('Register',style: TextStyle(
                        color: Color(0xff13507f),
                        fontWeight: FontWeight.bold
                    )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
