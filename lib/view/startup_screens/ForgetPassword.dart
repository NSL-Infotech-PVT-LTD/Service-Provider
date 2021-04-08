import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/ForgetPasswordModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';

final _formKey = GlobalKey<FormState>();

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailAddressFieldController = TextEditingController();
  ForgetPasswordModel forgetPasswordobj;
  var spinkit;
  bool isLodaing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  }

  void forgotPassApi() async {
    ApiCaller()
        .forgetMyPassword(email: _emailAddressFieldController.text)
        .then((value) => forgetPasswordobj = value)
        .whenComplete(() {
      setState(() {
        isLodaing = false;
      });
      print(forgetPasswordobj.toJson());

      return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Info'),
            content: Text('${forgetPasswordobj.data.message}'),
            actions: [
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: ScreenConfig.screenHeight * 0.08,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: ScreenConfig.screenHeight * 0.20,
                ),
                TextFormField(
                  controller: _emailAddressFieldController,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(
                        14.0,
                        14.0,
                        14.0,
                        10,
                      ),
                      child: SvgPicture.asset(""),
                    ),
                    labelText: "Email Address",
                    fillColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: ScreenConfig.screenHeight * 0.04,
                ),
                SizedBox(
                  height: ScreenConfig.screenHeight * 0.08,
                  width: ScreenConfig.screenWidth * 0.70,
                  child: isLodaing==false? ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          isLodaing = true;
                        });
                        forgotPassApi();
                        // ScaffoldMessenger.of(context)
                        //     .showSnackBar(SnackBar(content: Text('Processing Data 1')));
                      } else {
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data 2')));
                      }
                    },
                    child:Text("Send mail",
                            style: TextStyle(color: Colors.white, fontSize: 18))
                        ,
                    style: ElevatedButton.styleFrom(
                      primary: CColors.missonButtonColor, // background
                      onPrimary: CColors.missonButtonColor, // fo
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          side: BorderSide(
                              color: CColors.missonPrimaryColor) // reground,
                          ),
                    ),
                  ): spinkit,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
