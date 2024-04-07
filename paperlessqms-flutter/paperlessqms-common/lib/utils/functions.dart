// ignore_for_file: use_build_context_synchronously

/*
 * Copyright (c) since 2024 Wheref.com <https://github.com/codeeuser>
 * 
 * NOTICE OF LICENSE
 * 
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/OSL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to hello@wheref.com so we can send you a copy immediately.
 * 
 * DISCLAIMER
 * 
 * Do not edit or add to this file if you wish to upgrade PaperlessQMS to newer
 * versions in the future. If you wish to customize PaperlessQMS for your
 * needs please refer to https://wheref.com/ for more information.
 * 
 * @author wheref
 * @copyright since 2024 Wheref.com
 * @license   https://opensource.org/licenses/OSL-3.0 Open Software License (OSL 3.0)
 * 
 */
import 'dart:convert';
import 'dart:math';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:collection/collection.dart';
import 'package:common/app_absorb.dart';
import 'package:common/app_log.dart';
import 'package:common/app_theme.dart';
import 'package:common/bloc/account_bloc.dart';
import 'package:common/bloc/agent_bloc.dart';
import 'package:common/bloc/biz_bloc.dart';
import 'package:common/bloc/department_bloc.dart';
import 'package:common/bloc/maxtoken_bloc.dart';
import 'package:common/bloc/openhour_bloc.dart';
import 'package:common/bloc/service_bloc.dart';
import 'package:common/bloc/terminal_bloc.dart';
import 'package:common/bloc/token_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/agent_model.dart';
import 'package:common/models/queue_terminal_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/models/token_issued_model.dart';
import 'package:common/repositories/account_repository.dart';
import 'package:common/repositories/agent_repository.dart';
import 'package:common/repositories/biz_repository.dart';
import 'package:common/repositories/department_repository.dart';
import 'package:common/repositories/maxtoken_repository.dart';
import 'package:common/repositories/number_repository.dart';
import 'package:common/repositories/openhour_repository.dart';
import 'package:common/repositories/service_repository.dart';
import 'package:common/repositories/terminal_repository.dart';
import 'package:common/repositories/token_repository.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/overlay_support/notification/notification.dart';
import 'package:encrypt/encrypt.dart' as en;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher_string.dart';

import 'overlay_support/notification/overlay_notification.dart';

class ScreenProp {
  static const double width = 700;
  static const double widthScreenLimit = 900;
  static const double widthPhoneScreenLimit = 500;

  static double widthExpanded(BuildContext context){
    double widthExpanded = (Utils.isPhoneSize(context)==true)? 240: 280;
    return widthExpanded;
  }
}

class DecoratorUtils {
  static BoxDecoration actionBar(){
    return BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: const BorderRadius.all(Radius.circular(6)),
    );
  }

  static BoxDecoration box({Color? color, Color? borderColor}){
    return BoxDecoration(
      border: Border.all(color: borderColor?? Colors.white),
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      color: color,
    );
  }

  static InputDecoration dropdownDecoration({Colors? color, IconData? prefixIcon}){
    return InputDecoration(
      prefixIcon: (prefixIcon==null)? null: Icon(prefixIcon, size: 24),
      border: InputBorder.none,
    );
  }

  static InputDecoration inputDecoration(String hintText, {Color? color, IconData? prefixIcon, IconData? suffixIcon, Function? clear}){
    return InputDecoration(
      fillColor: (color==null)? null: Colors.grey[200],
      prefixIcon: (prefixIcon==null)? null: Icon(prefixIcon, size: 24),
      suffix: (suffixIcon==null)? null: IconButton(
        icon: Icon(suffixIcon, size: 16),
        onPressed: (){
          if (clear!=null) {
            clear();
          }
        },
      ), 
      contentPadding: const EdgeInsetsDirectional.only(start: 8.0),                             
      border: InputBorder.none,
      hintText: hintText,
    );
  }
}

class Utils {
  static const String tag = 'Utils';

  static Widget buildProvider(
      SharedPreferences prefs,
      Widget w){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppTheme(prefs: prefs)),
        ChangeNotifierProvider(create: (_) => AppLog()),
        ChangeNotifierProvider(create: (_) => AppAbsorb(prefs: prefs)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AccountBloc>(
            create: (context) => AccountBloc(
              repository: AccountRepository(context: context, prefs: prefs),
            ),
          ),
          BlocProvider<AgentBloc>(
            create: (context) => AgentBloc(
              prefs: prefs,
              repository: AgentRepository(context: context, prefs: prefs),
              accountRepository: AccountRepository(context: context, prefs: prefs),
              bizRepository: BizRepository(context: context, prefs: prefs),
              departmentRepository: DepartmentRepository(context: context, prefs: prefs),
              terminalRepository: TerminalRepository(context: context, prefs: prefs),
            ),
          ),
          BlocProvider<BizBloc>(
            create: (context) => BizBloc(
              prefs: prefs,
              repository: BizRepository(context: context, prefs: prefs),
              departmentRepository: DepartmentRepository(context: context, prefs: prefs),
              serviceRepository: ServiceRepository(context: context, prefs: prefs),
              terminalRepository: TerminalRepository(context: context, prefs: prefs),
              openhourRepository: OpenhourRepository(context: context, prefs: prefs),
              maxtokenRepository: MaxtokenRepository(context: context, prefs: prefs),
              agentRepository: AgentRepository(context: context, prefs: prefs),
            ),
          ),
          BlocProvider<DepartmentBloc>(
            create: (context) => DepartmentBloc(
              repository: DepartmentRepository(context: context, prefs: prefs),
              serviceRepository: ServiceRepository(context: context, prefs: prefs),
              terminalRepository: TerminalRepository(context: context, prefs: prefs),
              bizRepository: BizRepository(context: context, prefs: prefs),
            ),
          ),
          BlocProvider<MaxtokenBloc>(
            create: (context) => MaxtokenBloc(
              repository: MaxtokenRepository(context: context, prefs: prefs),
              bizRepository: BizRepository(context: context, prefs: prefs),
            ),
          ),
          BlocProvider<OpenhourBloc>(
            create: (context) => OpenhourBloc(
              repository: OpenhourRepository(context: context, prefs: prefs),
              bizRepository: BizRepository(context: context, prefs: prefs),
            ),
          ),
          BlocProvider<ServiceBloc>(
            create: (context) => ServiceBloc(
              repository: ServiceRepository(context: context, prefs: prefs),
              bizRepository: BizRepository(context: context, prefs: prefs),
            ),
          ),
          BlocProvider<TerminalBloc>(
            create: (context) => TerminalBloc(
              repository: TerminalRepository(context: context, prefs: prefs),
              departmentRepository: DepartmentRepository(context: context, prefs: prefs),
              bizRepository: BizRepository(context: context, prefs: prefs),
            ),
          ),
          BlocProvider<TokenBloc>(
            create: (context) => TokenBloc(
              prefs: prefs,
              repository: TokenRepository(context: context, prefs: prefs),
              bizRepository: BizRepository(context: context, prefs: prefs),
              departmentRepository: DepartmentRepository(context: context, prefs: prefs),
              numberRepository: NumberRepository(context: context, prefs: prefs),
              tokenRepository: TokenRepository(context: context, prefs: prefs),
              terminalRepository: TerminalRepository(context: context, prefs: prefs),
              openhourRepository: OpenhourRepository(context: context, prefs: prefs),
              maxtokenRepository: MaxtokenRepository(context: context, prefs: prefs),
              agentRepository: AgentRepository(context: context, prefs: prefs),
            ),
          ),
        ],
        child: w,
      ),
    );
  }

  static bool get isDesktop {
    if (kIsWeb) return false;
    return [
      TargetPlatform.windows,
      TargetPlatform.linux,
      TargetPlatform.macOS,
    ].contains(defaultTargetPlatform);
  }

  static bool get isLinux {
    if (kIsWeb) return false;
    return [
      TargetPlatform.linux,
    ].contains(defaultTargetPlatform);
  }

  static bool get isWindows {
    if (kIsWeb) return false;
    return [
      TargetPlatform.windows,
    ].contains(defaultTargetPlatform);
  }

  static bool get isMacos {
    if (kIsWeb) return false;
    return [
      TargetPlatform.macOS,
    ].contains(defaultTargetPlatform);
  }

  static bool get isMobile {
    return (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android);
  }

  static bool get isMobileNotBrowser {
    return (!kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android));
  }

  static bool get isMobileBrowser {
    return (kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android));
  }

  static bool get isAndroid {
    return (defaultTargetPlatform == TargetPlatform.android);
  }

  static bool get isIos {
    return (defaultTargetPlatform == TargetPlatform.iOS);
  }

  static String getPlatformName() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'Android';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'iOS';
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      return 'Windows';
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      return 'macOS';
    } else if (defaultTargetPlatform == TargetPlatform.linux) {
      return 'Linux';
    } else {
      return 'Unknown';
    }
  }

  static bool isPhoneSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width < ScreenProp.widthPhoneScreenLimit ? true : false;
  }

  /// check if the string is valid JSON
  static bool isJson(String str) {
    try {
      jsonDecode(str);
    } catch (e) {
      return false;
    }
    return true;
  }

  static Future<void> pushPage(BuildContext context, Widget page, String name) async{
    await Navigator.of(context).push(_createRouteScaleAnimation(page, name));
  }

  static Future<void> pushAndRemoveUntilPage(
      BuildContext context, Widget page, String name) async{
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await Navigator.of(context).pushAndRemoveUntil(
        _createRouteScaleAnimation(page, name), (Route<dynamic> route) => true);
    });
  }

  static Route _createRouteScaleAnimation(Widget page, String name) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      settings: RouteSettings(name: name),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(begin: 0.95, end: 1.0);
        final scaleAnimation = animation.drive(tween);
        return Transform.scale(
          scale: scaleAnimation.value,
          child: child,
        );
      },
    );
  }

  static void overlayInfoMessage(
      {String? key = 'default-key', required String msg, ValueNotifier<List<String>>? notifier}) {
    Icon icon = const Icon(
      CupertinoIcons.check_mark,
      color: Colors.white,
      size: 24,
    );
    Color color = Colors.green;
    showSimpleNotification(
      Center(child: Text(msg)),
      leading: icon,
      background: color, position: NotificationPosition.bottom
    );
    if (notifier!=null){
      final messages = notifier.value;
      messages.clear();
      messages.add(msg);
      notifier.value = messages.toList(); 
    }
  }

  static void overlayWarnMessage(
      {String? key = 'default-key', required List<String> warns, ValueNotifier<List<String>>? notifier}) {
    Icon icon = const Icon(
      CupertinoIcons.exclamationmark_triangle_fill,
      color: Colors.white,
      size: 24,
    );
    Color color = Colors.yellow;
    showSimpleNotification(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: warns.map((e) => Text(e)).toList(),
      ),
      leading: icon,
      background: color, position: NotificationPosition.bottom
    );
    if (notifier!=null){
      final messages = notifier.value;
      messages.clear();
      messages.addAll(warns);
      notifier.value = messages.toList(); 
    }
  }

  static void overlayAlertMessage(
      {String? key = 'default-key', required String msg}) {
    Icon icon = const Icon(
      CupertinoIcons.exclamationmark_triangle_fill,
      color: Colors.white,
      size: 24,
    );
    Color color = Colors.red;
    showSimpleNotification(
      Center(child: Text(msg)),
      leading: icon,
      background: color, position: NotificationPosition.bottom
    );
  }

  static Future<void> launchThisUrl(String url) async{
    await launchUrlString(url);
  }

  static Color getRatingColor(int? ratingCode){
    if (ratingCode==null) {
      return Colors.white;
    }
    if (ratingCode == RatingCode.five){
      return RatingColor.five;
    } else if (ratingCode == RatingCode.four){
      return RatingColor.four;
    } else if (ratingCode == RatingCode.three){
      return RatingColor.three;
    } else if (ratingCode == RatingCode.two){
      return RatingColor.two;
    } else if (ratingCode == RatingCode.one){
      return RatingColor.one;
    }  
    return Colors.white;
  }

  static Color getStatusColor(String? statusName){
    if (statusName==null) {
      return Colors.white;
    }
    if (statusName == Status.onwait){
      return StatusColor.onwait;
    } else if (statusName == Status.onqueue){
      return StatusColor.onqueue;
    } else if (statusName == Status.completed){
      return StatusColor.completed;
    } else if (statusName == Status.recall){
      return StatusColor.recall;
    } else if (statusName == Status.timeout){
      return StatusColor.timeout;
    } else if (statusName == Status.transfer){
      return StatusColor.transfer;
    } else if (statusName == Status.cancel){
      return StatusColor.cancel;
    } 
    return Colors.white;
  }

  static String getStatusName(int? statusCode){
    if (statusCode==null) {
      return '';
    }
    if (statusCode == StatusCode.onwait){
      return Status.onwait;
    } else if (statusCode == StatusCode.onqueue){
      return Status.onqueue;
    } else if (statusCode == StatusCode.completed){
      return Status.completed;
    } else if (statusCode == StatusCode.recall){
      return Status.recall;
    } else if (statusCode == StatusCode.timeout){
      return Status.timeout;
    } else if (statusCode == StatusCode.transfer){
      return Status.transfer;
    } else if (statusCode == StatusCode.cancel){
      return Status.cancel;
    }
    return '';
  }

  static String getStatusAcronym(String? statusName){
    if (statusName==null) {
      return '';
    }
    if (statusName == Status.onwait){
      return StatusAcronym.onwait;
    } else if (statusName == Status.onqueue){
      return StatusAcronym.onqueue;
    } else if (statusName == Status.completed){
      return StatusAcronym.completed;
    } else if (statusName == Status.recall){
      return StatusAcronym.recall;
    } else if (statusName == Status.timeout){
      return StatusAcronym.timeout;
    } else if (statusName == Status.transfer){
      return StatusAcronym.transfer;
    } else if (statusName == Status.cancel){
      return StatusAcronym.cancel;
    }
    return '';
  }

  static Widget getStatusLeading(TokenIssuedModel issued){
    return ClipOval(
      child: Container(
        color: getStatusColor('${issued.statusName}'),
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(10.0),
        child: Center(child: Text(getStatusAcronym(issued.statusName), style: const TextStyle(fontSize: 25.0, color: Colors.white))),
      ),
    );
  }

  static String printAgo(int? milliseconds, String locale){
    if (milliseconds==null) return '';
    DateTime now =  DateTime.now();
    final duration = now.millisecondsSinceEpoch - milliseconds;
    DateTime ago = now.subtract(Duration(milliseconds: duration));
    timeago.setLocaleMessages(locale, MyCustomMessages());
    return timeago.format(ago, locale: locale);
  }

  static void showDialog(BuildContext context, Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  static void statusTransfer(TokenIssuedModel issued,
      AgentModel agentNew){
    DateTime now = DateTime.now();
    issued.statusName = Status.transfer;
    issued.statusCode = StatusCode.transfer;
    issued.isAbsent = false;
    issued.isCancel = false;
    issued.isCompleted = false;
    issued.isPending = false;
    issued.isQueue = false;
    issued.isRecall = true;
    issued.isReject = false;
    issued.isTimeout = false;
    issued.orgTerminalId = issued.terminalId;
    issued.orgTerminalName = issued.terminalName;
    issued.terminalId = agentNew.queueTerminal?.id;
    issued.terminalName = agentNew.queueTerminal?.name;
    issued.transferedDay = now.day;
    issued.transferedHour = now.hour;
    issued.transferedMin = now.minute;
    issued.transferedMonth = now.month;
    issued.transferedYear = now.year;
    issued.transferedTimeZoneName = now.timeZoneName;
    issued.transferedTimeZoneOffset = now.timeZoneOffset.inHours;
    issued.transferedDate = now.millisecondsSinceEpoch;
    issued.transferedNow = now.toIso8601String();
    issued.transferedUid = issued.assignedUid;
    issued.assignedUid = agentNew.id;
  }

  static void statusCancel(TokenIssuedModel issued){
    issued.statusName = Status.cancel;
    issued.statusCode = StatusCode.cancel;
    issued.isAbsent = false;
    issued.isCancel = true;
    issued.isCompleted = true;
    issued.isPending = false;
    issued.isQueue = false;
    issued.isRecall = false;
    issued.isReject = false;
    issued.isTimeout = false;
  }

  static void statusQueue(TokenIssuedModel issued, QueueTerminalModel? terminal){
    issued.statusName = Status.onqueue;
    issued.statusCode = StatusCode.onqueue;
    issued.isAbsent = false;
    issued.isCancel = false;
    issued.isCompleted = false;
    issued.isPending = false;
    issued.isQueue = true;
    issued.isRecall = false;
    issued.isReject = false;
    issued.isTimeout = false;
    issued.terminalId = terminal?.id;
    issued.terminalName = terminal?.name;
  }

  static void statusTimeout(TokenIssuedModel issued){
    issued.statusName = Status.timeout;
    issued.statusCode = StatusCode.timeout;
    issued.isAbsent = false;
    issued.isCancel = false;
    issued.isCompleted = true;
    issued.isPending = false;
    issued.isQueue = false;
    issued.isRecall = false;
    issued.isReject = false;
    issued.isTimeout = true;
  }

  static void statusRecall(TokenIssuedModel issued){
    issued.statusName = Status.recall;
    issued.statusCode = StatusCode.recall;
    issued.isAbsent = false;
    issued.isCancel = false;
    issued.isCompleted = false;
    issued.isPending = false;
    issued.isQueue = false;
    issued.isRecall = true;
    issued.isReject = false;
    issued.isTimeout = false;
  }


  static void statusCompleted(TokenIssuedModel issued, AgentModel? agent){
    DateTime now = DateTime.now();
    issued.statusName = Status.completed;
    issued.statusCode = StatusCode.completed;
    issued.isAbsent = false;
    issued.isCancel = false;
    issued.isCompleted = true;
    issued.isPending = false;
    issued.isQueue = false;
    issued.isRecall = false;
    issued.isReject = false;
    issued.isTimeout = false;
    issued.completedDay = now.day;
    issued.completedHour = now.hour;
    issued.completedMin = now.minute;
    issued.completedMonth = now.month;
    issued.completedYear = now.year;
    issued.completedTimeZoneName = now.timeZoneName;
    issued.completedTimeZoneOffset = now.timeZoneOffset.inHours;
    issued.completedDate = now.millisecondsSinceEpoch;
    issued.completedNow = now.toIso8601String();
    issued.completedUid = agent?.id;
  }

  static Future<bool> checkIsSameToken(TokenRepository? tokenRepository, TokenIssuedModel issued) async{
    dynamic dataOld = await tokenRepository?.getTokenIssued(issued.id);
    final tokenOld = (dataOld is TokenIssuedModel)? dataOld: null;
    return (tokenOld==issued);
  }

  static Future<OkCancelResult> updateTokenIssued(
        BuildContext context, 
        AppAbsorb appAbsorb,
        AgentModel agent,
        TokenIssuedModel issued) async{
    OkCancelResult result = await showOkCancelAlertDialog(
      context: context,
      title: '${S.of(context).updateTo} ${issued.statusName}',
      message: S.of(context).takeThisActionIfOK,
    );
    if (result==OkCancelResult.ok){
      appAbsorb.absorbing = true;
      DateTime now = DateTime.now();
      issued.assignedDate = now.millisecondsSinceEpoch;
      issued.assignedTimeZoneName = now.timeZoneName;
      issued.assignedTimeZoneOffset = now.timeZoneOffset.inHours;
      issued.assignedDay = now.day;
      issued.assignedHour = now.hour;
      issued.assignedMin = now.minute;
      issued.assignedMonth = now.month;
      issued.assignedYear = now.year;
      issued.assignedNow = now.toIso8601String();
      issued.assignedUid = agent.id;
      issued.modifiedTimeZoneName = now.timeZoneName;
      issued.modifiedTimeZoneOffset = now.timeZoneOffset.inHours;
      issued.modifiedDate = now.millisecondsSinceEpoch;
      issued.modifiedDay = now.day;
      issued.modifiedHour = now.hour;
      issued.modifiedMin = now.minute;
      issued.modifiedMonth = now.month;
      issued.modifiedYear = now.year;
      issued.modifiedNow = now.toIso8601String();

      context.read<TokenBloc>().add(TokenUpdateEvent(token: issued));
      appAbsorb.absorbing = false;
    }
    return result;
  }

  static String retriveQrCodeId(String text, String prefix){
    return text.substring(text.indexOf(prefix) + prefix.length);
  }

  static String generateRandomString(int len) {
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        len, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  static String aesEncrypt(String decoded, String password) {
    final key = en.Key.fromUtf8(password);
    // final iv = IV.fromLength(16); (ok in 5.0.1 not in 5.0.3)
    final iv = en.IV.allZerosOfLength(16);
    final encrypter = en.Encrypter(en.AES(key));
    return encrypter.encrypt(decoded, iv: iv).base64;
  }

  static String aesDecrypt(String encoded, String password) {
    final key = en.Key.fromUtf8(password);
    // final iv = IV.fromLength(16); (ok in 5.0.1 not in 5.0.3)
    final iv = en.IV.allZerosOfLength(16);
    final encrypter = en.Encrypter(en.AES(key));
    return encrypter.decrypt(en.Encrypted.fromBase64(encoded), iv: iv);
  }

  static Widget buildStatusBox(String status){
    double fontSize = 8;
    TextStyle textStyle = TextStyle(color: Colors.blueGrey, fontSize: fontSize);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(2),
          child: ClipOval(
            child: Container(
              color: Utils.getStatusColor(status),
              width: 20,
              height: 20,
              child: Center(child:Text(Utils.getStatusAcronym(status), style: TextStyle(fontSize: fontSize, color: Colors.white))),
            ),
          ),
        ),
        Text(status.toUpperCase(), style: textStyle)
      ],
    );
  }

  static List<E> handleResponseList<E>(dynamic data, ValueNotifier<List<String>>? errors){
    if (data is List<E>){
      return data;
    } else if (data is ServerErrorModel){
      Utils.overlayWarnMessage(warns: [data.data?.title??'Response Error'], notifier: errors);
    }
    return [];
  } 

  static E? handleResponseItem<E>(dynamic data, ValueNotifier<List<String>>? errors){
    if (data is E){
      return data;
    } else if (data is ServerErrorModel){
      Utils.overlayWarnMessage(warns: [data.data?.title??'Response Error'], notifier: errors);
    }
    return null;
  } 
}

class MyCustomMessages implements timeago.LookupMessages {
  @override String prefixAgo() => '';
  @override String prefixFromNow() => '';
  @override String suffixAgo() => '';
  @override String suffixFromNow() => '';
  @override String lessThanOneMinute(int seconds) => 'now';
  @override String aboutAMinute(int minutes) => '${minutes}m';
  @override String minutes(int minutes) => '${minutes}m';
  @override String aboutAnHour(int minutes) => '${minutes}m';
  @override String hours(int hours) => '${hours}h';
  @override String aDay(int hours) => '${hours}h';
  @override String days(int days) => '${days}d';
  @override String aboutAMonth(int days) => '${days}d';
  @override String months(int months) => '${months}mo';
  @override String aboutAYear(int year) => '${year}y';
  @override String years(int years) => '${years}y';
  @override String wordSeparator() => ' ';
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

extension ListExtension<E> on List<E> {
  void sortAscByNullable<K extends Comparable<K>>(K? Function(E element) keyOf) {
    sortByCompare((element) => keyOf(element), (a, b) {
      if (a == null) {
        return 1;
      } else if (b == null) {
        return -1;
      } else {
        return a.compareTo(b);
      }
    });
  }

  void sortDescByNullable<K extends Comparable<K>>(K? Function(E element) keyOf) {
    sortByCompare((element) => keyOf(element), (a, b) {
      if (b == null) {
        return 1;
      } else if (a == null) {
        return -1;
      } else {
        return b.compareTo(a);
      }
    });
  }
}