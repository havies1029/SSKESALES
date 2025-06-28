import 'package:flutter/material.dart';
import 'package:esalesapp/common/size_config.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String kStringNullError = "Please enter some text";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}

enum ListStatus { initial, success, failure }

const List<Map<String, dynamic>> menuSections = [
  {
    "title": "Daily Activity",
    "menus": [
      {"label": "Briefing", "menuid": "briefing", "icon": "assets/images/vector-1.png"},
      {"label": "Tasks", "menuid": "jobrealcari", "icon": "assets/images/vector-2.png"},
      {"label": "Planning", "menuid": "todo", "icon": "assets/images/vector-13.png"},
      {"label": "Project", "menuid": "project", "icon": "assets/images/vector-3.png"},
      {"label": "Subordinate Finished Tasks", "menuid": "realgroup", "icon": "assets/images/vector-4.png"},
      {"label": "SOA Client", "menuid": "soaclient", "icon": "assets/images/vector-5.png"},
    ]
  },
  {
    "title": "Data Action Plan",
    "menus": [
      {"label": "Media", "menuid": "mediacari", "icon": "assets/images/vector-6.png"},
      {"label": "Job Function", "menuid": "jobgroup", "icon": "assets/images/vector-7.png"},
      {"label": "Task Category", "menuid": "jobcatcari", "icon": "assets/images/vector-8.png"},
      {"label": "List of Tasks", "menuid": "jobcari", "icon": "assets/images/vector-9.png"},
      {"label": "Subordinate Tasks", "menuid": "jobsales", "icon": "assets/images/vector-10.png"},
    ]
  },
  {
    "title": "Data Insurance",
    "menus": [
      {"label": "Class of Business", "menuid": "cobcari", "icon": "assets/images/vector-11.png"},
      {"label": "Insurer", "menuid": "asuransicari", "icon": "assets/images/vector-12.png"},
      {"label": "Policy", "menuid": "poliscari", "icon": "assets/images/vector-13.png"},
      {"label": "Calendar Policy Exp", "menuid": "calendar", "icon": "assets/images/vector-14.png"},
      {"label": "Timeline Policy Exp", "menuid": "timelineexpired", "icon": "assets/images/vector-1.png"},
    ]
  },
  {
    "title": "Data Umum",
    "menus": [
      {"label": "Title", "menuid": "titlecari", "icon": "assets/images/vector-2.png"},
      {"label": "Client Category", "menuid": "custcatcari", "icon": "assets/images/vector-3.png"},
      {"label": "Jabatan", "menuid": "jabatancari", "icon": "assets/images/vector-4.png"},
      {"label": "Customer", "menuid": "customercari", "icon": "assets/images/vector-5.png"},
      {"label": "Karyawan", "menuid": "staffcari", "icon": "assets/images/vector-6.png"},
    ]
  },
  // {
  //   "title": "User Security",
  //   "menus": [
  //     {"label": "Profile", "menuid": "profile", "icon": "assets/images/vector-7.png"},
  //     {"label": "Change Password", "menuid": "changepassword", "icon": "assets/images/vector-8.png"},
  //   ]
  // },
  // {
  //   "title": "Support",
  //   "menus": [
  //     {"label": "Chat Support", "menuid": "chatsupport", "icon": "assets/images/vector-9.png"},
  //   ]
  // },
];
