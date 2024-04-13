import 'package:flutter/material.dart';

class textField extends StatelessWidget {
  textField({this.onChange,this.hint});
  String? hint ;
  Function(String)? onChange ;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      validator: (value) {
       if(value!.isEmpty)
         {
           return 'Field is required' ;
         }
      },
      onChanged: onChange,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
              color: Colors.white
          ),
          prefixIcon: const Icon(Icons.email,color: Colors.white,),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          )
      ),
    );
  }
}
