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
import 'dart:typed_data';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:admin/logger.dart';
import 'package:common/bloc/biz_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/validation_function.dart';
import 'package:common/widgets/error_box_widget.dart';
import 'package:common/widgets/msg_box_widget.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BizPage extends StatefulWidget {
  final SharedPreferences prefs;
  const BizPage({super.key, required this.prefs});

  @override
  State<BizPage> createState() => _BizPageState();
}

class _BizPageState extends State<BizPage> {
  static const String tag = 'BizPage';
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  final ValueNotifier<Uint8List> _logoBytes = ValueNotifier(Uint8List(0));
  final ValueNotifier<Uint8List> _photoBytes = ValueNotifier(Uint8List(0));
  final ValueNotifier<List<String>> _errors = ValueNotifier([]);
  final ValueNotifier<List<String>> _messages = ValueNotifier([]);
  final ValueNotifier<ProfileBizModel> _profileBiz = ValueNotifier(ProfileBizModel());

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
    _errors.value = [];
    _messages.value = [];
    context.read<BizBloc>().add(BizLoadOneEvent());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    _logoBytes.dispose();
    _photoBytes.dispose();
    _errors.dispose();
    _messages.dispose();
    _profileBiz.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: _buildNewBusinessForm()
      ),
    );
  }

  Widget _buildNewBusinessForm(){
    TextStyle? styleLarge = Theme.of(context).textTheme.headlineMedium;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width>ScreenProp.widthPhoneScreenLimit){
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return BlocBuilder<BizBloc, BizState>(
      builder: (context, state) {
        Logger.log(tag, message: 'BizState: $state');
        ProfileBizModel? biz;
        if (state is BizLoadingState){
          return const Center(child: CircularProgressIndicator());
        } else if (state is BizOneLoadedState){
          biz = state.biz;
          _nameController.text = biz.bizName??'';
          _descController.text = biz.bizDesc??'';
          _phoneController.text = biz.bizPhoneNumber??'';
          _emailController.text = biz.bizEmail??'';
          _addressController.text = biz.bizAddress??'';
          _websiteController.text = biz.bizWebsite??'';
          _logoBytes.value = base64Decode(biz.bizLogoBase64??'');
          _photoBytes.value = base64Decode(biz.bizPhotoBase64??'');
          _profileBiz.value = biz;
        } else if (state is BizSuccessState){
          _messages.value = [S.of(context).success];
        } else if (state is BizFailureState){
          _errors.value = [S.of(context).fail];
        } else if (state is BizErrorState){
          _errors.value = [state.error.data?.title??''];
        } else if (state is BizMissingBizState){
          _nameController.clear();
          _descController.clear();
          _phoneController.clear();
          _emailController.clear();
          _addressController.clear();
          _websiteController.clear();
          _logoBytes.value = Uint8List(0);
          _photoBytes.value = Uint8List(0);
          _profileBiz.value = ProfileBizModel();
          _messages.value = [S.of(context).pleaseCreateNewBusinessProfile];
          CommonUtils.resetBlocState(context);
        }
        return Form(
          key: _formKey,
          child: Center(
            child: SizedBox(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: DecoratorUtils.actionBar(),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(S.of(context).businessInfo, style: styleLarge)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ValueListenableBuilder(
                              valueListenable: _profileBiz,
                              builder: (context, ProfileBizModel biz, _) {
                                if (biz.id==null) return const SizedBox();
                                return CupertinoSwitch(
                                  value: biz.enable??false, 
                                  onChanged: (value) async{
                                    context.read<BizBloc>().add(BizEnableEvent(biz: biz, enable: value));
                                  }
                                );
                              }
                            ),
                            const SizedBox(width: 8),
                            IconButton.filled(
                              icon: const Icon(CupertinoIcons.floppy_disk),
                              onPressed: () async{
                                _messages.value = [];
                                _errors.value = [];
                                await _saveOrUpdate(biz);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ErrorBoxWidget(errors: _errors, width: width),
                  MsgBoxWidget(messages: _messages, width: width),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: _buildUploadLogo(),
                      ),
                      Expanded(
                        flex: 9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _nameController,
                              textAlignVertical: TextAlignVertical.center,
                              textCapitalization: TextCapitalization.words,
                              maxLength: 50,
                              decoration: DecoratorUtils.inputDecoration(
                                S.of(context).businessName, 
                                prefixIcon: CupertinoIcons.creditcard, 
                                suffixIcon: CupertinoIcons.xmark,
                                clear: ()=>_nameController.clear()
                              ),
                              validator: (value) => ValidateUtils.validateStringMinMax(value, 3, 100, S.of(context).businessName),
                            ),
                            Constants.divider,
                            TextFormField(
                              controller: _descController,
                              minLines: 5,
                              maxLines: 5,
                              maxLength: 200,
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.multiline,
                              decoration: DecoratorUtils.inputDecoration(
                                S.of(context).description, 
                                prefixIcon: CupertinoIcons.text_bubble, 
                                suffixIcon: CupertinoIcons.xmark,
                                clear: ()=>_descController.clear()
                              ),
                            ),
                            Constants.divider,
                          ],
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _phoneController,
                    textAlignVertical: TextAlignVertical.center,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.phone,
                    maxLength: 20,
                    validator: (value) => (value?.isNotEmpty==true)? 
                      ValidateUtils.validatePhone(value): null,
                    decoration: DecoratorUtils.inputDecoration(
                      S.of(context).phone, 
                      prefixIcon: CupertinoIcons.phone, 
                      suffixIcon: CupertinoIcons.xmark,
                      clear: ()=>_phoneController.clear()
                    ),
                  ),
                  Constants.divider,
                  TextFormField(
                    controller: _emailController,
                    textAlignVertical: TextAlignVertical.center,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 100,
                    validator: (value) => (value?.isNotEmpty==true)? 
                      ValidateUtils.validateEmail(value): null,
                    decoration: DecoratorUtils.inputDecoration(
                      S.of(context).email, 
                      prefixIcon: CupertinoIcons.envelope, 
                      suffixIcon: CupertinoIcons.xmark,
                      clear: ()=>_emailController.clear()
                    ),
                  ),
                  Constants.divider,
                  TextFormField(
                    controller: _addressController,
                    minLines: 5,
                    maxLines: 5,
                    maxLength: 200,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.streetAddress,
                    decoration: DecoratorUtils.inputDecoration(
                      S.of(context).address, 
                      prefixIcon: CupertinoIcons.building_2_fill, 
                      suffixIcon: CupertinoIcons.xmark,
                      clear: ()=>_addressController.clear()
                    ),
                  ),
                  Constants.divider,
                  TextFormField(
                    controller: _websiteController,
                    textAlignVertical: TextAlignVertical.center,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.url,
                    maxLength: 200,
                    validator: (value) => (value?.isNotEmpty==true)? 
                      ValidateUtils.validateUrl(value, S.of(context).webSite): null,
                    decoration: DecoratorUtils.inputDecoration(
                      S.of(context).webSite, 
                      prefixIcon: CupertinoIcons.globe, 
                      suffixIcon: CupertinoIcons.xmark,
                      clear: ()=>_websiteController.clear()
                    ),
                  ),
                  Constants.divider,
                  _buildUploadPhoto(width),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    child: Text(S.of(context).removeBusinessProfile),
                    onPressed: () async{
                      await _removeBizAction(biz);
                    },
                  ),
                ]
              )
            )
          ),
        );
      }
    );
  }

  Widget _buildUploadPhoto(double width){
    TextStyle? style = Theme.of(context).textTheme.bodySmall;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async{
          XTypeGroup? typeGroup;
          if (Utils.isIos){
            typeGroup = const XTypeGroup(
              label: 'images',
              uniformTypeIdentifiers: <String>['jpg', 'jpeg', 'png'],
            );
          } else {
            typeGroup = const XTypeGroup(
              label: 'images',
              extensions: <String>['jpg', 'jpeg', 'png'],
            );
          }
          final XFile? file = await openFile(
            acceptedTypeGroups: <XTypeGroup>[typeGroup],
          );
          _photoBytes.value = await file?.readAsBytes()??Uint8List(0);
        },
        child: ValueListenableBuilder(
          valueListenable: _photoBytes,
          builder: (context, Uint8List bytes, _) {
            return DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(width: 1.0, color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  width: width,
                  height: 200,
                  child: (bytes.isEmpty==true)?
                     Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         const Icon(CupertinoIcons.add),
                         const SizedBox(height: 2),
                         Text(S.of(context).photo.toUpperCase(), style: style),
                       ],
                     ): Stack(
                      children: [
                        Image.memory(bytes),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            icon: const Icon(CupertinoIcons.xmark_circle_fill, size: 12, color: Colors.blue),
                            onPressed: (){
                              _photoBytes.value = Uint8List(0);
                            },
                          ),
                        ),
                      ],
                    ),
                ),
              ),
            );
          }
        ),
      ),
    );
  } 

  Widget _buildUploadLogo(){
    TextStyle? style = Theme.of(context).textTheme.bodySmall?.apply(fontSizeDelta: -8);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        fit: BoxFit.contain,
        child: GestureDetector(
          onTap: () async{
            XTypeGroup? typeGroup;
            if (Utils.isIos){
              typeGroup = const XTypeGroup(
                label: 'images',
                uniformTypeIdentifiers: <String>['jpg', 'jpeg', 'png'],
              );
            } else {
              typeGroup = const XTypeGroup(
                label: 'images',
                extensions: <String>['jpg', 'jpeg', 'png'],
              );
            }
            final XFile? file = await openFile(
              acceptedTypeGroups: <XTypeGroup>[typeGroup],
            );
            _logoBytes.value = await file?.readAsBytes()??Uint8List(0);
          },
          child: ValueListenableBuilder(
            valueListenable: _logoBytes,
            builder: (context, Uint8List bytes, _) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(width: 1.0, color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: (bytes.isEmpty==true)?
                       Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                            const Icon(CupertinoIcons.add, size: 8),
                            const SizedBox(height: 2),
                            Text(S.of(context).logo.toUpperCase(), style: style)
                         ],
                       ):
                       Stack(
                         children: [
                            Image.memory(bytes),
                            Positioned(
                              left: 8,
                              bottom: 8,
                              child: IconButton(
                                icon: const Icon(CupertinoIcons.xmark_circle_fill, size: 4, color: Colors.blue),
                                onPressed: (){
                                  _logoBytes.value = Uint8List(0);
                                },
                              ),
                            ),
                         ],
                       ),
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  Future<void> _removeBizAction(ProfileBizModel? biz) async {
    if (biz==null){
      Utils.overlayInfoMessage(msg: S.of(context).noAction);
      return;
    }
    final result = await showOkCancelAlertDialog(
      context: context,
      title: S.of(context).removeBusinessProfile,
      message: S.of(context).wantRemoveBusinessProfile,
    );
    if (result == OkCancelResult.ok) {
      context.read<BizBloc>().add(BizRemoveEvent(biz: biz));
    } else {
      Utils.overlayInfoMessage(msg: S.of(context).noAction);
    }
  }

  Future<void> _saveOrUpdate(ProfileBizModel? biz) async{
    if (_formKey.currentState!.validate()){
      String name = _nameController.text.trim();
      String desc = _descController.text.trim();
      String phone = _phoneController.text.trim();
      String email = _emailController.text.trim();
      String address = _addressController.text.trim();
      String website = _websiteController.text.trim();

      context.read<BizBloc>().add(
        BizSaveOrUpdateEvent(
          id: biz?.id,
          name: name, 
          desc: desc, 
          phone: phone, 
          email: email, 
          address: address, 
          website: website,  
          bizLogoBase64: base64Encode(_logoBytes.value),
          bizPhotoBase64: base64Encode(_photoBytes.value),
        )
      );
    }
  }
}