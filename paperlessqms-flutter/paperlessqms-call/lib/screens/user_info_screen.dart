import 'package:call/logger.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/token_issued_model.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final TokenIssuedModel issued;
  const UserInfoScreen({super.key, required this.prefs, required this.issued});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  static const String tag = 'UserInfoScreen';

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
  }

  @override
  Widget build(BuildContext context) {
    String email = widget.issued.userEmail?? '<${S.of(context).empty}>';
    String firstName = widget.issued.userFirstName?? '<${S.of(context).empty}>';
    String lastName = widget.issued.userLastName?? '<${S.of(context).empty}>';
    String phone = widget.issued.userPhone?? '<${S.of(context).empty}>';
    String letter = widget.issued.tokenLetter?? '<${S.of(context).empty}>';
    int? number = widget.issued.tokenNumber;
    String sToken = (number!=null)? '$letter-$number': '<${S.of(context).empty}>';
    String status = (widget.issued.statusName!=null)? widget.issued.statusName??'': '<${S.of(context).empty}>';
    String dep = widget.issued.departmentName?? '<${S.of(context).empty}>';
    String ter = widget.issued.terminalName?? '<${S.of(context).empty}>';
    int? createdDate = widget.issued.createdDate;
    int? modifiedDate = widget.issued.modifiedDate;
    String sCreatedDate = (createdDate!=null)? DateTime.fromMillisecondsSinceEpoch(createdDate).toIso8601String(): '<${S.of(context).empty}>';
    String sModifiedDate = (modifiedDate!=null)? DateTime.fromMillisecondsSinceEpoch(modifiedDate).toIso8601String(): '<${S.of(context).empty}>';
    
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width>ScreenProp.widthPhoneScreenLimit){
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(S.of(context).userProfile),
      ),
      body: Center(
        child: Container(
          width: width,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text(email),
                  subtitle: Text(S.of(context).email),
                ),
                Constants.divider,
                ListTile(
                  title: Text(firstName),
                  subtitle: Text(S.of(context).firstName),
                ),
                Constants.divider,
                ListTile(
                  title: Text(lastName),
                  subtitle: Text(S.of(context).lastName),
                ),
                Constants.divider,
                ListTile(
                  title: Text(phone),
                  subtitle: Text(S.of(context).phone),
                ),
                Constants.divider,
                ListTile(
                  title: Text(sToken),
                  subtitle: Text(S.of(context).tokenNumber),
                ),
                Constants.divider,
                ListTile(
                  title: Text(status),
                  subtitle: Text(S.of(context).status),
                ),
                Constants.divider,
                ListTile(
                  title: Text(dep),
                  subtitle: Text(S.of(context).department),
                ),
                Constants.divider,
                ListTile(
                  title: Text(ter),
                  subtitle: Text(S.of(context).terminal),
                ),
                Constants.divider,
                ListTile(
                  title: Text(sCreatedDate),
                  subtitle: Text(S.of(context).createdDate),
                ),
                Constants.divider,
                ListTile(
                  title: Text(sModifiedDate),
                  subtitle: Text(S.of(context).modifiedDate),
                ),
                Constants.divider,
              ],
            ),
          ),
        ),
      ),
    );
  }
}