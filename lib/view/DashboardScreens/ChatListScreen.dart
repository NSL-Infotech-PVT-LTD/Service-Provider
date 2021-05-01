import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/Chat/ChatScreen.dart';
import 'package:misson_tasker/view/Chat/ChatModels/ListChatUserModel.dart';

import 'package:misson_tasker/view/startup_screens/Drawer.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';
import 'package:web_socket_channel/io.dart';

class ChatListScreen extends StatefulWidget {
  final GetProfileDataModel getProfileDataModel;

  const ChatListScreen({@required this.getProfileDataModel});

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String _auth = "";
  String authId;
  List<ListElement> chatList = [];
  var result1;

  // MessageDemoDart messageDemoDart;
  ListChatUserModel listChatUserModel;
  var spinkit;

  @override
  void initState() {
    getString(sharedPref.userId)
        .then((value) => authId = value)
        .whenComplete(() {
      print("This is auth id $authId");

      getString(sharedPref.userToken)
          .then((value) => _auth = value)
          .whenComplete(() {
        _getChatList();
      });
    });

    spinkit = SpinKitWave(
      size: 40,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven
                ? CColors.missonPrimaryColor
                : CColors.missonMediumGrey,
          ),
        );
      },
    );
    // TODO: implement initState
    super.initState();
  }

  bool _loading = true;

  void _getChatList() {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        Map<String, String> parms = {
          "limit": "20",
        };

        ApiCaller()
            .getListOfChatUsers(auth: _auth, limit: "20")
            .then((value) => listChatUserModel = value)
            .whenComplete(() {
          setState(() {
            _loading = false;
          });
          if (listChatUserModel.status && listChatUserModel.data != null) {
            chatList = listChatUserModel.data.list;
            // chatList.every((element) { print("${element.toJson()}");} );

          }
        });

        //print("ChatList   $parms");
        // postWithAuth(getChatItemByReceiverId, _auth, parms, context)
        //     .then((response) {
        //   setState(() {
        //     _loading = false;
        //   });
        //   if (response.status && response.data != null) {
        //     chatList = response.data.chat_list;
        //   } else {
        //     var errorMessage = '';
        //     if (response.error != null) {
        //       errorMessage = response.error.toString();
        //     }
        //     showDialogBox(
        //         context, "${getTranslated(context, "error")}", errorMessage);
        //   }
        // });
      }
      // else {
      //   setState(() {
      //     _loading = false;
      //   });
      //   showDialogBox(context, getTranslated(context, "internetError"),
      //       getTranslated(context, "pleaseCheckInternet"));
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        key: _drawerKey,
        drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: MyDrawer(
          username: widget.getProfileDataModel.data.user.name,
          ImageUrl: widget.getProfileDataModel == null ||
                  widget.getProfileDataModel.data == null ||
                  widget.getProfileDataModel.data.user == null ||
                  widget.getProfileDataModel.data.user.image == null
              ? null
              : widget.getProfileDataModel.data.user.image,
        )),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CColors.missonNormalWhiteColor,
          titleSpacing: -1.0,
          leading: InkWell(
            onTap: () {
              _drawerKey.currentState.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SvgPicture.asset(drawerIcon),
            ),
          ),
          centerTitle: true,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Messages",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: ScreenConfig.fontSizeXlarge,
                    color: CColors.textColor,
                    fontFamily: "Product"),
              ),
            ],
          ),
          // actions: [
          //   Padding(
          //     padding: EdgeInsets.only(right: 16.0),
          //     child: InkWell(
          //       onTap: () {
          //         NavMe().NavPushLeftToRight(BusinessProfile());
          //       },
          //       child: CircleAvatar(
          //         backgroundColor: CColors.missonGrey,
          //         // radius: ,
          //         child: CircleAvatar(
          //           backgroundImage: widget.getProfileDataModel == null ||
          //               widget.getProfileDataModel.data == null ||
          //               widget.getProfileDataModel.data.user == null ||
          //               widget.getProfileDataModel.data.user.image == null
          //               ? AssetImage(avatar1)
          //               : NetworkImage(
          //               "${widget.getProfileDataModel.data.user.image}"),
          //         ),
          //       ),
          //     ),
          //   )
          // ],
        ),
        body: listChatUserModel == null
            ? Center(child: spinkit)
            : Container(
                color: CColors.missonNormalWhiteColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "You can send message or chat with your \n mission speakers",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: ScreenConfig.fontSizeMedium,
                            color: CColors.textColor,
                            fontWeight: FontWeight.w100,
                            fontFamily: "Product"),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // NavMe().NavPushLeftToRight(ChatScreen(
                              //     // title:
                              //     //     "${messageDemoDart.data.list.elementAt(index).senderName}",
                              //     // image: messageDemoDart.data.list
                              //     //             .elementAt(index)
                              //     //             .senderImage ==
                              //     //         null
                              //     //     ? " "
                              //     //     : "${messageDemoDart.data.list.elementAt(index).senderImage}",
                              //     // receiverId:
                              //     //     "${messageDemoDart.data.list.elementAt(index).senderId}",
                              //     // channel: IOWebSocketChannel.connect(
                              //     //     "ws://23.20.179.178:8080/")
                              //
                              // ));

                              Get.to(
                                      ChatScreen(
                                          reciverName:
                                              "${authId != listChatUserModel.data.list.elementAt(index).senderId.toString() ? listChatUserModel.data.list.elementAt(index).senderName : listChatUserModel.data.list.elementAt(index).receiverName}",
                                          image:
                                              "${(authId != listChatUserModel.data.list.elementAt(index).senderId.toString() ? (listChatUserModel.data.list.elementAt(index).senderImage) : (listChatUserModel.data.list.elementAt(index).receiverImage)) == null ? " " : authId != listChatUserModel.data.list.elementAt(index).senderId.toString() ? (listChatUserModel.data.list.elementAt(index).senderImage) : (listChatUserModel.data.list.elementAt(index).receiverImage)}",
                                          receiverId:
                                              "${authId != listChatUserModel.data.list.elementAt(index).senderId.toString() ? listChatUserModel.data.list.elementAt(index).senderId : listChatUserModel.data.list.elementAt(index).receiverId}",
                                          channel: IOWebSocketChannel.connect(
                                              "ws://23.20.179.178:8080/")),
                                      transition:
                                          Transition.leftToRightWithFade,
                                      duration: Duration(milliseconds: 400))
                                  .then((value) => initState());
                              // NavMe().NavPushLeftToRight(ChatScreen(
                              //     reciverName:
                              //         "${authId != listChatUserModel.data.list.elementAt(index).senderId.toString() ? listChatUserModel.data.list.elementAt(index).senderName : listChatUserModel.data.list.elementAt(index).receiverName}",
                              //     image:                                     "${(authId != listChatUserModel.data.list.elementAt(index).senderId.toString() ? (listChatUserModel.data.list.elementAt(index).senderImage) : (listChatUserModel.data.list.elementAt(index).receiverImage)) == null ? " " : authId != listChatUserModel.data.list.elementAt(index).senderId.toString() ? (listChatUserModel.data.list.elementAt(index).senderImage) : (listChatUserModel.data.list.elementAt(index).receiverImage)}",
                              //
                              //     receiverId:
                              //         "${authId != listChatUserModel.data.list.elementAt(index).senderId.toString() ? listChatUserModel.data.list.elementAt(index).senderId : listChatUserModel.data.list.elementAt(index).receiverId}",
                              //     channel: IOWebSocketChannel.connect(
                              //         "ws://23.20.179.178:8080/")));
                            },
                            child: MyChatListView(
                                imageUrl:
                                    "${(authId != listChatUserModel.data.list.elementAt(index).senderId.toString() ? (listChatUserModel.data.list.elementAt(index).senderImage) : (listChatUserModel.data.list.elementAt(index).receiverImage)) == null ? " " : authId != listChatUserModel.data.list.elementAt(index).senderId.toString() ? (listChatUserModel.data.list.elementAt(index).senderImage) : (listChatUserModel.data.list.elementAt(index).receiverImage)}",
                                name:
                                    "${authId != listChatUserModel.data.list.elementAt(index).senderId.toString() ? listChatUserModel.data.list.elementAt(index).senderName : listChatUserModel.data.list.elementAt(index).receiverName}",
                                subtitle:
                                    "${listChatUserModel.data.list.elementAt(index).message}",
                                numberOfMessages: 2),
                          );
                        },
                        itemCount: listChatUserModel.data.list.length,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Widget MyChatListView(
      {@required String name,
      @required String subtitle,
      @required imageUrl,
      int numberOfMessages}) {
    print("dsfdssdf $imageUrl");

    return Column(
      children: [
        Divider(
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              imageUrl == " "
                  ? Image.asset(
                      avatar1,
                      height: 50,
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                      radius: 25,
                    ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$name",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: ScreenConfig.fontSizelarge,
                        color: CColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Product"),
                  ),
                  Text(
                    "$subtitle",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: ScreenConfig.fontSizeSmall,
                        color: CColors.missonMediumGrey,
                        fontWeight: FontWeight.w100,
                        fontFamily: "Product"),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Badge(
                  badgeContent: Text(
                    '3',
                    style: TextStyle(
                        fontSize: ScreenConfig.fontSizeSmall,
                        color: CColors.missonNormalWhiteColor,
                        fontWeight: FontWeight.w100,
                        fontFamily: "Product"),
                  ),
                  badgeColor: Colors.green.shade200,
                  // child: Icon(Icons.settings),
                ),
              )
            ],
          )),
        ),
        // Divider(height: 1,),
      ],
    );
  }
}