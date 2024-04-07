// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Paperless QMS`
  String get title {
    return Intl.message(
      'Paperless QMS',
      name: 'title',
      desc: 'Paperless QMS',
      args: [],
    );
  }

  /// `Paperless`
  String get paperless {
    return Intl.message(
      'Paperless',
      name: 'paperless',
      desc: '',
      args: [],
    );
  }

  /// `Paperless QMS Plan`
  String get paperlessQmsPlan {
    return Intl.message(
      'Paperless QMS Plan',
      name: 'paperlessQmsPlan',
      desc: '',
      args: [],
    );
  }

  /// `Select Window`
  String get selectWindow {
    return Intl.message(
      'Select Window',
      name: 'selectWindow',
      desc: '',
      args: [],
    );
  }

  /// `Verify Account`
  String get verifyAccount {
    return Intl.message(
      'Verify Account',
      name: 'verifyAccount',
      desc: '',
      args: [],
    );
  }

  /// `More Information`
  String get moreInformation {
    return Intl.message(
      'More Information',
      name: 'moreInformation',
      desc: '',
      args: [],
    );
  }

  /// `Subscription`
  String get subscription {
    return Intl.message(
      'Subscription',
      name: 'subscription',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Fail`
  String get fail {
    return Intl.message(
      'Fail',
      name: 'fail',
      desc: '',
      args: [],
    );
  }

  /// `Who Am I?`
  String get whoAmI {
    return Intl.message(
      'Who Am I?',
      name: 'whoAmI',
      desc: '',
      args: [],
    );
  }

  /// `Select Role`
  String get selectRole {
    return Intl.message(
      'Select Role',
      name: 'selectRole',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get service {
    return Intl.message(
      'Service',
      name: 'service',
      desc: '',
      args: [],
    );
  }

  /// `Current Window`
  String get currentWindow {
    return Intl.message(
      'Current Window',
      name: 'currentWindow',
      desc: '',
      args: [],
    );
  }

  /// `Setup The Business`
  String get setupTheBusiness {
    return Intl.message(
      'Setup The Business',
      name: 'setupTheBusiness',
      desc: '',
      args: [],
    );
  }

  /// `Token Management`
  String get tokenManagement {
    return Intl.message(
      'Token Management',
      name: 'tokenManagement',
      desc: '',
      args: [],
    );
  }

  /// `Web Site`
  String get webSite {
    return Intl.message(
      'Web Site',
      name: 'webSite',
      desc: '',
      args: [],
    );
  }

  /// `Download Data`
  String get downloadData {
    return Intl.message(
      'Download Data',
      name: 'downloadData',
      desc: '',
      args: [],
    );
  }

  /// `Feedback Data`
  String get feedbackData {
    return Intl.message(
      'Feedback Data',
      name: 'feedbackData',
      desc: '',
      args: [],
    );
  }

  /// `Feedback Data Last 1 Days`
  String get feedbackDataLast1Days {
    return Intl.message(
      'Feedback Data Last 1 Days',
      name: 'feedbackDataLast1Days',
      desc: '',
      args: [],
    );
  }

  /// `Feedback Data Last 3 Days`
  String get feedbackDataLast3Days {
    return Intl.message(
      'Feedback Data Last 3 Days',
      name: 'feedbackDataLast3Days',
      desc: '',
      args: [],
    );
  }

  /// `Feedback Data Last 7 Days`
  String get feedbackDataLast7Days {
    return Intl.message(
      'Feedback Data Last 7 Days',
      name: 'feedbackDataLast7Days',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedback {
    return Intl.message(
      'Feedback',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Windows`
  String get windows {
    return Intl.message(
      'Windows',
      name: 'windows',
      desc: '',
      args: [],
    );
  }

  /// `Window Info`
  String get windowInfo {
    return Intl.message(
      'Window Info',
      name: 'windowInfo',
      desc: '',
      args: [],
    );
  }

  /// `Add Photo`
  String get addPhoto {
    return Intl.message(
      'Add Photo',
      name: 'addPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Remove Photo`
  String get removePhoto {
    return Intl.message(
      'Remove Photo',
      name: 'removePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Add Logo`
  String get addLogo {
    return Intl.message(
      'Add Logo',
      name: 'addLogo',
      desc: '',
      args: [],
    );
  }

  /// `Remove Logo`
  String get removeLogo {
    return Intl.message(
      'Remove Logo',
      name: 'removeLogo',
      desc: '',
      args: [],
    );
  }

  /// `Make Idle`
  String get makeIdle {
    return Intl.message(
      'Make Idle',
      name: 'makeIdle',
      desc: '',
      args: [],
    );
  }

  /// `Read This`
  String get readThis {
    return Intl.message(
      'Read This',
      name: 'readThis',
      desc: '',
      args: [],
    );
  }

  /// `I am Employee`
  String get iAmEmployee {
    return Intl.message(
      'I am Employee',
      name: 'iAmEmployee',
      desc: '',
      args: [],
    );
  }

  /// `I am ADMIN`
  String get iAmAdmin {
    return Intl.message(
      'I am ADMIN',
      name: 'iAmAdmin',
      desc: '',
      args: [],
    );
  }

  /// `Open Image Galerry`
  String get openImageGalerry {
    return Intl.message(
      'Open Image Galerry',
      name: 'openImageGalerry',
      desc: '',
      args: [],
    );
  }

  /// `Open Camera`
  String get openCamera {
    return Intl.message(
      'Open Camera',
      name: 'openCamera',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `My Token`
  String get myToken {
    return Intl.message(
      'My Token',
      name: 'myToken',
      desc: '',
      args: [],
    );
  }

  /// `Add Token`
  String get addToken {
    return Intl.message(
      'Add Token',
      name: 'addToken',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Business Info`
  String get businessInfo {
    return Intl.message(
      'Business Info',
      name: 'businessInfo',
      desc: '',
      args: [],
    );
  }

  /// `Counter Info`
  String get counterInfo {
    return Intl.message(
      'Counter Info',
      name: 'counterInfo',
      desc: '',
      args: [],
    );
  }

  /// `Queue History`
  String get queueHistory {
    return Intl.message(
      'Queue History',
      name: 'queueHistory',
      desc: '',
      args: [],
    );
  }

  /// `Visitor History`
  String get visitorHistory {
    return Intl.message(
      'Visitor History',
      name: 'visitorHistory',
      desc: '',
      args: [],
    );
  }

  /// `Service Info`
  String get serviceInfo {
    return Intl.message(
      'Service Info',
      name: 'serviceInfo',
      desc: '',
      args: [],
    );
  }

  /// `Personal Info`
  String get personalInfo {
    return Intl.message(
      'Personal Info',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Permission`
  String get permission {
    return Intl.message(
      'Permission',
      name: 'permission',
      desc: '',
      args: [],
    );
  }

  /// `People in waiting`
  String get peopleWait {
    return Intl.message(
      'People in waiting',
      name: 'peopleWait',
      desc: '',
      args: [],
    );
  }

  /// `Token Number`
  String get tokenNumber {
    return Intl.message(
      'Token Number',
      name: 'tokenNumber',
      desc: '',
      args: [],
    );
  }

  /// `Proceed to`
  String get proceedTo {
    return Intl.message(
      'Proceed to',
      name: 'proceedTo',
      desc: '',
      args: [],
    );
  }

  /// `Counter`
  String get counter {
    return Intl.message(
      'Counter',
      name: 'counter',
      desc: '',
      args: [],
    );
  }

  /// `Waiting`
  String get waiting {
    return Intl.message(
      'Waiting',
      name: 'waiting',
      desc: '',
      args: [],
    );
  }

  /// `Created`
  String get createdDate {
    return Intl.message(
      'Created',
      name: 'createdDate',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get statusQueue {
    return Intl.message(
      'Status',
      name: 'statusQueue',
      desc: '',
      args: [],
    );
  }

  /// `Current Token`
  String get currentToken {
    return Intl.message(
      'Current Token',
      name: 'currentToken',
      desc: '',
      args: [],
    );
  }

  /// `My Queue`
  String get myQueue {
    return Intl.message(
      'My Queue',
      name: 'myQueue',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `My Queue Today`
  String get myQueueToday {
    return Intl.message(
      'My Queue Today',
      name: 'myQueueToday',
      desc: '',
      args: [],
    );
  }

  /// `Open Web Site`
  String get openWebSite {
    return Intl.message(
      'Open Web Site',
      name: 'openWebSite',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe`
  String get subscribe {
    return Intl.message(
      'Subscribe',
      name: 'subscribe',
      desc: '',
      args: [],
    );
  }

  /// `Unsubscribe`
  String get unsubscribe {
    return Intl.message(
      'Unsubscribe',
      name: 'unsubscribe',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Vibration`
  String get vibration {
    return Intl.message(
      'Vibration',
      name: 'vibration',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Running On`
  String get runningOn {
    return Intl.message(
      'Running On',
      name: 'runningOn',
      desc: '',
      args: [],
    );
  }

  /// `Version Name`
  String get versionName {
    return Intl.message(
      'Version Name',
      name: 'versionName',
      desc: '',
      args: [],
    );
  }

  /// `Version Code`
  String get versionCode {
    return Intl.message(
      'Version Code',
      name: 'versionCode',
      desc: '',
      args: [],
    );
  }

  /// `App ID`
  String get appId {
    return Intl.message(
      'App ID',
      name: 'appId',
      desc: '',
      args: [],
    );
  }

  /// `Local Time`
  String get localTime {
    return Intl.message(
      'Local Time',
      name: 'localTime',
      desc: '',
      args: [],
    );
  }

  /// `Timezone`
  String get timezone {
    return Intl.message(
      'Timezone',
      name: 'timezone',
      desc: '',
      args: [],
    );
  }

  /// `My Phone Number`
  String get myPhoneNumber {
    return Intl.message(
      'My Phone Number',
      name: 'myPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `My Email`
  String get myEmail {
    return Intl.message(
      'My Email',
      name: 'myEmail',
      desc: '',
      args: [],
    );
  }

  /// `Switch Account`
  String get switchAccount {
    return Intl.message(
      'Switch Account',
      name: 'switchAccount',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Purchase History`
  String get purchaseHistory {
    return Intl.message(
      'Purchase History',
      name: 'purchaseHistory',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe Now`
  String get subscribeNow {
    return Intl.message(
      'Subscribe Now',
      name: 'subscribeNow',
      desc: '',
      args: [],
    );
  }

  /// `Have an account? Sign in`
  String get haveAnAccount {
    return Intl.message(
      'Have an account? Sign in',
      name: 'haveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Signout`
  String get signout {
    return Intl.message(
      'Signout',
      name: 'signout',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signin {
    return Intl.message(
      'Sign in',
      name: 'signin',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get login {
    return Intl.message(
      'Log in',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `We'll send an SMS message to verify your identity, please enter your number right below!`
  String get loginMessage {
    return Intl.message(
      'We\'ll send an SMS message to verify your identity, please enter your number right below!',
      name: 'loginMessage',
      desc: '',
      args: [],
    );
  }

  /// `Verification Code`
  String get verificationCode {
    return Intl.message(
      'Verification Code',
      name: 'verificationCode',
      desc: '',
      args: [],
    );
  }

  /// `If your code does not arrive in 1 minute, touch`
  String get pinNotArrive {
    return Intl.message(
      'If your code does not arrive in 1 minute, touch',
      name: 'pinNotArrive',
      desc: '',
      args: [],
    );
  }

  /// `here`
  String get here {
    return Intl.message(
      'here',
      name: 'here',
      desc: '',
      args: [],
    );
  }

  /// `Do you want exit`
  String get wantExit {
    return Intl.message(
      'Do you want exit',
      name: 'wantExit',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `ago`
  String get ago {
    return Intl.message(
      'ago',
      name: 'ago',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't verify your code, please try again!`
  String get wrongVerifyCode {
    return Intl.message(
      'We couldn\'t verify your code, please try again!',
      name: 'wrongVerifyCode',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't create your profile for now, please try again later`
  String get cannotCreateProfile {
    return Intl.message(
      'We couldn\'t create your profile for now, please try again later',
      name: 'cannotCreateProfile',
      desc: '',
      args: [],
    );
  }

  /// `You can't retry yet!`
  String get cannotRetry {
    return Intl.message(
      'You can\'t retry yet!',
      name: 'cannotRetry',
      desc: '',
      args: [],
    );
  }

  /// `Your phone number can't be empty!`
  String get cannotPhoneEmpty {
    return Intl.message(
      'Your phone number can\'t be empty!',
      name: 'cannotPhoneEmpty',
      desc: '',
      args: [],
    );
  }

  /// `This phone number is invalid!`
  String get invalidPhone {
    return Intl.message(
      'This phone number is invalid!',
      name: 'invalidPhone',
      desc: '',
      args: [],
    );
  }

  /// `Your verification code can't be empty!`
  String get cannotVerificationCodeEmpty {
    return Intl.message(
      'Your verification code can\'t be empty!',
      name: 'cannotVerificationCodeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `This verification code is invalid!`
  String get invalidVerificationCode {
    return Intl.message(
      'This verification code is invalid!',
      name: 'invalidVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Open Display Unit`
  String get openDisplayUnit {
    return Intl.message(
      'Open Display Unit',
      name: 'openDisplayUnit',
      desc: '',
      args: [],
    );
  }

  /// `Show Queue History`
  String get showQueueHistory {
    return Intl.message(
      'Show Queue History',
      name: 'showQueueHistory',
      desc: '',
      args: [],
    );
  }

  /// `Issue Token`
  String get issueToken {
    return Intl.message(
      'Issue Token',
      name: 'issueToken',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Waited for Complete`
  String get waitedForComplete {
    return Intl.message(
      'Waited for Complete',
      name: 'waitedForComplete',
      desc: '',
      args: [],
    );
  }

  /// `You cannot issue the token during holiday. Today is `
  String get cannotIssueTokenHoliday {
    return Intl.message(
      'You cannot issue the token during holiday. Today is ',
      name: 'cannotIssueTokenHoliday',
      desc: '',
      args: [],
    );
  }

  /// `You must issue the token during office hours`
  String get mustIssueTokenOfficeHours {
    return Intl.message(
      'You must issue the token during office hours',
      name: 'mustIssueTokenOfficeHours',
      desc: '',
      args: [],
    );
  }

  /// `Does not meet the time interval for create next token.`
  String get notMeetTimeInterval {
    return Intl.message(
      'Does not meet the time interval for create next token.',
      name: 'notMeetTimeInterval',
      desc: '',
      args: [],
    );
  }

  /// `Token List`
  String get tokenList {
    return Intl.message(
      'Token List',
      name: 'tokenList',
      desc: '',
      args: [],
    );
  }

  /// `Next Token`
  String get nextToken {
    return Intl.message(
      'Next Token',
      name: 'nextToken',
      desc: '',
      args: [],
    );
  }

  /// `Select a Department`
  String get selectDepartment {
    return Intl.message(
      'Select a Department',
      name: 'selectDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Select a Counter`
  String get selectCounter {
    return Intl.message(
      'Select a Counter',
      name: 'selectCounter',
      desc: '',
      args: [],
    );
  }

  /// `Recall`
  String get recall {
    return Intl.message(
      'Recall',
      name: 'recall',
      desc: '',
      args: [],
    );
  }

  /// `CURRENT STORE`
  String get currentStore {
    return Intl.message(
      'CURRENT STORE',
      name: 'currentStore',
      desc: '',
      args: [],
    );
  }

  /// `Store List`
  String get storeList {
    return Intl.message(
      'Store List',
      name: 'storeList',
      desc: '',
      args: [],
    );
  }

  /// `Do you want recall?`
  String get doYouWantRecall {
    return Intl.message(
      'Do you want recall?',
      name: 'doYouWantRecall',
      desc: '',
      args: [],
    );
  }

  /// `Department`
  String get department {
    return Intl.message(
      'Department',
      name: 'department',
      desc: '',
      args: [],
    );
  }

  /// `Insight Compare`
  String get insightCompare {
    return Intl.message(
      'Insight Compare',
      name: 'insightCompare',
      desc: '',
      args: [],
    );
  }

  /// `Insight Last 7 Days`
  String get insightLast7days {
    return Intl.message(
      'Insight Last 7 Days',
      name: 'insightLast7days',
      desc: '',
      args: [],
    );
  }

  /// `Insight Today`
  String get insightToday {
    return Intl.message(
      'Insight Today',
      name: 'insightToday',
      desc: '',
      args: [],
    );
  }

  /// `Office Hours`
  String get officeHours {
    return Intl.message(
      'Office Hours',
      name: 'officeHours',
      desc: '',
      args: [],
    );
  }

  /// `Public Holidays`
  String get publicHolidays {
    return Intl.message(
      'Public Holidays',
      name: 'publicHolidays',
      desc: '',
      args: [],
    );
  }

  /// `Store Form`
  String get storeForm {
    return Intl.message(
      'Store Form',
      name: 'storeForm',
      desc: '',
      args: [],
    );
  }

  /// `Report Compare`
  String get reportCompare {
    return Intl.message(
      'Report Compare',
      name: 'reportCompare',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Total Token Count`
  String get totalTokenCount {
    return Intl.message(
      'Total Token Count',
      name: 'totalTokenCount',
      desc: '',
      args: [],
    );
  }

  /// `Report 7 Days Ago`
  String get report7daysAgo {
    return Intl.message(
      'Report 7 Days Ago',
      name: 'report7daysAgo',
      desc: '',
      args: [],
    );
  }

  /// `Report Percentage Today`
  String get reportPercentageToday {
    return Intl.message(
      'Report Percentage Today',
      name: 'reportPercentageToday',
      desc: '',
      args: [],
    );
  }

  /// `Counter List`
  String get counterList {
    return Intl.message(
      'Counter List',
      name: 'counterList',
      desc: '',
      args: [],
    );
  }

  /// `Create Counter`
  String get createCounter {
    return Intl.message(
      'Create Counter',
      name: 'createCounter',
      desc: '',
      args: [],
    );
  }

  /// `Department List`
  String get departmentList {
    return Intl.message(
      'Department List',
      name: 'departmentList',
      desc: '',
      args: [],
    );
  }

  /// `Department Form`
  String get departmentForm {
    return Intl.message(
      'Department Form',
      name: 'departmentForm',
      desc: '',
      args: [],
    );
  }

  /// `Create Department`
  String get createDepartment {
    return Intl.message(
      'Create Department',
      name: 'createDepartment',
      desc: '',
      args: [],
    );
  }

  /// `LETTER`
  String get letter {
    return Intl.message(
      'LETTER',
      name: 'letter',
      desc: '',
      args: [],
    );
  }

  /// `START`
  String get start {
    return Intl.message(
      'START',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Time Interval to Issue Token`
  String get timeIntervalToIssueToken {
    return Intl.message(
      'Time Interval to Issue Token',
      name: 'timeIntervalToIssueToken',
      desc: '',
      args: [],
    );
  }

  /// `Time Interval is for prevent the user repeat issue the token. This is a setting in minitue unit.`
  String get timeIntervalToIssueTokenText {
    return Intl.message(
      'Time Interval is for prevent the user repeat issue the token. This is a setting in minitue unit.',
      name: 'timeIntervalToIssueTokenText',
      desc: '',
      args: [],
    );
  }

  /// `Time Interval`
  String get timeInterval {
    return Intl.message(
      'Time Interval',
      name: 'timeInterval',
      desc: '',
      args: [],
    );
  }

  /// `Example: 2 minutes`
  String get timeIntervalHint {
    return Intl.message(
      'Example: 2 minutes',
      name: 'timeIntervalHint',
      desc: '',
      args: [],
    );
  }

  /// `SAVE`
  String get save {
    return Intl.message(
      'SAVE',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Holiday List`
  String get holidayList {
    return Intl.message(
      'Holiday List',
      name: 'holidayList',
      desc: '',
      args: [],
    );
  }

  /// `Holiday Date`
  String get holidayDate {
    return Intl.message(
      'Holiday Date',
      name: 'holidayDate',
      desc: '',
      args: [],
    );
  }

  /// `What is Holiday Name?`
  String get whatIsHolidayName {
    return Intl.message(
      'What is Holiday Name?',
      name: 'whatIsHolidayName',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Some Text`
  String get pleaseEnterSomeText {
    return Intl.message(
      'Please Enter Some Text',
      name: 'pleaseEnterSomeText',
      desc: '',
      args: [],
    );
  }

  /// `Create Holiday`
  String get createHoliday {
    return Intl.message(
      'Create Holiday',
      name: 'createHoliday',
      desc: '',
      args: [],
    );
  }

  /// `Holiday Form`
  String get holidayForm {
    return Intl.message(
      'Holiday Form',
      name: 'holidayForm',
      desc: '',
      args: [],
    );
  }

  /// `To enable Holiday, the switch MUST be ON.`
  String get enableHolidayText {
    return Intl.message(
      'To enable Holiday, the switch MUST be ON.',
      name: 'enableHolidayText',
      desc: '',
      args: [],
    );
  }

  /// `Office Hours List`
  String get officeHoursList {
    return Intl.message(
      'Office Hours List',
      name: 'officeHoursList',
      desc: '',
      args: [],
    );
  }

  /// `Create Office Hours`
  String get createOfficeHours {
    return Intl.message(
      'Create Office Hours',
      name: 'createOfficeHours',
      desc: '',
      args: [],
    );
  }

  /// `Enable This Store`
  String get enableThisStore {
    return Intl.message(
      'Enable This Store',
      name: 'enableThisStore',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Counter Form`
  String get counterForm {
    return Intl.message(
      'Counter Form',
      name: 'counterForm',
      desc: '',
      args: [],
    );
  }

  /// `Do you want reset the token number to start number?`
  String get wantResetTokenNumber {
    return Intl.message(
      'Do you want reset the token number to start number?',
      name: 'wantResetTokenNumber',
      desc: '',
      args: [],
    );
  }

  /// `Reset Token Number`
  String get resetTokenNumber {
    return Intl.message(
      'Reset Token Number',
      name: 'resetTokenNumber',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Do you accept?`
  String get doYouAccept {
    return Intl.message(
      'Do you accept?',
      name: 'doYouAccept',
      desc: '',
      args: [],
    );
  }

  /// `Call Token`
  String get callToken {
    return Intl.message(
      'Call Token',
      name: 'callToken',
      desc: '',
      args: [],
    );
  }

  /// `to Start Number`
  String get toStartNumber {
    return Intl.message(
      'to Start Number',
      name: 'toStartNumber',
      desc: '',
      args: [],
    );
  }

  /// `Office Hours Form`
  String get officeHoursForm {
    return Intl.message(
      'Office Hours Form',
      name: 'officeHoursForm',
      desc: '',
      args: [],
    );
  }

  /// `To enable issue the token on client APP, the switch MUST be ON.`
  String get enableOfficeHours {
    return Intl.message(
      'To enable issue the token on client APP, the switch MUST be ON.',
      name: 'enableOfficeHours',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get monday {
    return Intl.message(
      'Monday',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get tuesday {
    return Intl.message(
      'Tuesday',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message(
      'Wednesday',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get thursday {
    return Intl.message(
      'Thursday',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get friday {
    return Intl.message(
      'Friday',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get saturday {
    return Intl.message(
      'Saturday',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get sunday {
    return Intl.message(
      'Sunday',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `Admin`
  String get admin {
    return Intl.message(
      'Admin',
      name: 'admin',
      desc: '',
      args: [],
    );
  }

  /// `Admin Login`
  String get adminLogin {
    return Intl.message(
      'Admin Login',
      name: 'adminLogin',
      desc: '',
      args: [],
    );
  }

  /// `Captured`
  String get captured {
    return Intl.message(
      'Captured',
      name: 'captured',
      desc: '',
      args: [],
    );
  }

  /// `meter`
  String get meter {
    return Intl.message(
      'meter',
      name: 'meter',
      desc: '',
      args: [],
    );
  }

  /// `kilometer`
  String get kilometer {
    return Intl.message(
      'kilometer',
      name: 'kilometer',
      desc: '',
      args: [],
    );
  }

  /// `away`
  String get away {
    return Intl.message(
      'away',
      name: 'away',
      desc: '',
      args: [],
    );
  }

  /// `Distance`
  String get distance {
    return Intl.message(
      'Distance',
      name: 'distance',
      desc: '',
      args: [],
    );
  }

  /// `User Profile`
  String get userProfile {
    return Intl.message(
      'User Profile',
      name: 'userProfile',
      desc: '',
      args: [],
    );
  }

  /// `Visitor Profile`
  String get visitorProfile {
    return Intl.message(
      'Visitor Profile',
      name: 'visitorProfile',
      desc: '',
      args: [],
    );
  }

  /// `App Info`
  String get appInfo {
    return Intl.message(
      'App Info',
      name: 'appInfo',
      desc: '',
      args: [],
    );
  }

  /// `Online`
  String get online {
    return Intl.message(
      'Online',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `Offline`
  String get offline {
    return Intl.message(
      'Offline',
      name: 'offline',
      desc: '',
      args: [],
    );
  }

  /// `No More Next Token`
  String get noMoreNextToken {
    return Intl.message(
      'No More Next Token',
      name: 'noMoreNextToken',
      desc: '',
      args: [],
    );
  }

  /// `The user with this email should login with the client APP to check the real time latest token number.`
  String get issueTokenAdminText {
    return Intl.message(
      'The user with this email should login with the client APP to check the real time latest token number.',
      name: 'issueTokenAdminText',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Do you want remove?`
  String get wantRemove {
    return Intl.message(
      'Do you want remove?',
      name: 'wantRemove',
      desc: '',
      args: [],
    );
  }

  /// `Store`
  String get store {
    return Intl.message(
      'Store',
      name: 'store',
      desc: '',
      args: [],
    );
  }

  /// `Available Store`
  String get availableStore {
    return Intl.message(
      'Available Store',
      name: 'availableStore',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Dial Phone`
  String get dialPhone {
    return Intl.message(
      'Dial Phone',
      name: 'dialPhone',
      desc: '',
      args: [],
    );
  }

  /// `Dial`
  String get dial {
    return Intl.message(
      'Dial',
      name: 'dial',
      desc: '',
      args: [],
    );
  }

  /// `Send Email`
  String get sendEmail {
    return Intl.message(
      'Send Email',
      name: 'sendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Coordinates`
  String get coordinates {
    return Intl.message(
      'Coordinates',
      name: 'coordinates',
      desc: '',
      args: [],
    );
  }

  /// `Show Waiting Queue History`
  String get showWaitingQueueHistory {
    return Intl.message(
      'Show Waiting Queue History',
      name: 'showWaitingQueueHistory',
      desc: '',
      args: [],
    );
  }

  /// `Confirm?`
  String get wantConfirm {
    return Intl.message(
      'Confirm?',
      name: 'wantConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Store Setting`
  String get storeSetting {
    return Intl.message(
      'Store Setting',
      name: 'storeSetting',
      desc: '',
      args: [],
    );
  }

  /// `Insight`
  String get insight {
    return Intl.message(
      'Insight',
      name: 'insight',
      desc: '',
      args: [],
    );
  }

  /// `Other Setting`
  String get otherSetting {
    return Intl.message(
      'Other Setting',
      name: 'otherSetting',
      desc: '',
      args: [],
    );
  }

  /// `Options`
  String get options {
    return Intl.message(
      'Options',
      name: 'options',
      desc: '',
      args: [],
    );
  }

  /// `Call Now`
  String get callNow {
    return Intl.message(
      'Call Now',
      name: 'callNow',
      desc: '',
      args: [],
    );
  }

  /// `Setup Bluetooth Printer`
  String get setupBluetoothPrinter {
    return Intl.message(
      'Setup Bluetooth Printer',
      name: 'setupBluetoothPrinter',
      desc: '',
      args: [],
    );
  }

  /// `Select Bluetooth Printer`
  String get selectBluetoothPrinter {
    return Intl.message(
      'Select Bluetooth Printer',
      name: 'selectBluetoothPrinter',
      desc: '',
      args: [],
    );
  }

  /// `Discover Bluetooth`
  String get discoverBluetooth {
    return Intl.message(
      'Discover Bluetooth',
      name: 'discoverBluetooth',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get connect {
    return Intl.message(
      'Connect',
      name: 'connect',
      desc: '',
      args: [],
    );
  }

  /// `Disconnect`
  String get disconnect {
    return Intl.message(
      'Disconnect',
      name: 'disconnect',
      desc: '',
      args: [],
    );
  }

  /// `Test Printing`
  String get testPrinting {
    return Intl.message(
      'Test Printing',
      name: 'testPrinting',
      desc: '',
      args: [],
    );
  }

  /// `Connection`
  String get connection {
    return Intl.message(
      'Connection',
      name: 'connection',
      desc: '',
      args: [],
    );
  }

  /// `Cannot Print`
  String get cannotPrint {
    return Intl.message(
      'Cannot Print',
      name: 'cannotPrint',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Select Photo`
  String get selectPhoto {
    return Intl.message(
      'Select Photo',
      name: 'selectPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Only Accept Image Format`
  String get onlyAcceptImageFormatNote {
    return Intl.message(
      'Only Accept Image Format',
      name: 'onlyAcceptImageFormatNote',
      desc: '',
      args: [],
    );
  }

  /// `Select And Upload Photo`
  String get selectAndUploadPhoto {
    return Intl.message(
      'Select And Upload Photo',
      name: 'selectAndUploadPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Should Select Photo`
  String get shouldSelectPhoto {
    return Intl.message(
      'Should Select Photo',
      name: 'shouldSelectPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Window Wizard`
  String get windowWizard {
    return Intl.message(
      'Window Wizard',
      name: 'windowWizard',
      desc: '',
      args: [],
    );
  }

  /// `Service Wizard`
  String get serviceWizard {
    return Intl.message(
      'Service Wizard',
      name: 'serviceWizard',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Setup Employees`
  String get setupEmployees {
    return Intl.message(
      'Setup Employees',
      name: 'setupEmployees',
      desc: '',
      args: [],
    );
  }

  /// `Edit Employee`
  String get editEmployee {
    return Intl.message(
      'Edit Employee',
      name: 'editEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Employee Info`
  String get employeeInfo {
    return Intl.message(
      'Employee Info',
      name: 'employeeInfo',
      desc: '',
      args: [],
    );
  }

  /// `Employee List`
  String get employeeList {
    return Intl.message(
      'Employee List',
      name: 'employeeList',
      desc: '',
      args: [],
    );
  }

  /// `Employee`
  String get employee {
    return Intl.message(
      'Employee',
      name: 'employee',
      desc: '',
      args: [],
    );
  }

  /// `Employee Profile`
  String get employeeProfile {
    return Intl.message(
      'Employee Profile',
      name: 'employeeProfile',
      desc: '',
      args: [],
    );
  }

  /// `Setup Language`
  String get setupLanguage {
    return Intl.message(
      'Setup Language',
      name: 'setupLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Setup the Stall`
  String get setupTheStall {
    return Intl.message(
      'Setup the Stall',
      name: 'setupTheStall',
      desc: '',
      args: [],
    );
  }

  /// `Setup Printer`
  String get setupPrinter {
    return Intl.message(
      'Setup Printer',
      name: 'setupPrinter',
      desc: '',
      args: [],
    );
  }

  /// `Visitor List`
  String get visitorList {
    return Intl.message(
      'Visitor List',
      name: 'visitorList',
      desc: '',
      args: [],
    );
  }

  /// `Board Setting`
  String get boardSetting {
    return Intl.message(
      'Board Setting',
      name: 'boardSetting',
      desc: '',
      args: [],
    );
  }

  /// `Pair Code`
  String get pairCode {
    return Intl.message(
      'Pair Code',
      name: 'pairCode',
      desc: '',
      args: [],
    );
  }

  /// `Window`
  String get window {
    return Intl.message(
      'Window',
      name: 'window',
      desc: '',
      args: [],
    );
  }

  /// `Service List`
  String get serviceList {
    return Intl.message(
      'Service List',
      name: 'serviceList',
      desc: '',
      args: [],
    );
  }

  /// `Service Form`
  String get serviceForm {
    return Intl.message(
      'Service Form',
      name: 'serviceForm',
      desc: '',
      args: [],
    );
  }

  /// `Service Name`
  String get serviceName {
    return Intl.message(
      'Service Name',
      name: 'serviceName',
      desc: '',
      args: [],
    );
  }

  /// `Service Letter`
  String get serviceLetter {
    return Intl.message(
      'Service Letter',
      name: 'serviceLetter',
      desc: '',
      args: [],
    );
  }

  /// `Start Number`
  String get startNumber {
    return Intl.message(
      'Start Number',
      name: 'startNumber',
      desc: '',
      args: [],
    );
  }

  /// `Setup Window`
  String get setupWindow {
    return Intl.message(
      'Setup Window',
      name: 'setupWindow',
      desc: '',
      args: [],
    );
  }

  /// `Window Form`
  String get windowForm {
    return Intl.message(
      'Window Form',
      name: 'windowForm',
      desc: '',
      args: [],
    );
  }

  /// `Window Name`
  String get windowName {
    return Intl.message(
      'Window Name',
      name: 'windowName',
      desc: '',
      args: [],
    );
  }

  /// `Enable Window`
  String get enableWindow {
    return Intl.message(
      'Enable Window',
      name: 'enableWindow',
      desc: '',
      args: [],
    );
  }

  /// `Edit Window`
  String get editWindow {
    return Intl.message(
      'Edit Window',
      name: 'editWindow',
      desc: '',
      args: [],
    );
  }

  /// `Open Service List`
  String get openServiceList {
    return Intl.message(
      'Open Service List',
      name: 'openServiceList',
      desc: '',
      args: [],
    );
  }

  /// `Move Up`
  String get moveUp {
    return Intl.message(
      'Move Up',
      name: 'moveUp',
      desc: '',
      args: [],
    );
  }

  /// `Move Down`
  String get moveDown {
    return Intl.message(
      'Move Down',
      name: 'moveDown',
      desc: '',
      args: [],
    );
  }

  /// `Edit Service`
  String get editService {
    return Intl.message(
      'Edit Service',
      name: 'editService',
      desc: '',
      args: [],
    );
  }

  /// `Visit us at`
  String get visitUsAt {
    return Intl.message(
      'Visit us at',
      name: 'visitUsAt',
      desc: '',
      args: [],
    );
  }

  /// `App Name`
  String get appName {
    return Intl.message(
      'App Name',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Package Name`
  String get packageName {
    return Intl.message(
      'Package Name',
      name: 'packageName',
      desc: '',
      args: [],
    );
  }

  /// `Build Number`
  String get buildNumber {
    return Intl.message(
      'Build Number',
      name: 'buildNumber',
      desc: '',
      args: [],
    );
  }

  /// `Version Number`
  String get versionNumber {
    return Intl.message(
      'Version Number',
      name: 'versionNumber',
      desc: '',
      args: [],
    );
  }

  /// `Terms of use`
  String get termsOfUse {
    return Intl.message(
      'Terms of use',
      name: 'termsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get privacy {
    return Intl.message(
      'Privacy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Device`
  String get device {
    return Intl.message(
      'Device',
      name: 'device',
      desc: '',
      args: [],
    );
  }

  /// `Test Print`
  String get testPrint {
    return Intl.message(
      'Test Print',
      name: 'testPrint',
      desc: '',
      args: [],
    );
  }

  /// `Print Token`
  String get printToken {
    return Intl.message(
      'Print Token',
      name: 'printToken',
      desc: '',
      args: [],
    );
  }

  /// `Token Detail`
  String get tokenDetail {
    return Intl.message(
      'Token Detail',
      name: 'tokenDetail',
      desc: '',
      args: [],
    );
  }

  /// `Mark as Completed`
  String get markAsCompleted {
    return Intl.message(
      'Mark as Completed',
      name: 'markAsCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Mark All as Completed`
  String get markAllAsCompleted {
    return Intl.message(
      'Mark All as Completed',
      name: 'markAllAsCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Mark Complete`
  String get markComplete {
    return Intl.message(
      'Mark Complete',
      name: 'markComplete',
      desc: '',
      args: [],
    );
  }

  /// `Recall Token`
  String get recallToken {
    return Intl.message(
      'Recall Token',
      name: 'recallToken',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Token`
  String get transferToken {
    return Intl.message(
      'Transfer Token',
      name: 'transferToken',
      desc: '',
      args: [],
    );
  }

  /// `Home Page`
  String get homePage {
    return Intl.message(
      'Home Page',
      name: 'homePage',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Edit Counter`
  String get editCounter {
    return Intl.message(
      'Edit Counter',
      name: 'editCounter',
      desc: '',
      args: [],
    );
  }

  /// `Open Edit Counter`
  String get openEditCounter {
    return Intl.message(
      'Open Edit Counter',
      name: 'openEditCounter',
      desc: '',
      args: [],
    );
  }

  /// `Open Counter List`
  String get openCounterList {
    return Intl.message(
      'Open Counter List',
      name: 'openCounterList',
      desc: '',
      args: [],
    );
  }

  /// `Setup Functionality`
  String get setupFunctionality {
    return Intl.message(
      'Setup Functionality',
      name: 'setupFunctionality',
      desc: '',
      args: [],
    );
  }

  /// `I Will Be The Employee`
  String get iWillBeTheEmployee {
    return Intl.message(
      'I Will Be The Employee',
      name: 'iWillBeTheEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Setup Counter`
  String get setupCounter {
    return Intl.message(
      'Setup Counter',
      name: 'setupCounter',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Setup Business Info`
  String get setupBizInfo {
    return Intl.message(
      'Setup Business Info',
      name: 'setupBizInfo',
      desc: '',
      args: [],
    );
  }

  /// `Setup Opening Hours`
  String get setupOpeningHours {
    return Intl.message(
      'Setup Opening Hours',
      name: 'setupOpeningHours',
      desc: '',
      args: [],
    );
  }

  /// `Setup Max Token Number`
  String get setupMaxTokenNumber {
    return Intl.message(
      'Setup Max Token Number',
      name: 'setupMaxTokenNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enable Or Disable`
  String get enableOrDisable {
    return Intl.message(
      'Enable Or Disable',
      name: 'enableOrDisable',
      desc: '',
      args: [],
    );
  }

  /// `Opening Hours`
  String get openingHours {
    return Intl.message(
      'Opening Hours',
      name: 'openingHours',
      desc: '',
      args: [],
    );
  }

  /// `Background Color`
  String get backgroundColor {
    return Intl.message(
      'Background Color',
      name: 'backgroundColor',
      desc: '',
      args: [],
    );
  }

  /// `Text Color`
  String get textColor {
    return Intl.message(
      'Text Color',
      name: 'textColor',
      desc: '',
      args: [],
    );
  }

  /// `Number Of Token Box`
  String get numberOfTokenBox {
    return Intl.message(
      'Number Of Token Box',
      name: 'numberOfTokenBox',
      desc: '',
      args: [],
    );
  }

  /// `Token Box Number`
  String get tokenBoxNumber {
    return Intl.message(
      'Token Box Number',
      name: 'tokenBoxNumber',
      desc: '',
      args: [],
    );
  }

  /// `Font Scale`
  String get fontScale {
    return Intl.message(
      'Font Scale',
      name: 'fontScale',
      desc: '',
      args: [],
    );
  }

  /// `Page Size`
  String get pageSize {
    return Intl.message(
      'Page Size',
      name: 'pageSize',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Token`
  String get cancelToken {
    return Intl.message(
      'Cancel Token',
      name: 'cancelToken',
      desc: '',
      args: [],
    );
  }

  /// `Report Issue`
  String get reportIssue {
    return Intl.message(
      'Report Issue',
      name: 'reportIssue',
      desc: '',
      args: [],
    );
  }

  /// `Share Token Info`
  String get shareTokenInfo {
    return Intl.message(
      'Share Token Info',
      name: 'shareTokenInfo',
      desc: '',
      args: [],
    );
  }

  /// `Open Board Screen`
  String get openBoardScreen {
    return Intl.message(
      'Open Board Screen',
      name: 'openBoardScreen',
      desc: '',
      args: [],
    );
  }

  /// `Open Biz Profile`
  String get openBizProfile {
    return Intl.message(
      'Open Biz Profile',
      name: 'openBizProfile',
      desc: '',
      args: [],
    );
  }

  /// `Token Canceled`
  String get tokenCanceled {
    return Intl.message(
      'Token Canceled',
      name: 'tokenCanceled',
      desc: '',
      args: [],
    );
  }

  /// `Add Video`
  String get addVideo {
    return Intl.message(
      'Add Video',
      name: 'addVideo',
      desc: '',
      args: [],
    );
  }

  /// `Remove Video`
  String get removeVideo {
    return Intl.message(
      'Remove Video',
      name: 'removeVideo',
      desc: '',
      args: [],
    );
  }

  /// `Token Created`
  String get tokenCreated {
    return Intl.message(
      'Token Created',
      name: 'tokenCreated',
      desc: '',
      args: [],
    );
  }

  /// `Add Window`
  String get addWindow {
    return Intl.message(
      'Add Window',
      name: 'addWindow',
      desc: '',
      args: [],
    );
  }

  /// `Add Service`
  String get addService {
    return Intl.message(
      'Add Service',
      name: 'addService',
      desc: '',
      args: [],
    );
  }

  /// `Add Counter`
  String get addCounter {
    return Intl.message(
      'Add Counter',
      name: 'addCounter',
      desc: '',
      args: [],
    );
  }

  /// `Add Employee`
  String get addEmployee {
    return Intl.message(
      'Add Employee',
      name: 'addEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Add Printer`
  String get addPrinter {
    return Intl.message(
      'Add Printer',
      name: 'addPrinter',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get hours {
    return Intl.message(
      'Hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `Select Company`
  String get selectCompany {
    return Intl.message(
      'Select Company',
      name: 'selectCompany',
      desc: '',
      args: [],
    );
  }

  /// `Token Information`
  String get tokenInformation {
    return Intl.message(
      'Token Information',
      name: 'tokenInformation',
      desc: '',
      args: [],
    );
  }

  /// `Open Waze`
  String get openWaze {
    return Intl.message(
      'Open Waze',
      name: 'openWaze',
      desc: '',
      args: [],
    );
  }

  /// `Select Your Country`
  String get selectYourCountry {
    return Intl.message(
      'Select Your Country',
      name: 'selectYourCountry',
      desc: '',
      args: [],
    );
  }

  /// `Branch`
  String get branch {
    return Intl.message(
      'Branch',
      name: 'branch',
      desc: '',
      args: [],
    );
  }

  /// `Edit Branch`
  String get editBranch {
    return Intl.message(
      'Edit Branch',
      name: 'editBranch',
      desc: '',
      args: [],
    );
  }

  /// `Branch Info`
  String get branchInfo {
    return Intl.message(
      'Branch Info',
      name: 'branchInfo',
      desc: '',
      args: [],
    );
  }

  /// `Current Branch`
  String get currentBranch {
    return Intl.message(
      'Current Branch',
      name: 'currentBranch',
      desc: '',
      args: [],
    );
  }

  /// `SMS History`
  String get smsHistory {
    return Intl.message(
      'SMS History',
      name: 'smsHistory',
      desc: '',
      args: [],
    );
  }

  /// `Branches`
  String get branches {
    return Intl.message(
      'Branches',
      name: 'branches',
      desc: '',
      args: [],
    );
  }

  /// `Add Branch`
  String get addBranch {
    return Intl.message(
      'Add Branch',
      name: 'addBranch',
      desc: '',
      args: [],
    );
  }

  /// `Message List`
  String get messageList {
    return Intl.message(
      'Message List',
      name: 'messageList',
      desc: '',
      args: [],
    );
  }

  /// `Add Message`
  String get addMessage {
    return Intl.message(
      'Add Message',
      name: 'addMessage',
      desc: '',
      args: [],
    );
  }

  /// `Message Info`
  String get messageInfo {
    return Intl.message(
      'Message Info',
      name: 'messageInfo',
      desc: '',
      args: [],
    );
  }

  /// `Delete Message`
  String get deleteMessage {
    return Intl.message(
      'Delete Message',
      name: 'deleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Push Message`
  String get pushMessage {
    return Intl.message(
      'Push Message',
      name: 'pushMessage',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message(
      'Appearance',
      name: 'appearance',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get scan {
    return Intl.message(
      'Scan',
      name: 'scan',
      desc: '',
      args: [],
    );
  }

  /// `QRCode`
  String get qrcode {
    return Intl.message(
      'QRCode',
      name: 'qrcode',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Category List`
  String get categoryList {
    return Intl.message(
      'Category List',
      name: 'categoryList',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Product List`
  String get productList {
    return Intl.message(
      'Product List',
      name: 'productList',
      desc: '',
      args: [],
    );
  }

  /// `Cart List`
  String get cartList {
    return Intl.message(
      'Cart List',
      name: 'cartList',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Edit Product`
  String get editProduct {
    return Intl.message(
      'Edit Product',
      name: 'editProduct',
      desc: '',
      args: [],
    );
  }

  /// `Edit Category`
  String get editCategory {
    return Intl.message(
      'Edit Category',
      name: 'editCategory',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Total Qty`
  String get totalQty {
    return Intl.message(
      'Total Qty',
      name: 'totalQty',
      desc: '',
      args: [],
    );
  }

  /// `Order Detail`
  String get orderDetail {
    return Intl.message(
      'Order Detail',
      name: 'orderDetail',
      desc: '',
      args: [],
    );
  }

  /// `Enable Branch`
  String get enableBranch {
    return Intl.message(
      'Enable Branch',
      name: 'enableBranch',
      desc: '',
      args: [],
    );
  }

  /// `Add Image`
  String get addImage {
    return Intl.message(
      'Add Image',
      name: 'addImage',
      desc: '',
      args: [],
    );
  }

  /// `Remove Image`
  String get removeImage {
    return Intl.message(
      'Remove Image',
      name: 'removeImage',
      desc: '',
      args: [],
    );
  }

  /// `View Cart`
  String get viewCart {
    return Intl.message(
      'View Cart',
      name: 'viewCart',
      desc: '',
      args: [],
    );
  }

  /// `Empty All`
  String get emptyAll {
    return Intl.message(
      'Empty All',
      name: 'emptyAll',
      desc: '',
      args: [],
    );
  }

  /// `Setup Catalog`
  String get setupCatalog {
    return Intl.message(
      'Setup Catalog',
      name: 'setupCatalog',
      desc: '',
      args: [],
    );
  }

  /// `Notification For Coming Count`
  String get notificationForComingCount {
    return Intl.message(
      'Notification For Coming Count',
      name: 'notificationForComingCount',
      desc: '',
      args: [],
    );
  }

  /// `Coming Count`
  String get comingCount {
    return Intl.message(
      'Coming Count',
      name: 'comingCount',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Order Timeline`
  String get orderTimeline {
    return Intl.message(
      'Order Timeline',
      name: 'orderTimeline',
      desc: '',
      args: [],
    );
  }

  /// `Open Order Timeline`
  String get openOrderTimeline {
    return Intl.message(
      'Open Order Timeline',
      name: 'openOrderTimeline',
      desc: '',
      args: [],
    );
  }

  /// `Add Product`
  String get addProduct {
    return Intl.message(
      'Add Product',
      name: 'addProduct',
      desc: '',
      args: [],
    );
  }

  /// `Add Category`
  String get addCategory {
    return Intl.message(
      'Add Category',
      name: 'addCategory',
      desc: '',
      args: [],
    );
  }

  /// `Add Agent`
  String get addAgent {
    return Intl.message(
      'Add Agent',
      name: 'addAgent',
      desc: '',
      args: [],
    );
  }

  /// `NFC`
  String get nfc {
    return Intl.message(
      'NFC',
      name: 'nfc',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Agents`
  String get agents {
    return Intl.message(
      'Agents',
      name: 'agents',
      desc: '',
      args: [],
    );
  }

  /// `Agent`
  String get agent {
    return Intl.message(
      'Agent',
      name: 'agent',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `Terminal`
  String get terminal {
    return Intl.message(
      'Terminal',
      name: 'terminal',
      desc: '',
      args: [],
    );
  }

  /// `Terminals`
  String get terminals {
    return Intl.message(
      'Terminals',
      name: 'terminals',
      desc: '',
      args: [],
    );
  }

  /// `Toggle Sidebar`
  String get toggleSidebar {
    return Intl.message(
      'Toggle Sidebar',
      name: 'toggleSidebar',
      desc: '',
      args: [],
    );
  }

  /// `New Department`
  String get newDepartment {
    return Intl.message(
      'New Department',
      name: 'newDepartment',
      desc: '',
      args: [],
    );
  }

  /// `New Agent`
  String get newAgent {
    return Intl.message(
      'New Agent',
      name: 'newAgent',
      desc: '',
      args: [],
    );
  }

  /// `New Hour`
  String get newHour {
    return Intl.message(
      'New Hour',
      name: 'newHour',
      desc: '',
      args: [],
    );
  }

  /// `New Terminal`
  String get newTerminal {
    return Intl.message(
      'New Terminal',
      name: 'newTerminal',
      desc: '',
      args: [],
    );
  }

  /// `New Catalog`
  String get newCatalog {
    return Intl.message(
      'New Catalog',
      name: 'newCatalog',
      desc: '',
      args: [],
    );
  }

  /// `New Category`
  String get newCategory {
    return Intl.message(
      'New Category',
      name: 'newCategory',
      desc: '',
      args: [],
    );
  }

  /// `New Product`
  String get newProduct {
    return Intl.message(
      'New Product',
      name: 'newProduct',
      desc: '',
      args: [],
    );
  }

  /// `Catalog`
  String get catalog {
    return Intl.message(
      'Catalog',
      name: 'catalog',
      desc: '',
      args: [],
    );
  }

  /// `Catalogs`
  String get catalogs {
    return Intl.message(
      'Catalogs',
      name: 'catalogs',
      desc: '',
      args: [],
    );
  }

  /// `Business`
  String get business {
    return Intl.message(
      'Business',
      name: 'business',
      desc: '',
      args: [],
    );
  }

  /// `Business Name`
  String get businessName {
    return Intl.message(
      'Business Name',
      name: 'businessName',
      desc: '',
      args: [],
    );
  }

  /// `Search Agent`
  String get searchAgent {
    return Intl.message(
      'Search Agent',
      name: 'searchAgent',
      desc: '',
      args: [],
    );
  }

  /// `Logo`
  String get logo {
    return Intl.message(
      'Logo',
      name: 'logo',
      desc: '',
      args: [],
    );
  }

  /// `Photo`
  String get photo {
    return Intl.message(
      'Photo',
      name: 'photo',
      desc: '',
      args: [],
    );
  }

  /// `Missing Business Profile`
  String get missingBusinessProfile {
    return Intl.message(
      'Missing Business Profile',
      name: 'missingBusinessProfile',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password Not Match`
  String get passwordNotMatch {
    return Intl.message(
      'Password Not Match',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Activated`
  String get activated {
    return Intl.message(
      'Activated',
      name: 'activated',
      desc: '',
      args: [],
    );
  }

  /// `Deactivated`
  String get deactivated {
    return Intl.message(
      'Deactivated',
      name: 'deactivated',
      desc: '',
      args: [],
    );
  }

  /// `Oop!  Look like we do not have any data to show you.`
  String get oop {
    return Intl.message(
      'Oop!  Look like we do not have any data to show you.',
      name: 'oop',
      desc: '',
      args: [],
    );
  }

  /// `Setup`
  String get setup {
    return Intl.message(
      'Setup',
      name: 'setup',
      desc: '',
      args: [],
    );
  }

  /// `Terminal Form`
  String get terminalForm {
    return Intl.message(
      'Terminal Form',
      name: 'terminalForm',
      desc: '',
      args: [],
    );
  }

  /// `Agent Form`
  String get agentForm {
    return Intl.message(
      'Agent Form',
      name: 'agentForm',
      desc: '',
      args: [],
    );
  }

  /// `Agent List`
  String get agentList {
    return Intl.message(
      'Agent List',
      name: 'agentList',
      desc: '',
      args: [],
    );
  }

  /// `Select a Terminal`
  String get selectTerminal {
    return Intl.message(
      'Select a Terminal',
      name: 'selectTerminal',
      desc: '',
      args: [],
    );
  }

  /// `Company List`
  String get companyList {
    return Intl.message(
      'Company List',
      name: 'companyList',
      desc: '',
      args: [],
    );
  }

  /// `Empty Token`
  String get emptyToken {
    return Intl.message(
      'Empty Token',
      name: 'emptyToken',
      desc: '',
      args: [],
    );
  }

  /// `Should Create New Token`
  String get shouldCreateNewToken {
    return Intl.message(
      'Should Create New Token',
      name: 'shouldCreateNewToken',
      desc: '',
      args: [],
    );
  }

  /// `Timeout`
  String get timeout {
    return Intl.message(
      'Timeout',
      name: 'timeout',
      desc: '',
      args: [],
    );
  }

  /// `Timeout Token`
  String get timeoutToken {
    return Intl.message(
      'Timeout Token',
      name: 'timeoutToken',
      desc: '',
      args: [],
    );
  }

  /// `Complete Token`
  String get completeToken {
    return Intl.message(
      'Complete Token',
      name: 'completeToken',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Company Name`
  String get companyName {
    return Intl.message(
      'Company Name',
      name: 'companyName',
      desc: '',
      args: [],
    );
  }

  /// `Queueing`
  String get queueing {
    return Intl.message(
      'Queueing',
      name: 'queueing',
      desc: '',
      args: [],
    );
  }

  /// `Update To`
  String get updateTo {
    return Intl.message(
      'Update To',
      name: 'updateTo',
      desc: '',
      args: [],
    );
  }

  /// `Take This Action if OK`
  String get takeThisActionIfOK {
    return Intl.message(
      'Take This Action if OK',
      name: 'takeThisActionIfOK',
      desc: '',
      args: [],
    );
  }

  /// `Catalog Form`
  String get catalogForm {
    return Intl.message(
      'Catalog Form',
      name: 'catalogForm',
      desc: '',
      args: [],
    );
  }

  /// `Catalog List`
  String get catalogList {
    return Intl.message(
      'Catalog List',
      name: 'catalogList',
      desc: '',
      args: [],
    );
  }

  /// `Catalog Name`
  String get catalogName {
    return Intl.message(
      'Catalog Name',
      name: 'catalogName',
      desc: '',
      args: [],
    );
  }

  /// `Category Name`
  String get categoryName {
    return Intl.message(
      'Category Name',
      name: 'categoryName',
      desc: '',
      args: [],
    );
  }

  /// `Terminal List`
  String get terminalList {
    return Intl.message(
      'Terminal List',
      name: 'terminalList',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Service`
  String get invalidService {
    return Intl.message(
      'Invalid Service',
      name: 'invalidService',
      desc: '',
      args: [],
    );
  }

  /// `Exist Agent For Department And Terminal`
  String get existAgentForDepartmentAndTerminal {
    return Intl.message(
      'Exist Agent For Department And Terminal',
      name: 'existAgentForDepartmentAndTerminal',
      desc: '',
      args: [],
    );
  }

  /// `Already Registred`
  String get alreadyRegistred {
    return Intl.message(
      'Already Registred',
      name: 'alreadyRegistred',
      desc: '',
      args: [],
    );
  }

  /// `User Exist`
  String get userExist {
    return Intl.message(
      'User Exist',
      name: 'userExist',
      desc: '',
      args: [],
    );
  }

  /// `Disabled`
  String get disabled {
    return Intl.message(
      'Disabled',
      name: 'disabled',
      desc: '',
      args: [],
    );
  }

  /// `Invalid`
  String get invalid {
    return Intl.message(
      'Invalid',
      name: 'invalid',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Username`
  String get invalidUsername {
    return Intl.message(
      'Invalid Username',
      name: 'invalidUsername',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Password`
  String get invalidPassword {
    return Intl.message(
      'Invalid Password',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Success on Recover Password`
  String get successOnRecoverPassword {
    return Intl.message(
      'Success on Recover Password',
      name: 'successOnRecoverPassword',
      desc: '',
      args: [],
    );
  }

  /// `Fail on Recover Password`
  String get failOnRecoverPassword {
    return Intl.message(
      'Fail on Recover Password',
      name: 'failOnRecoverPassword',
      desc: '',
      args: [],
    );
  }

  /// `Success Signup`
  String get successSignup {
    return Intl.message(
      'Success Signup',
      name: 'successSignup',
      desc: '',
      args: [],
    );
  }

  /// `Fail on Signup`
  String get failOnSignup {
    return Intl.message(
      'Fail on Signup',
      name: 'failOnSignup',
      desc: '',
      args: [],
    );
  }

  /// `Open Hour Form`
  String get openHourForm {
    return Intl.message(
      'Open Hour Form',
      name: 'openHourForm',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get startTime {
    return Intl.message(
      'Start Time',
      name: 'startTime',
      desc: '',
      args: [],
    );
  }

  /// `End Time`
  String get endTime {
    return Intl.message(
      'End Time',
      name: 'endTime',
      desc: '',
      args: [],
    );
  }

  /// `Select Day`
  String get selectDay {
    return Intl.message(
      'Select Day',
      name: 'selectDay',
      desc: '',
      args: [],
    );
  }

  /// `Max Count Token Number`
  String get maxCountTokenNumber {
    return Intl.message(
      'Max Count Token Number',
      name: 'maxCountTokenNumber',
      desc: '',
      args: [],
    );
  }

  /// `Max Token List`
  String get maxTokenList {
    return Intl.message(
      'Max Token List',
      name: 'maxTokenList',
      desc: '',
      args: [],
    );
  }

  /// `Max Token Form`
  String get maxTokenForm {
    return Intl.message(
      'Max Token Form',
      name: 'maxTokenForm',
      desc: '',
      args: [],
    );
  }

  /// `Select Time and Day`
  String get selectTimeAndDay {
    return Intl.message(
      'Select Time and Day',
      name: 'selectTimeAndDay',
      desc: '',
      args: [],
    );
  }

  /// `Scanner`
  String get scanner {
    return Intl.message(
      'Scanner',
      name: 'scanner',
      desc: '',
      args: [],
    );
  }

  /// `empty`
  String get empty {
    return Intl.message(
      'empty',
      name: 'empty',
      desc: '',
      args: [],
    );
  }

  /// `Closed Or Reached Max Token`
  String get closedOrReachedMaxToken {
    return Intl.message(
      'Closed Or Reached Max Token',
      name: 'closedOrReachedMaxToken',
      desc: '',
      args: [],
    );
  }

  /// `Reached Max Token`
  String get reachedMaxToken {
    return Intl.message(
      'Reached Max Token',
      name: 'reachedMaxToken',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get closed {
    return Intl.message(
      'Closed',
      name: 'closed',
      desc: '',
      args: [],
    );
  }

  /// `No Action`
  String get noAction {
    return Intl.message(
      'No Action',
      name: 'noAction',
      desc: '',
      args: [],
    );
  }

  /// `Sample`
  String get sample {
    return Intl.message(
      'Sample',
      name: 'sample',
      desc: '',
      args: [],
    );
  }

  /// `Delete Terminal First`
  String get deleteTerminalFirst {
    return Intl.message(
      'Delete Terminal First',
      name: 'deleteTerminalFirst',
      desc: '',
      args: [],
    );
  }

  /// `Owner`
  String get owner {
    return Intl.message(
      'Owner',
      name: 'owner',
      desc: '',
      args: [],
    );
  }

  /// `Banner Name`
  String get bannerName {
    return Intl.message(
      'Banner Name',
      name: 'bannerName',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email`
  String get invalidEmail {
    return Intl.message(
      'Invalid Email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Deactivated Account`
  String get deactivatedAccount {
    return Intl.message(
      'Deactivated Account',
      name: 'deactivatedAccount',
      desc: '',
      args: [],
    );
  }

  /// `No Account`
  String get noAccount {
    return Intl.message(
      'No Account',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Account Exist`
  String get accountExist {
    return Intl.message(
      'Account Exist',
      name: 'accountExist',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Terminal`
  String get invalidTerminal {
    return Intl.message(
      'Invalid Terminal',
      name: 'invalidTerminal',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Department`
  String get invalidDepartment {
    return Intl.message(
      'Invalid Department',
      name: 'invalidDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Token Was Updated By Others`
  String get tokenWasUpdatedByOthers {
    return Intl.message(
      'Token Was Updated By Others',
      name: 'tokenWasUpdatedByOthers',
      desc: '',
      args: [],
    );
  }

  /// `Select one of the items below`
  String get selectOneOfTheItemsBelow {
    return Intl.message(
      'Select one of the items below',
      name: 'selectOneOfTheItemsBelow',
      desc: '',
      args: [],
    );
  }

  /// `Not Admin Role`
  String get notAdminRole {
    return Intl.message(
      'Not Admin Role',
      name: 'notAdminRole',
      desc: '',
      args: [],
    );
  }

  /// `Business Level`
  String get businessLevel {
    return Intl.message(
      'Business Level',
      name: 'businessLevel',
      desc: '',
      args: [],
    );
  }

  /// `Need Upgrade Your Subscription`
  String get needUpgradeYourSubscription {
    return Intl.message(
      'Need Upgrade Your Subscription',
      name: 'needUpgradeYourSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Statistic`
  String get statistic {
    return Intl.message(
      'Statistic',
      name: 'statistic',
      desc: '',
      args: [],
    );
  }

  /// `Delete Agent First`
  String get deleteAgentFirst {
    return Intl.message(
      'Delete Agent First',
      name: 'deleteAgentFirst',
      desc: '',
      args: [],
    );
  }

  /// `Modified Date`
  String get modifiedDate {
    return Intl.message(
      'Modified Date',
      name: 'modifiedDate',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message(
      'Rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `No Support For Desktop`
  String get noSupportForDesktop {
    return Intl.message(
      'No Support For Desktop',
      name: 'noSupportForDesktop',
      desc: '',
      args: [],
    );
  }

  /// `Insight Last 14 days`
  String get insightLast14days {
    return Intl.message(
      'Insight Last 14 days',
      name: 'insightLast14days',
      desc: '',
      args: [],
    );
  }

  /// `Insight Last 30 days`
  String get insightLast30days {
    return Intl.message(
      'Insight Last 30 days',
      name: 'insightLast30days',
      desc: '',
      args: [],
    );
  }

  /// `Search Number`
  String get searchNumber {
    return Intl.message(
      'Search Number',
      name: 'searchNumber',
      desc: '',
      args: [],
    );
  }

  /// `Max Tokens`
  String get maxTokens {
    return Intl.message(
      'Max Tokens',
      name: 'maxTokens',
      desc: '',
      args: [],
    );
  }

  /// `Create Service After Saved Department`
  String get createServiceAfterSavedDepartment {
    return Intl.message(
      'Create Service After Saved Department',
      name: 'createServiceAfterSavedDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Please Create New Business Profile`
  String get pleaseCreateNewBusinessProfile {
    return Intl.message(
      'Please Create New Business Profile',
      name: 'pleaseCreateNewBusinessProfile',
      desc: '',
      args: [],
    );
  }

  /// `Remove Business Profile`
  String get removeBusinessProfile {
    return Intl.message(
      'Remove Business Profile',
      name: 'removeBusinessProfile',
      desc: '',
      args: [],
    );
  }

  /// `Do you want remove this Business Profile?`
  String get wantRemoveBusinessProfile {
    return Intl.message(
      'Do you want remove this Business Profile?',
      name: 'wantRemoveBusinessProfile',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'messages'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
