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
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:common/generated/l10n.dart';
import 'package:common/locator.dart';
import 'package:common/logger.dart';
import 'package:common/models/register_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/repositories/account_repository.dart';
import 'package:common/screens/recaptcha_screen.dart';
import 'package:common/services/rest_connect_service.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/validation_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef ActionCallback = void Function();
class LoginScreen extends StatelessWidget {

  final SharedPreferences prefs;
  final String appTitle;
  final String? dummyUsername;
  final String? dummyPassword;
  final ActionCallback callback;
  final Widget w;
  const LoginScreen({
    super.key, 
    required this.prefs, 
    required this.appTitle,
    this.dummyUsername,
    this.dummyPassword,
    required this.callback,
    required this.w,
  });

  static const String tag = 'LoginScreen';
  static RestConnectService restConnectService = locator<RestConnectService>();


  @override
  Widget build(BuildContext context) {
    AccountRepository accountRepository = AccountRepository(context: context, prefs: prefs);
    return FlutterLogin(
      title: appTitle,
      logo: const AssetImage('assets/images/1024.png'),
      userType: LoginUserType.email,
      savedEmail: prefs.getString(Prefs.emailLogin)??'',
      messages: LoginMessages(
        recoverPasswordDescription: 'We will send you an email for recover account.',
        recoverPasswordIntro: 'Enter your email address.',
      ),
      userValidator: (value) {
        if (dummyUsername==null || dummyPassword==null){
          return ValidateUtils.validateEmail(value);
        } else {
          return null;
        }
      },
      passwordValidator: (value) {
        if (dummyUsername==null || dummyPassword==null){
          return ValidateUtils.validateStringMinMax(value, 5, 100, 'Password');
        }
        return null;
      },
      onLogin: (loginData) async{
        FocusManager.instance.primaryFocus?.unfocus();
        String? msg = await _authUser(context, loginData, accountRepository);
        if (msg==null) {
          await accountRepository.checkAccount();
        }
        return msg;
      },
      onSignup: (loginData) async{
        FocusManager.instance.primaryFocus?.unfocus();
        RegisterModel register = RegisterModel(
          login: loginData.additionalSignupData?['name'],
          password: loginData.password,
          email: loginData.name,
          langKey: 'en',
        );
        String body = jsonEncode(register);
        final result = await accountRepository.register(body);
        Logger.log(tag, message: 'register result: $result');
        if (result.isEmpty){
          return null;
        } else {
          final serverError = ServerErrorModel.fromMap(result);
          return serverError.data?.title?? S.of(context).failOnSignup;
        }
      },
      onSubmitAnimationCompleted: () {
        FocusManager.instance.primaryFocus?.unfocus();
        callback();
        Utils.pushPage(context, RecaptchaScreen(w: w), 'RecaptchaScreen');
      },
      onRecoverPassword: (value) async{
        FocusManager.instance.primaryFocus?.unfocus();
        dynamic result = await accountRepository.resetPassword(value);
        Logger.log(tag, message: 'result resetPassword: $result');
        if (result.isEmpty){
          return null;
        }
        return S.of(context).failOnRecoverPassword;
      },
      loginAfterSignUp: false,
      termsOfService: [
        TermOfService(
          id: 'general-term',
          mandatory: true,
          text: 'Term of services',
          linkUrl: 'https://wheref.com/terms.html',
        ),
      ],
      additionalSignupFields: [
        UserFormField(
          keyName: 'name', 
          displayName: 'Username',
          userType: LoginUserType.name,
          icon: const Icon(CupertinoIcons.person),
          fieldValidator: (value) {
            return ValidateUtils.validateStringMinMax(value, 5, 59, 'Username');
          },  
        )
      ],
    );
  }

  Future<String?> _authUser(BuildContext context, LoginData data, AccountRepository accountRepository) {
    Logger.log(tag, message: 'Name: ${data.name}');
    return Future.delayed(Constants.loginTime).then((_) async{
      String body;
      if (dummyUsername!=null && dummyPassword!=null){
        body = '{"username":"$dummyUsername", "password":"$dummyPassword", "rememberMe":true}';
      } else {
        body = '{"username":"${data.name}","password":"${data.password}","rememberMe":true}';
        await PrefsUtils.saveEmailLogin(prefs, data.name);
      }
      String? tokenId = await accountRepository.auth(body);
      Logger.log(tag, message: 'tokenId: $tokenId');
      if (tokenId!=null){
        await prefs.setString(Prefs.tokenId, tokenId);
        return null;
      }
      return 'User not exists or Password does not match';
    });
  }
}