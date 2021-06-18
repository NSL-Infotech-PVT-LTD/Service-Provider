import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:misson_tasker/model/ApiCaller.dart';
import 'package:misson_tasker/model/api_models/ListOfServicesModel.dart';
import 'package:misson_tasker/utils/CColors.dart';
import 'package:misson_tasker/utils/ScreenConfig.dart';
import 'package:misson_tasker/utils/local_data.dart';
import 'package:misson_tasker/view/startup_screens/SplashScreen.dart';

class ChildCategory extends StatefulWidget {
  final parentId;
  final parentName;

  const ChildCategory({Key key, this.parentId, this.parentName})
      : super(key: key);

  @override
  _ChildCategoryState createState() => _ChildCategoryState();
}

class _ChildCategoryState extends State<ChildCategory> {
  var _selectedRadioValue;
  String auth = '';

  // List<DataList> _parentName = [];
  ListOfServicesModel listOfServicesModel;
  bool loading = true;
  bool isSaveApiLoading = false;
  List<int> selectedCategories = [];


  cateList({@required String auth}) async {
    isConnectedToInternet().then((internet) {
      if (internet != null && internet) {
        setState(() {
          loading = true;
        });

        ApiCaller()
            .getChildScerviceList(id: widget.parentId.toString(), auth: auth)
            .then((value) {
          if (value.status) {
            setState(() {
              listOfServicesModel = value;
            });
            print("parent data" + listOfServicesModel.data.data.toString());
            //
            //  print("parent data" + parentName.toString());
            setState(() {
              // dismissDialog(context);
              //  print("cateList" + response.toJson().toString());
              setState(() {
                loading = false;
              });
            });
            // });
          } else {
            // dismissDialog(context);
            if (!value.status) print(value.error.toString());
            // showDialogBox(context, "Alert!", response.error.toString());
          }
        });
      } else {
        // showDialogBox(context, internetError, pleaseCheckInternet);
        // dismissDialog(context);
      }
    });
  }

  @override
  void initState() {
    print("parentId" + widget.parentId.toString());

    setState(() {
      loading = true;
    });

    getString(sharedPref.userToken).then((value) {
      auth = value;

      print("123 $value");
    }).whenComplete(() {
      cateList(auth: auth).then((value) {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLoadingApi = false;
    return Scaffold(
        backgroundColor: CColors.missonNormalWhiteColor,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding:
                  EdgeInsets.only(bottom: ScreenConfig.screenHeight * 0.08),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenConfig.screenHeight * 0.01,
              ),
              Text(
                "Choose categories",
                style: TextStyle(
                    color: Colors.black, fontSize: 32, fontFamily: "Product"),
              ),
              SizedBox(
                height: ScreenConfig.screenHeight * 0.02,
              ),
              Text(
                "${widget.parentName != null ? widget.parentName : "No Name Found"}",
                style: TextStyle(
                    color: Colors.grey, fontSize: 15, fontFamily: "Product"),
              ),
            ],
          ),
          toolbarHeight: ScreenConfig.screenHeight * 0.15,
          elevation: 0.0,
          backgroundColor: CColors.missonLightGrey,
        ),
        body: loading
            ? Center(child: spinkit)
            : Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      11.0,
                      11.0,
                      11.0,
                      0.0,
                    ),
                    child: Container( height:  ScreenConfig.screenHeight*0.7,
                      child: listOfServicesModel.data.data.length == 0
                          ? Center(
                              child: Text(
                                "No Data Found",
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          : ListView.builder(
                              itemCount: listOfServicesModel.data.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  color: Colors.white,
                                  child: ListTile(
                                    //dense: true,
                                    title: Text(
                                      listOfServicesModel.data.data[index].name,
                                    ),
                                    leading: Checkbox(
                                      value: listOfServicesModel
                                          .data.data[index].isSelected,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          print("$newValue");
                                          listOfServicesModel.data.data[index]
                                              .isSelected = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              }),
                    ),
                  ),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 20),
                      child: SizedBox(
                        height: ScreenConfig.screenHeight * 0.06,
                        width: ScreenConfig.screenWidth * 0.70,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isSaveApiLoading = true;
                            });
                            selectedCategories.clear();
                            listOfServicesModel.data.data.forEach((element) {
                              if (element.isSelected) {
                                selectedCategories.add(element.id);
                              }
                            });
                            ApiCaller()
                                .addChooseCategories(
                                    parent_id: widget.parentId.toString(),
                                    child_id: selectedCategories,
                                    auth: auth)
                                .whenComplete(() {
                              setState(() {
                                isSaveApiLoading = false;
                              });
                            });
                            print("${selectedCategories.toList()}");
                          },
                          child: isSaveApiLoading == true
                              ? spinkit
                              : Text("Save",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            primary: CColors.missonButtonColor2, // background
                            onPrimary: CColors.missonButtonColor2, // fo
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(06.0),
                                side: BorderSide(
                                    color:
                                        CColors.missonButtonColor2) // reground,
                                ),
                          ),
                        ),
                      ),
                    ),
                    alignment: Alignment.bottomCenter,
                  )
                ],
              ));
  }
}
