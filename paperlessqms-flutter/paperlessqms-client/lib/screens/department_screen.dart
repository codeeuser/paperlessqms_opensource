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

import 'package:client/screens/way_screen.dart';
import 'package:common/app_absorb.dart';
import 'package:common/bloc/department_bloc.dart';
import 'package:common/bloc/service_bloc.dart';
import 'package:common/bloc/token_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/logger.dart';
import 'package:common/models/agent_model.dart';
import 'package:common/models/queue_department_model.dart';
import 'package:common/models/queue_service_model.dart';
import 'package:common/screens/scanner_screen.dart';
import 'package:common/screens/token_screen.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepartmentScreen extends StatefulWidget {
  final SharedPreferences prefs;
  const DepartmentScreen({super.key, required this.prefs});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  static const String tag = 'DepartmentScreen';

  List<QueueDepartmentModel>? _depList;
  List<QueueServiceModel>? _serviceList;
  QueueDepartmentModel? _selectedDepartment;
  AgentModel? _agent;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(S.of(context).departmentList),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.chevron_left),
          onPressed: () async{
            await Utils.pushAndRemoveUntilPage(context, WayScreen(prefs: widget.prefs), 'HOME');
          },
        ),
      ),
      body: Consumer<AppAbsorb>(
        builder: (context, appAbsorb, child){
          Size size = MediaQuery.of(context).size;
          double width = size.width;
          if (width>ScreenProp.widthPhoneScreenLimit){
            width = ScreenProp.widthPhoneScreenLimit;
          }
          return AbsorbPointer(
            absorbing: appAbsorb.absorbing,
            child: BlocBuilder<DepartmentBloc, DepartmentState>(
              builder: (context, state) {
                Logger.log(tag, message: 'DepartmentState: $state');
                if (state is DepartmentLoadingState){
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DepartmentLoadedState){
                  _depList = state.departments;
                } else if (state is DepartmentQrSuccessState){
                  _selectedDepartment = state.department;
                  _depList = state.departments;
                  _generateServiceList();
                } 
                return SafeArea(
                  child: Center(
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: width,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(S.of(context).selectOneOfTheItemsBelow),
                              const SizedBox(height: 4),
                              for(QueueDepartmentModel dep in _depList??[])...[
                                _buildItem(dep),
                                const SizedBox(height: 4),
                              ]
                            ],
                          )
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          );
        }
      ),
    );
  }
  
  Widget _buildItem(QueueDepartmentModel dep){
    TextStyle? style = Theme.of(context).textTheme.headlineMedium;
    return ListTile(
      shape: const ContinuousRectangleBorder(side: BorderSide(color: Colors.grey)),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      leading: const Icon(CupertinoIcons.bookmark),
      title: Text(dep.name??'', style: style),
      trailing: IconButton(
        icon: const Icon(CupertinoIcons.qrcode_viewfinder),
        onPressed: () async{
          _selectedDepartment = dep;
          Utils.pushPage(
              context, 
              ScannerScreen(
                prefs: widget.prefs, 
                back: DepartmentScreen(prefs: widget.prefs), 
                actionCallback: _actionCallback,
                live: Utils.isMobileNotBrowser,
              ), 'ScannerScreen');        
        },
      ),
      subtitle: BlocBuilder<ServiceBloc, ServiceState>(
        builder: (context, state) {
          Logger.log(tag, message: 'ServiceState: $state');
          if (state is ServiceLoadingState){
            return const SizedBox();
          } else if (state is ServiceLoadedState){
            _serviceList = state.services;
          }
          Logger.log(tag, message: 'serviceListLEN: ${_serviceList?.length}');
          if (_selectedDepartment?.id!=dep.id){
            return const SizedBox();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Constants.divider,
                Text(S.of(context).selectOneOfTheItemsBelow),
                const SizedBox(height: 4),
                for(QueueServiceModel service in _serviceList??[])...[
                  ActionChip(
                    label: Text(service.name??''),
                    disabledColor: Colors.grey,
                    onPressed: () async{
                      final dep = _selectedDepartment;
                      if (dep!=null){
                        context.read<TokenBloc>().add(
                          TokenNewEvent(
                            department: dep, 
                            service: service,
                            agent: _agent,
                          ));
                        await Utils.pushAndRemoveUntilPage(context, TokenScreen(prefs: widget.prefs, homeScreen: WayScreen(prefs: widget.prefs)), 'TokenScreen');
                      }
                    }, 
                  ),
                  const SizedBox(height: 4),
                ],
              ],
            ),
          );
        }
      ),
    );
  }
  

  Future<void> _generateServiceList() async{
    Logger.log(tag, message: '_generateServiceList _selectedDepartment: $_selectedDepartment');
    AppAbsorb appAbsorb = context.read<AppAbsorb>();
    QueueDepartmentModel? dep = _selectedDepartment;
    if (dep!=null){
      appAbsorb.absorbing==true;
      context.read<ServiceBloc>().add(ServiceLoadByDepartmentEvent(department: dep, enable: true));
    } 
    appAbsorb.absorbing==false;
  }

  Future<void> _actionCallback(String text, QRCodeDartScanController? controller) async{
    Logger.log(tag, message: 'text: $text');
    if (text.length<Constants.qrPrefixDepartment.length){  
      Utils.overlayInfoMessage(msg: S.of(context).invalid);     
      return;
    }
    String str = Utils.retriveQrCodeId(text, Constants.qrPrefixDepartment);
    Logger.log(tag, message: 'str: $str');
    String sDepId = str.substring(0, str.indexOf('-'));
    String sBanner = str.substring(str.indexOf('-')+1, str.length);
    String banner = _selectedDepartment?.bannerName??'';
    int? depId = int.tryParse(sDepId);
    Logger.log(tag, message: 'depId: $depId, ${_selectedDepartment?.id}, sBanner: $sBanner, banner: $banner');
    if (depId!=null && _selectedDepartment?.id==depId && sBanner==banner) {
      await _generateServiceList();
      // await controller?.dispose();
      Navigator.of(context).pop();
    } else {
      await controller?.setFocusPoint(Offset.zero);
      Utils.overlayInfoMessage(key: uuid.v4(), msg: S.of(context).invalid); 
    }
  }
}