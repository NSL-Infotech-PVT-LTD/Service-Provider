import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:misson_tasker/model/api_models/GetProfileDataModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/NavMe.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/StringsPath.dart';
import 'package:misson_tasker/view/ProfileView/BusinessProfile.dart';
import 'package:misson_tasker/view/startup_screens/Drawer.dart';

class ChatScreen extends StatefulWidget {
  final GetProfileDataModel getProfileDataModel;

  const ChatScreen({@required this.getProfileDataModel});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

class _ChatScreenState extends State<ChatScreen> {
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
        body: Container(
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
                    return MyChatListView(
                        imageUrl: "sdfds",
                        name: "dflksdnmfds",
                        subtitle: "slfdsnfd",
                        numberOfMessages: 2);
                  },
                  itemCount: 5,
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
              Image.asset(
                avatar1,
                height: 50,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "You can send message eakers",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: ScreenConfig.fontSizelarge,
                        color: CColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Product"),
                  ),
                  Text(
                    "You can send s",
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
