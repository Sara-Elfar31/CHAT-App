import 'package:flutter/material.dart';

import '../pages/login.dart';
import 'messageModel.dart';
class chatBubble extends StatelessWidget {
  const chatBubble({required this.message ,super.key,});
 final Message message ;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
        padding: const EdgeInsets.only(left: 14,top: 16,bottom: 16,right: 16),
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32)
            )
        ),
        child:Text(message.message,style: const TextStyle(
            color: Colors.white
        ),),
      ),
    );
  }
}

class chatBubbleforFriend extends StatelessWidget {
  const chatBubbleforFriend({required this.message ,super.key,});
  final Message message ;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
        padding: const EdgeInsets.only(left: 14,top: 16,bottom: 16,right: 16),
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomLeft: Radius.circular(32)
            )
        ),
        child:Text(message.message,style: const TextStyle(
            color: Colors.white
        ),),
      ),
    );
  }
}