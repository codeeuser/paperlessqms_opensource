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

import 'package:admin/screens/biz_page.dart';
import 'package:admin/screens/maxtoken_page.dart';
import 'package:admin/screens/openhour_page.dart';
import 'package:common/app_absorb.dart';
import 'package:common/logger.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum BizSetup { info, hour, maximum }
class SetupBizPage extends StatefulWidget {
  final SharedPreferences prefs;
  final int? id;
  const SetupBizPage({super.key, required this.prefs, this.id});

  @override
  State<SetupBizPage> createState() => _SetupBizPageState();
}

class _SetupBizPageState extends State<SetupBizPage> {
  static const String tag = 'SetupBizPage';

  final ValueNotifier<BizSetup> _selectedSegment = ValueNotifier(BizSetup.info);

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
  }

  @override
  void dispose() {
    _selectedSegment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? myStyle = Theme.of(context).textTheme.bodySmall?.apply(color: Colors.black);
    TextStyle? styleSmall = Theme.of(context).textTheme.labelSmall;
    return Consumer<AppAbsorb>(
      builder: (context, appAbsorb, child){
        return AbsorbPointer(
          absorbing: appAbsorb.absorbing,
          child: ValueListenableBuilder(
            valueListenable: _selectedSegment,
            builder: (context, BizSetup selected, _) {
              return Column(
                children: [
                  const SizedBox(height: 4),
                  CupertinoSegmentedControl<BizSetup>(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    groupValue: selected,
                    onValueChanged: (BizSetup value) {
                      _selectedSegment.value = value;
                    },
                    children: <BizSetup, Widget>{
                      BizSetup.info: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(BizSetup.info.name.toCapitalized(), style: myStyle),
                      ),
                      BizSetup.hour: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(BizSetup.hour.name.toCapitalized(), style: myStyle),
                      ),
                      BizSetup.maximum: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(BizSetup.maximum.name.toCapitalized(), style: myStyle),
                      ),
                    },
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(child: _buildSelectedWidget(selected)),
                        const SizedBox(height: 4),
                        Text(PrefsUtils.getAccount(widget.prefs)?.email??'', style: styleSmall),
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
        );
      }
    );
  }

  Widget _buildSelectedWidget(BizSetup selected){
    Logger.log(tag, message: '_selectedSegment: $_selectedSegment');
    if (selected==BizSetup.info){
      return BizPage(prefs: widget.prefs);
    } else if (selected==BizSetup.hour){
      return OpenhourPage(prefs: widget.prefs);
    } else if (selected==BizSetup.maximum){
      return MaxtokenPage(prefs: widget.prefs);
    } else {
      return const SizedBox();
    }
  }
}
