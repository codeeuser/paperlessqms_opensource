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

import 'package:common/bloc/department_bloc.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/models/queue_department_model.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/logger.dart';
import 'package:kiosk/screens/running_token_page.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepartmentPage extends StatefulWidget {
  final SharedPreferences prefs;
  final ProfileBizModel biz;
  const DepartmentPage({super.key, required this.prefs, required this.biz});

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  static const String tag = 'DepartmentPage';

  List<QueueDepartmentModel>? _depList;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
    context
        .read<DepartmentBloc>()
        .add(DepartmentByBizEvent(biz: widget.biz, enable: true));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<DepartmentBloc, DepartmentState>(
        builder: (context, state) {
          Logger.log(tag, message: 'DepartmentState: $state');
          if (state is DepartmentLoadedState){
            _depList = state.departments;
          } else if (state is DepartmentErrorState){
           return NoData(message: state.error.data?.title);
          }
          return Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (QueueDepartmentModel dep in _depList ?? []) ...[
                    _buildItemDep(dep),
                    const SizedBox(width: 40),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItemDep(QueueDepartmentModel dep) {
    TextStyle? style = Theme.of(context).textTheme.headlineMedium;
    TextStyle? styleSmall = Theme.of(context).textTheme.labelSmall;
    double width = 300;
    final data = Utils.aesEncrypt(
                  '${Constants.qrPrefixDepartment}${dep.id}-${dep.bannerName ?? ''}',
                  Constants.password);
    return SizedBox(
      width: width + 50,
      height: 420,
      child: Column(
        children: [
          Text(widget.biz.bizName ?? '', style: style),
          Text(dep.name ?? '', style: style),
          InkWell(
            child: QrImageView(
              data: data,
              gapless: false,
              size: width,
              backgroundColor: Colors.white,
              version: QrVersions.auto,
            ),
            onTap: () {
              Utils.pushPage(
                  context,
                  RunningTokenPage(
                      prefs: widget.prefs, department: dep, biz: widget.biz),
                  'RunningTokenPage');
            },
          ),
          const SizedBox(height: 16),
          Text(data, style:  styleSmall),
        ],
      ),
    );
  }
}
