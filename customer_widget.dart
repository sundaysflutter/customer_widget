import 'package:flutter/material.dart';
import 'package:flutteridcm/style.dart';
import 'package:flutteridcm/utils/screenadapter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/services.dart';
import 'dart:async';

Widget myItemWidget(
    {String iconName,
    String leftTitle,
    String rightTitle = '',
    Color dividerColor = Colors.grey,
    double dividerWidth = 0.2,
    double dividerThickNess = 0.2,
    Function clickTap,
    Color bgColor = Colors.black,
    double dividerLeftIndent = 0,
    double diveiderRightIndent = 0}) {
  return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: bgColor ?? AppColors.bg_dark,
        padding: EdgeInsets.all(0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 40,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            iconName,
                            width: 22,
                            height: 22,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(leftTitle, style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(rightTitle,
                              style: TextStyle(
                                  fontFamily: 'PingFang-SC-Medium',
                                  color: Colors.grey,
                                  fontSize: 14)),
                          SvgPicture.asset(
                            'images/g_arrow_white.svg',
                            width: 22,
                            height: 22,
                            // color: selected ? null : AppColors.grey,
                          ),
                        ],
                      )
                    ]),
              ),
              Divider(
                  color: dividerColor,
                  height: dividerWidth,
                  thickness: dividerThickNess,
                  indent: dividerLeftIndent,
                  endIndent: diveiderRightIndent)
            ]),
      ),
      onTap: clickTap);
}

void myFluttertoast(String msgStr, BuildContext context,
    {Toast length = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.CENTER}) {
  Fluttertoast.showToast(
      msg: msgStr,
      toastLength: length,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.bg_color_toast,
      textColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black);
}

Widget myExpandWidget(
    {Widget child, double horizontlPadding = 20, double height = 40}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Expanded(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: horizontlPadding),
            height: height,
            child: child),
      )
    ],
  );
}

Widget myExpandRaisedButton(String btnTitle, Function onPressed,
    [double horizontlPadding = 20, double height = 40]) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Expanded(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 40,
            child: RaisedButton(
              onPressed: onPressed,
              disabledColor: AppColors.bg_btn_sel.darker(50),
              disabledTextColor: Colors.white70,
              child: Text(btnTitle, style: TextStyle(fontSize: 16)),
              splashColor: Colors.green,
              highlightColor: Colors.black,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            )),
      )
    ],
  );
}

Widget pinCodeWdiget(
    {BuildContext context,
    Widget leftWidget,
    Widget rightWidget,
    TextEditingController editController,
    StreamController errorStreamController,
    bool isObscure = true,
    Function(String) onCompleted,
    Function(String) onChanged,
    FocusNode focusNode,
    String obsecurChar = "*",
    TextInputAction textInputAction = TextInputAction.done}) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[leftWidget, rightWidget ?? Container()],
        ),
        PinCodeTextField(
          appContext: context,
          pastedTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          length: 6,
          obscureText: isObscure,
          obscuringCharacter: obsecurChar,
          // obscuringWidget: FlutterLogo(
          //   size: 24,
          // ),
          focusNode: focusNode,
          blinkWhenObscuring: true,
          animationType: AnimationType.fade,
          textInputAction: textInputAction,
          validator: (v) {
            return null;
          },
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              // borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
              inactiveColor: Colors.white54,
              activeColor: Colors.white,
              selectedColor: Colors.white54),
          cursorColor: Colors.black,
          animationDuration: Duration(milliseconds: 300),
          // enableActiveFill: true,
          errorAnimationController: errorStreamController,
          controller: editController,
          keyboardType: TextInputType.number,

          onCompleted: (v) {
            onCompleted(v);
          },
          onTap: () {
            focusNode.requestFocus();
          },
          onChanged: (value) {
            onChanged(value);
          },
          beforeTextPaste: (text) {
            return true;
          },
        )
      ]);
}
