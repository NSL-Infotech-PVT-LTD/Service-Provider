import 'dart:async';
import 'dart:io';

import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/Chat/ChatModels/ChatHistoryModel.dart';
import 'package:misson_tasker/view/Chat/ChatModels/MessageDemo.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'ChatModels/DashChat2.dart';

class ChatScreen extends StatefulWidget {
  final String reciverName;
  final String image;
  final String receiverId;
  final WebSocketChannel channel;

  const ChatScreen(
      {Key key, this.reciverName, this.image, this.receiverId, this.channel})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

String _auth;

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  List<ChatMessage> listOfMessage = [];
  MessageDemoDart _messageDemoDart;
  ChatHistoryModel chatHistoryModel;
  bool isLoading = true;
  String appUserId;
  String appUserName;

  // final channel2 = IOWebSocketChannel.connect('ws://23.20.179.178:8080/');
  // final ChatUser user = ChatUser(
  //   name: "Fayeed",
  //   firstName: "Fayeed",
  //   lastName: "Pawaskar",
  //   uid: "12345678",
  //   avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
  // );

  // final ChatUser otherUser = ChatUser(
  //   name: "Mrfatty",
  //   uid: "25649654",
  // );

  // List<ChatMessage> localMessagesList = [];

  // @override
  // void initState() {
  //   super.initState();
  // }

  // void onSend(ChatMessage message) async {
  //   var now = (new DateTime.now()).millisecondsSinceEpoch;
  //   var model = messageDemoDartToJson(MessageDemoDart(
  //       localMessageId: now.toString(),
  //       senderId: int.parse("5"),
  //       receiverId: int.parse("1"),
  //       senderName: "Prince",
  //       receiverName: "Pallavi",
  //       message: message,
  //       type: "text",
  //       createdAt: DateTime.now(),
  //       deviceType: Platform.isIOS ? "ios" : "android"));
  //   print("Send model $model ------");
  //   widget.channel.sink.add(
  //     model,
  //   );
  //
  //   // print(message.toJson());
  //   // var documentReference = Firestore.instance
  //   //     .collection('localMessagesList')
  //   //     .document(DateTime.now().millisecondsSinceEpoch.toString());
  //   //
  //   // await Firestore.instance.runTransaction((transaction) async {
  //   //   await transaction.set(
  //   //     documentReference,
  //   //     message.toJson(),
  //   //   );
  //   // });
  //   setState(() {
  //     // localMessagesList = [...localMessagesList, message];
  //     localMessagesList.add(message);
  //     print(localMessagesList.length);
  //   });
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getString(sharedPref.userName)
        .then((value) => appUserName = value)
        .whenComplete(() {
      getString(sharedPref.userId)
          .then((value) => appUserId = value)
          .whenComplete(() {
        getString(sharedPref.userToken).then((value) {
          _auth = value;

          print("123 $value");
        }).whenComplete(() {
          ApiCaller()
              .getHistoryOfChat(auth: _auth, reciverId: widget.receiverId)
              .then((value) {
            chatHistoryModel = value;
            chatHistoryModel.data.chat.data =
                chatHistoryModel.data.chat.data.reversed;
          }).whenComplete(() {
            chatHistoryModel.data.chat.data.forEach((element) {
              print("QWERTY ${element.toJson()}");
              listOfMessage.add(
                ChatMessage(
                  text: element.message,
                  createdAt: element.createdAt,
                  user: ChatUser(
                    name: element.senderName,
                    avatar: element.senderImage,
                    uid: element.senderId.toString(),
                  ),
                ),
              );
            });
          }).whenComplete(() {
            setState(() {
              isLoading = false;
            });
          });
        });
      });
    });

    print("revicer id : ${widget.receiverId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CColors.missonNormalWhiteColor,
        elevation: 0,
        title: Text(
          "${widget.reciverName}",
          style: TextStyle(color: CColors.missonGrey, fontFamily: "Product"),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, bottom: 8.0, top: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.image),
            ),
          )
        ],
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 24.0,
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: widget.channel.stream,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              _messageDemoDart = messageDemoDartFromJson(snapshot.data);

              if (_messageDemoDart.senderId.toString() == widget.receiverId) {
                listOfMessage.add(ChatMessage(
                    text: _messageDemoDart.message,
                    user: ChatUser(

                        name: _messageDemoDart.senderName,
                        avatar: _messageDemoDart.receiverImage,
                        uid: _messageDemoDart.senderId.toString())));
              }

              print("sdfdssdds ${snapshot.data}"); //Palvai send message
            }
            // if (!snapshot.hasData) {
            //   return Center(
            //     child: CircularProgressIndicator(
            //       valueColor: AlwaysStoppedAnimation<Color>(
            //         Theme.of(context).primaryColor,
            //       ),
            //     ),
            //   );
            // } else {
            return isLoading == true
                ? Center(child: CircularProgressIndicator())
                : DashChat(
                    key: _chatViewKey,
                    inverted: false,
                    onSend: (value) {
                      _sendMessage(value);
                    },
                    sendOnEnter: true,
                    textInputAction: TextInputAction.send,
                    user: ChatUser(
                   
                      name: "$appUserName",
                      uid: "$appUserId",
                    ),
                    inputDecoration: InputDecoration.collapsed(
                        hintText: "Add message here..."),
                    dateFormat: DateFormat('yyyy-MMM-dd'),
                    timeFormat: DateFormat('HH:mm'),
                    messages: listOfMessage,
                    showUserAvatar: false,
                    showAvatarForEveryMessage: false,
                    scrollToBottom: true,
                    onPressAvatar: (ChatUser user) {
                      print("OnPressAvatar: ${user.name}");
                    },
                    onLongPressAvatar: (ChatUser user) {
                      print("OnLongPressAvatar: ${user.name}");
                    },
                    inputMaxLines: 5,
                    messageContainerPadding:
                        EdgeInsets.only(left: 5.0, right: 5.0),
                    alwaysShowSend: true,
                    inputTextStyle: TextStyle(fontSize: 16.0),
                    inputContainerStyle: BoxDecoration(
                      border: Border.all(width: 0.0),
                      color: Colors.white,
                    ),
                    // onQuickReply: (Reply reply) {
                    //   setState(() {
                    //     localMessagesList.add(ChatMessage(
                    //         text: reply.value, createdAt: DateTime.now(), user: user));
                    //
                    //     localMessagesList = [...localMessagesList];
                    //   });
                    //
                    //   Timer(Duration(milliseconds: 300), () {
                    //     _chatViewKey.currentState.scrollController
                    //       ..animateTo(
                    //         _chatViewKey
                    //             .currentState.scrollController.position.maxScrollExtent,
                    //         curve: Curves.easeOut,
                    //         duration: const Duration(milliseconds: 300),
                    //       );
                    //
                    //     // if (i == 0) {
                    //     //   systemMessage();
                    //     //   Timer(Duration(milliseconds: 600), () {
                    //     //     systemMessage();
                    //     //   });
                    //     // } else {
                    //     //   systemMessage();
                    //     // }
                    //   });
                    // },
                    onLoadEarlier: () {
                      print("laoding...");
                    },
                    shouldShowLoadEarlier: false,
                    showTraillingBeforeSend: true,
                    // trailing: <Widget>[
                    //   IconButton(
                    //     icon: Icon(Icons.photo),
                    //     onPressed: () async {
                    //       // File result = await ImagePicker.pickImage(
                    //       //   source: ImageSource.gallery,
                    //       //   imageQuality: 80,
                    //       //   maxHeight: 400,
                    //       //   maxWidth: 400,
                    //       // );
                    //
                    //       // if (result != null) {
                    //       //   final StorageReference storageRef =
                    //       //   FirebaseStorage.instance.ref().child("chat_images");
                    //       //
                    //       //   StorageUploadTask uploadTask = storageRef.putFile(
                    //       //     result,
                    //       //     StorageMetadata(
                    //       //       contentType: 'image/jpg',
                    //       //     ),
                    //       //   );
                    //       //   StorageTaskSnapshot download =
                    //       //   await uploadTask.onComplete;
                    //       //
                    //       //   String url = await download.ref.getDownloadURL();
                    //       //
                    //       //   ChatMessage message =
                    //       //   ChatMessage(text: "", user: user, image: url);
                    //       //
                    //       //   var documentReference = Firestore.instance
                    //       //       .collection('messages')
                    //       //       .document(DateTime.now()
                    //       //       .millisecondsSinceEpoch
                    //       //       .toString());
                    //       //
                    //       //   Firestore.instance.runTransaction((transaction) async {
                    //       //     await transaction.set(
                    //       //       documentReference,
                    //       //       message.toJson(),
                    //       //     );
                    //       //   });
                    //       // }
                    //     },
                    //   )
                    // ],
                  );
            // }
            // else {
            // List<DocumentSnapshot> items = snapshot.data.documents;
            // var localMessagesList =
            // items.map((i) => ChatMessage.fromJson(i.data)).toList();
            // return DashChat2(
            //   key: _chatViewKey,
            //   inverted: false,
            //   onSend: onSend,
            //   sendOnEnter: true,
            //   textInputAction: TextInputAction.send,
            //   user: user,
            //   inputDecoration:
            //       InputDecoration.collapsed(hintText: "Add message here..."),
            //   dateFormat: DateFormat('yyyy-MMM-dd'),
            //   timeFormat: DateFormat('HH:mm'),
            //   messages: localMessagesList,
            //   showUserAvatar: false,
            //   showAvatarForEveryMessage: false,
            //   scrollToBottom: true,
            //   onPressAvatar: (ChatUser user) {
            //     print("OnPressAvatar: ${user.name}");
            //   },
            //   onLongPressAvatar: (ChatUser user) {
            //     print("OnLongPressAvatar: ${user.name}");
            //   },
            //   inputMaxLines: 5,
            //   messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
            //   alwaysShowSend: true,
            //   inputTextStyle: TextStyle(fontSize: 16.0),
            //   inputContainerStyle: BoxDecoration(
            //     border: Border.all(width: 0.0),
            //     color: Colors.white,
            //   ),
            //   // onQuickReply: (Reply reply) {
            //   //   setState(() {
            //   //     localMessagesList.add(ChatMessage(
            //   //         text: reply.value, createdAt: DateTime.now(), user: user));
            //   //
            //   //     localMessagesList = [...localMessagesList];
            //   //   });
            //   //
            //   //   Timer(Duration(milliseconds: 300), () {
            //   //     _chatViewKey.currentState.scrollController
            //   //       ..animateTo(
            //   //         _chatViewKey
            //   //             .currentState.scrollController.position.maxScrollExtent,
            //   //         curve: Curves.easeOut,
            //   //         duration: const Duration(milliseconds: 300),
            //   //       );
            //   //
            //   //     // if (i == 0) {
            //   //     //   systemMessage();
            //   //     //   Timer(Duration(milliseconds: 600), () {
            //   //     //     systemMessage();
            //   //     //   });
            //   //     // } else {
            //   //     //   systemMessage();
            //   //     // }
            //   //   });
            //   // },
            //   onLoadEarlier: () {
            //     print("laoding...");
            //   },
            //   shouldShowLoadEarlier: false,
            //   showTraillingBeforeSend: true,
            //   trailing: <Widget>[
            //     IconButton(
            //       icon: Icon(Icons.photo),
            //       onPressed: () async {
            //         // File result = await ImagePicker.pickImage(
            //         //   source: ImageSource.gallery,
            //         //   imageQuality: 80,
            //         //   maxHeight: 400,
            //         //   maxWidth: 400,
            //         // );
            //
            //         // if (result != null) {
            //         //   final StorageReference storageRef =
            //         //   FirebaseStorage.instance.ref().child("chat_images");
            //         //
            //         //   StorageUploadTask uploadTask = storageRef.putFile(
            //         //     result,
            //         //     StorageMetadata(
            //         //       contentType: 'image/jpg',
            //         //     ),
            //         //   );
            //         //   StorageTaskSnapshot download =
            //         //   await uploadTask.onComplete;
            //         //
            //         //   String url = await download.ref.getDownloadURL();
            //         //
            //         //   ChatMessage message =
            //         //   ChatMessage(text: "", user: user, image: url);
            //         //
            //         //   var documentReference = Firestore.instance
            //         //       .collection('messages')
            //         //       .document(DateTime.now()
            //         //       .millisecondsSinceEpoch
            //         //       .toString());
            //         //
            //         //   Firestore.instance.runTransaction((transaction) async {
            //         //     await transaction.set(
            //         //       documentReference,
            //         //       message.toJson(),
            //         //     );
            //         //   });
            //         // }
            //       },
            //     )
            //   ],
            // );
            // }
          }),
    );
  }

  // TextEditingController _controller = TextEditingController();
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("dsfdsf"),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(20.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Form(
  //             child: TextFormField(
  //               controller: _controller,
  //               decoration: InputDecoration(labelText: 'Send a message'),
  //             ),
  //           ),
  //           StreamBuilder(
  //             stream: widget.channel.stream,
  //             builder: (context, snapshot) {
  //               return Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 24.0),
  //                 child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
  //               );
  //             },
  //           )
  //         ],
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: _sendMessage,
  //       tooltip: 'Send message',
  //       child: Icon(Icons.send),
  //     ), // This trailing comma makes auto-formatting nicer for build methods.
  //   );
  // }
  //
  void _sendMessage(ChatMessage message) async {
    // if (_controller.text.isNotEmpty) {

    var now = (new DateTime.now()).millisecondsSinceEpoch;
    var model = messageDemoDartToJson(MessageDemoDart(
        receiverName: "${widget.reciverName}",
        senderName: "$appUserName",
        localMessageId: now.toString(),
        senderId: int.parse("$appUserId"),
        receiverId: int.parse("${widget.receiverId}"),
        // receiverId: int.parse("7"),
        // message:message.text,
        message: message.text,
        type: "text",
        createdAt: DateTime.now(),
        deviceType: Platform.isIOS ? "ios" : "android"));
    print("Send model $model ------");
    listOfMessage.add(message);
    widget.channel.sink.add(
      model,
    );

    // widget.channel.sink.add(_controller.text);
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
