import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayertti/models/user.dart';
import '../constants.dart';
import '../language.dart';
FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  final texts = toMap(); // les donnees en format MAP
  final messageTextController = TextEditingController();
  String messageText;


  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: kAppBar(() => Navigator.pop(context), _width, _height,
          texts[languages[language]]['support']),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: _height * 0.751,
                child: Column(
                  children: [
                    MessagesStream(),
                  ],
                )),
            Container(
              color: Colors.white,
              height: _height * 0.1,
              child: Padding(
                padding: EdgeInsets.only(left: _width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: _width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 2,
                        ),
                        child: TextField(
                          controller: messageTextController,
                          onChanged: (value){
                            setState(() {
                              messageText=value;
                            });
                          },
                          textAlign:
                              language == 0 ? TextAlign.left : TextAlign.right,
                          cursorColor: Color(0xff707070),
                          style: TextStyle(color: Color(0xff707070)),
                          decoration: new InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.only(
                                top: 20,
                                left: _width * 0.05,
                                right: _width * 0.05),
                            hintText: language == 0 ? "Ecrire..." : "اأكتب...",
                            hintStyle: new TextStyle(color: Color(0xff707070)),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide:
                                    new BorderSide(color: Color(0xff707070))),
                            focusedBorder: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide:
                                    new BorderSide(color: Color(0xff707070))),
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        messageTextController.clear();
                        _fireStore.collection('chat').doc(User.chatId).collection('messages').add({
                          'message': messageText,
                          'sender':1,
                          'senderID':User.id,
                          'timeStamp':DateTime.now()
                        });
                      },
                      iconSize: 30.0,
                      padding: EdgeInsets.only(right: _width * 0.05),
                      icon: Icon(
                            Icons.send_rounded,
                          size: _width * 0.09,
                          color: Colors.black,
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('chat').doc(User.chatId).collection('messages').orderBy("timeStamp").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.redAccent,
            ),
          );
        }
        final messages =  snapshot.data.docs;
        List<Widget> messageBubbles = [];
        for (var message in messages) {
          final messageText =  message['message'];
          final messageSender = message['sender'];
          final messageBubble= messageSender==0?
          kSupportMessage(height,width,messageText):
              kUserMessage(height, width, messageText);


          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

