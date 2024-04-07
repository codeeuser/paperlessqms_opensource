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

import 'package:common/app_absorb.dart';
import 'package:common/bloc/account_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/logger.dart';
import 'package:common/models/change_password_model.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/validation_function.dart';
import 'package:common/widgets/error_box_widget.dart';
import 'package:common/widgets/msg_box_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordChangeScreen extends StatefulWidget {
  final SharedPreferences prefs;
  const PasswordChangeScreen({super.key, required this.prefs});

  @override
  State<PasswordChangeScreen> createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  static const String tag = 'PasswordChangeScreen';
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _currentController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  final ValueNotifier<bool> _obscureCurrentPassword = ValueNotifier(true);
  final ValueNotifier<bool> _obscureNewPassword = ValueNotifier(true);
  final ValueNotifier<bool> _obscureConfirm = ValueNotifier(true);
  final ValueNotifier<List<String>> _errors = ValueNotifier([]);
  final ValueNotifier<List<String>> _messages = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
  }

  @override
  void dispose() {
    _currentController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _obscureCurrentPassword.dispose();
    _obscureNewPassword.dispose();
    _obscureConfirm.dispose();
    _errors.dispose();
    _messages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width > ScreenProp.widthPhoneScreenLimit) {
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(S.of(context).changePassword),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.floppy_disk),
            onPressed: () async {
              _messages.value = [];
              _errors.value = [];
              await _changePassword();
            },
          )
        ],
      ),
      body: Consumer<AppAbsorb>(builder: (context, absorb, _) {
        return AbsorbPointer(
          absorbing: absorb.absorbing,
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is AccountSuccessState){
                _messages.value = [S.of(context).success];
              } else if (state is AccountErrorState){
                _errors.value = [state.error.data?.title?? S.of(context).fail];
              }
              return Center(
                child: Container(
                  alignment: Alignment.topCenter,
                  width: width,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 8),
                              const Text('Fill in the fields below.'),
                              const SizedBox(height: 8),
                              ErrorBoxWidget(errors: _errors, width: width),
                              MsgBoxWidget(messages: _messages, width: width),
                              Constants.divider,
                              ValueListenableBuilder(
                                  valueListenable: _obscureCurrentPassword,
                                  builder: (context,
                                      bool obscureCurrentPassword, _) {
                                    return TextFormField(
                                      controller: _currentController,
                                      obscureText: obscureCurrentPassword,
                                      validator: (value) =>
                                          ValidateUtils.validateStringMinMax(
                                              value,
                                              4,
                                              20,
                                              S.of(context).currentPassword),
                                      decoration:
                                          DecoratorUtils.inputDecoration(
                                        S.of(context).currentPassword,
                                        prefixIcon:
                                            CupertinoIcons.asterisk_circle,
                                        suffixIcon: (obscureCurrentPassword)
                                            ? CupertinoIcons.eye
                                            : CupertinoIcons.eye_slash,
                                        clear: () => _obscureCurrentPassword
                                            .value = !obscureCurrentPassword,
                                      ),
                                    );
                                  }),
                              Constants.divider,
                              ValueListenableBuilder(
                                  valueListenable: _obscureNewPassword,
                                  builder:
                                      (context, bool obscureNewPassword, _) {
                                    return TextFormField(
                                      controller: _passwordController,
                                      obscureText: obscureNewPassword,
                                      validator: (value) =>
                                          ValidateUtils.validateStringMinMax(
                                              value,
                                              6,
                                              20,
                                              S.of(context).newPassword),
                                      decoration:
                                          DecoratorUtils.inputDecoration(
                                        S.of(context).newPassword,
                                        prefixIcon: CupertinoIcons.lock,
                                        suffixIcon: (obscureNewPassword)
                                            ? CupertinoIcons.eye
                                            : CupertinoIcons.eye_slash,
                                        clear: () => _obscureNewPassword.value =
                                            !obscureNewPassword,
                                      ),
                                    );
                                  }),
                              Constants.divider,
                              ValueListenableBuilder(
                                  valueListenable: _obscureConfirm,
                                  builder: (context, bool obscureConfirm, _) {
                                    return TextFormField(
                                      controller: _confirmController,
                                      obscureText: obscureConfirm,
                                      validator: (value) =>
                                          ValidateUtils.validateStringMinMax(
                                              value,
                                              6,
                                              20,
                                              S.of(context).confirmPassword),
                                      decoration:
                                          DecoratorUtils.inputDecoration(
                                        S.of(context).confirmPassword,
                                        prefixIcon: CupertinoIcons.lock,
                                        suffixIcon: (obscureConfirm)
                                            ? CupertinoIcons.eye
                                            : CupertinoIcons.eye_slash,
                                        clear: () => _obscureConfirm.value =
                                            !obscureConfirm,
                                      ),
                                    );
                                  }),
                              Constants.divider,
                            ]),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Future<void> _changePassword() async {
    String current = _currentController.text.trim();
    String password = _passwordController.text.trim();
    String confirm = _confirmController.text.trim();
    if (password != confirm) {
      Utils.overlayWarnMessage(
          warns: [S.of(context).passwordNotMatch], notifier: _errors);
      return;
    }
    if (_formKey.currentState!.validate()) {
      AppAbsorb absorb = context.read<AppAbsorb>();
      absorb.absorbing = true;
      ChangePasswordModel changePassword =
          ChangePasswordModel(currentPassword: current, newPassword: password);
      context
          .read<AccountBloc>()
          .add(ChangePasswordEvent(changePassword: changePassword));
      // final changeNew = await _accountRepository?.changePassword(changePassword);
      // Logger.log(tag, message: 'changeNew: $changeNew');
      // if (changeNew?.isEmpty==true){
      //   Utils.overlayInfoMessage(msg: S.of(context).success, notifier: _messages);
      // } else {
      //   ServerErrorModel serverError = ServerErrorModel.fromMap(changeNew);
      //   String error = serverError.data?.title?? S.of(context).fail;
      //   Utils.overlayWarnMessage(warns: [error], notifier: _errors);
      // }
      absorb.absorbing = false;
    } else {
      Utils.overlayWarnMessage(warns: [S.of(context).fail], notifier: _errors);
    }
  }
}
