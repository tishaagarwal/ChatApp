// import 'dart:html';

import 'package:chatapp/components/chat_bubble.dart';
import 'package:chatapp/components/my_text_fields.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiveruserEmail;
  final String receiverUserID;
  const ChatPage({super.key,required this.receiveruserEmail,required this.receiverUserID,});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async{
    if (_messageController.text.isNotEmpty){
      await _chatService.sendMessage(
        widget.receiverUserID, _messageController.text
      );
      _messageController.clear() ;
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiveruserEmail),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(),
          ),
          _buildMessageInput(),
          SizedBox(height: 21),
        ],
        
      ),
    );
  }
  Widget  _buildMessageList(){
    return StreamBuilder(
      stream: _chatService.getMessages (
        widget.receiverUserID,_firebaseAuth.currentUser!.uid
        ),
        builder: (context,snapshot){
          if (snapshot.hasError){
            return Text('Error${snapshot.error}');
          }
          if (snapshot.connectionState ==  ConnectionState.waiting){
            return Text('loading....');
          }
          return ListView(
            children: snapshot.data!.docs
            .map((document) => _buildMessageItem(document))
            .toList(),
          );
        },
      );
  }


  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String,dynamic> data = document.data()! as Map<String,dynamic>;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid ) 
    ? Alignment.centerRight
    : Alignment.centerLeft;

    return  Container(
      alignment: alignment,
      padding: EdgeInsets.all(21),
      child: Column(
        crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid) ? CrossAxisAlignment.end:CrossAxisAlignment.start,
        mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid) ?MainAxisAlignment.end: MainAxisAlignment.start ,
        children: [
          Text(data['senderEmail']),
          SizedBox(height: 6,),
          // Text(data['message']),
          ChatBubble(message:data['message']),
        ],
      ),
    );
  }


  Widget _buildMessageInput(){
    return Row(
      children: [
        Expanded(
          child: MyTextField(
            controller: _messageController,
            hintText: 'Enter Message',
            obscureText: false,
          )
        ),
        IconButton(onPressed: sendMessage, icon: Icon(Icons.send,size: 50,))
      ],
    );
  }
}
