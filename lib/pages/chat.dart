import 'package:chat_app/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import '../component/chatBubble.dart';
import '../component/messageModel.dart';

class chat extends StatelessWidget {
  final ScrollController _controller = ScrollController();

  final String documentId;
  chat({super.key, required this.documentId});

   TextEditingController controller = TextEditingController();
   CollectionReference messages = FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
   String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
       stream: messages.orderBy('createdAt',descending: true).snapshots(),
        builder: (context, snapshot) {
          List <Message> messageList = [];
          for(int i = 0 ; i < snapshot.data!.docs.length ; i++)
            {
              messageList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
         if(snapshot.hasData)
           {
             return Scaffold(
               appBar: AppBar(
                 automaticallyImplyLeading: false,
                 backgroundColor: primaryColor,
                 title: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Image.asset('img/chat.jpg',height: 20,),
                     const SizedBox(width: 5,),
                     const Text('Chat',style: TextStyle(color: Colors.white),)
                   ],
                 ),
               ),
               body: Column(
                 children: [
                   Expanded(
                     child: ListView.builder(
                       reverse: true,
                       controller: _controller,
                       itemCount: messageList.length,itemBuilder: (context, index) {
                       return messageList[index].id == email ? chatBubble(message: messageList[index],) : chatBubbleforFriend(message: messageList[index]);
                     },),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(10),
                     child: TextField(
                         controller: controller,
                         onSubmitted: (data) {
                           messages.add(
                               {
                                 'message':data,
                                 'createdAt' : DateTime.now(),
                                 'id' : email
                               }
                           );
                           controller.clear();
                           _controller.animateTo(
                             0,
                             duration: const Duration(seconds: 3),
                             curve: Curves.fastOutSlowIn,
                           );
                         },
                         decoration: InputDecoration(
                             suffixIcon: IconButton(icon: const Icon(Icons.send,color: primaryColor,),onPressed: () {},),
                             hintText: 'Send Message',
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(20),
                                 borderSide: const BorderSide(
                                     color: primaryColor
                                 )
                             ),
                             enabledBorder:  OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(20),
                                 borderSide: const BorderSide(
                                     color: primaryColor
                                 )
                             )
                         )
                     ),
                   ),
                 ],
               ),
             );
           }
         else
           {
             return const Text('Loading...');
           }
        },
    );
  }
}


