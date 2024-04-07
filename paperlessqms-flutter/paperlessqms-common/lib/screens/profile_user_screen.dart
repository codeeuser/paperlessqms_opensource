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
import 'package:common/generated/l10n.dart';
import 'package:common/logger.dart';
import 'package:common/models/account_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/repositories/account_repository.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/validation_function.dart';
import 'package:common/widgets/error_box_widget.dart';
import 'package:common/widgets/msg_box_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUserScreen extends StatefulWidget {
  final SharedPreferences prefs;
  const ProfileUserScreen({super.key, required this.prefs});

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  static const String tag = 'ProfileUserScreen';
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final ValueNotifier<List<String>> _errors = ValueNotifier([]);
  final ValueNotifier<List<String>> _messages = ValueNotifier([]);

  AccountModel? _account;

  AccountRepository? _accountRepository;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
    _accountRepository = AccountRepository(context: context, prefs: widget.prefs);
    await _accountRepository?.checkAccount();
    _account = PrefsUtils.getAccount(widget.prefs);
    _firstNameController.text = _account?.firstName??'';
    _lastNameController.text = _account?.lastName??'';
    _emailController.text = _account?.email??'';
    setState(() {
      
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _errors.dispose();
    _messages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? styleHeadline = Theme.of(context).textTheme.headlineMedium;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width>ScreenProp.widthPhoneScreenLimit){
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(S.of(context).userProfile),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.floppy_disk),
            onPressed: () async{
              _messages.value = [];
              _errors.value = [];
              await _updateProfile();
            },
          )
        ],
      ),
      body: Consumer<AppAbsorb>(
        builder: (context, absorb, _) {
          return AbsorbPointer(
            absorbing: absorb.absorbing,
            child: Center(
              child: Container(
                alignment: Alignment.topCenter,
                width: width,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 16),
                          ErrorBoxWidget(errors: _errors, width: width),
                          MsgBoxWidget(messages: _messages, width: width),
                          ListTile(
                            leading: const Icon(CupertinoIcons.person_circle),
                            title: Text(_account?.login??'', style: styleHeadline),
                            subtitle: Text(S.of(context).username),
                          ),
                          Constants.divider,
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) => ValidateUtils.validateEmail(value),
                            decoration: DecoratorUtils.inputDecoration(
                              S.of(context).email,
                              prefixIcon: CupertinoIcons.envelope, 
                              suffixIcon: CupertinoIcons.xmark,
                              clear: ()=>_emailController.clear()
                            ),
                          ),
                          Constants.divider,
                          TextFormField(
                            controller: _firstNameController,
                            textCapitalization: TextCapitalization.words,
                            validator: (value) => ValidateUtils.validateNotEmpty(value),
                            decoration: DecoratorUtils.inputDecoration(
                              S.of(context).firstName,
                              prefixIcon: CupertinoIcons.person, 
                              suffixIcon: CupertinoIcons.xmark,
                              clear: ()=>_firstNameController.clear()
                            ),
                          ),
                          Constants.divider,
                          TextFormField(
                            controller: _lastNameController,
                            textCapitalization: TextCapitalization.words,
                            validator: (value) => ValidateUtils.validateNotEmpty(value),
                            decoration: DecoratorUtils.inputDecoration(
                              S.of(context).lastName,
                              prefixIcon: CupertinoIcons.person, 
                              suffixIcon: CupertinoIcons.xmark,
                              clear: ()=>_lastNameController.clear()
                            ),
                          ),
                          Constants.divider,
                        ]
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
  
  Future<void> _updateProfile() async{
    AccountModel? account = _account;
    if (account!=null && account.id!=null && _formKey.currentState!.validate()){
      AppAbsorb absorb = context.read<AppAbsorb>();
      absorb.absorbing = true;
      account.email = _emailController.text.trim();
      account.firstName = _firstNameController.text.trim();
      account.lastName = _lastNameController.text.trim();
      final accountNew = await _accountRepository?.updateAccount(account);
      if (accountNew?.isEmpty==true){
        Utils.overlayInfoMessage(msg: S.of(context).success, notifier: _messages);
      } else {
        ServerErrorModel serverError = ServerErrorModel.fromMap(accountNew);
        String error = serverError.data?.title?? S.of(context).fail;
        Utils.overlayWarnMessage(warns: [error], notifier: _errors);
      }
      absorb.absorbing = false;
    } else {
      Utils.overlayWarnMessage(warns: [S.of(context).fail], notifier: _errors);
    }
  }
}