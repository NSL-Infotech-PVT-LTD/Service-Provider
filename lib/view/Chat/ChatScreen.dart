import 'dart:io';

import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/Chat/ChatModels/ChatHistoryModel.dart';
import 'package:misson_tasker/view/Chat/ChatModels/MessageDemo.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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

  List<Data> myListname;
  @override
  var urlData;
  ScrollController _scrollController = ScrollController();

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
          }).whenComplete(() {
            List<Datum> list = chatHistoryModel.data.chat.data;
            list.sort((a, b) => a.localMessageId.compareTo(b.localMessageId));
            list.forEach((element) {
              // print(element.createdAt.timeZoneOffset.inMilliseconds);
              // print(element.createdAt.timeZoneOffset);
              // print(
              //     "${element.message}   ${element.createdAt} VVVV ${(element.createdAt.millisecondsSinceEpoch +element.createdAt.timeZoneOffset.inMilliseconds)}    ${DateTime.fromMillisecondsSinceEpoch((element.createdAt.millisecondsSinceEpoch +element.createdAt.timeZoneOffset.inMilliseconds))}");
              listOfMessage.add(
                ChatMessage(
                  text: element.message.replaceAll("\n", ""),
                  // createdAt: element.createdAt,
                  createdAt: DateTime.fromMillisecondsSinceEpoch((element.createdAt.millisecondsSinceEpoch +element.createdAt.timeZoneOffset.inMilliseconds)),
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
          }).whenComplete(() {
            Future.delayed(Duration(seconds: 1), () {
              _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn);
            });
          });
        });
      });
    });

    print("revicer id : ${widget.receiverId}");
  }

  void _launchURL() async => await canLaunch(urlData)
      ? await launch(urlData)
      : throw 'Could not launch $urlData';

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
              print("TIME ${_messageDemoDart.createdAt}");
              print("SNAPSHOT ${snapshot.toString()}");
              if (_messageDemoDart.senderId.toString() == widget.receiverId) {
                listOfMessage.add(ChatMessage(
                    text: _messageDemoDart.message,
                    user: ChatUser(
                        name: _messageDemoDart.senderName,
                        avatar: _messageDemoDart.senderImage,
                        uid: _messageDemoDart.senderId.toString())));
              }

              print("sdfdssdds ${snapshot.data}"); //Palvai send message
            }

            return isLoading == true
                ? Center(child: spinkit)
                : DashChat(
                    scrollController: _scrollController,
                    parsePatterns: <MatchText>[
                      MatchText(
                          type: ParsedType.URL,
                          onTap: (String value) {
                            print("URL URL URL URL ");

                            urlData = value;
                            _launchURL();
                          }),
                    ],
                    key: _chatViewKey,
                    inverted: false,
                    onSend: (value) {
                      // value.createdAt=DateTime.now().millisecondsSinceEpoch.toString();

                      print("CREATE ${value.toJson()}");
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
                    onLoadEarlier: () {
                      print("laoding...");
                    },
                    shouldShowLoadEarlier: false,
                    showTraillingBeforeSend: true,
                  );
          }),
    );
  }

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
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
