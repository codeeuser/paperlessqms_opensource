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

import 'package:admin/screens/agent_page.dart';
import 'package:admin/screens/department_page.dart';
import 'package:admin/screens/terminal_page.dart';
import 'package:common/app_absorb.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/logger.dart';
import 'package:common/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum QueueSetup { department, agent, terminal }
class SetupQueuePage extends StatefulWidget {
  final SharedPreferences prefs;
  final int? id;
  const SetupQueuePage({super.key, required this.prefs, this.id});

  @override
  State<SetupQueuePage> createState() => _SetupQueuePageState();
}

class _SetupQueuePageState extends State<SetupQueuePage> {
  static const String tag = 'SetupQueuePage';

  final ValueNotifier<QueueSetup> _selectedSegment = ValueNotifier(QueueSetup.department);

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
    return Consumer<AppAbsorb>(
      builder: (context, appAbsorb, child){
        return AbsorbPointer(
          absorbing: appAbsorb.absorbing,
          child: ValueListenableBuilder(
            valueListenable: _selectedSegment,
            builder: (context, QueueSetup selected, _) {
              return Column(
                children: [
                  const SizedBox(height: 4),
                  CupertinoSegmentedControl<QueueSetup>(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    groupValue: selected,
                    onValueChanged: (QueueSetup value) {
                      _selectedSegment.value = value;
                    },
                    children: <QueueSetup, Widget>{
                      QueueSetup.department: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(QueueSetup.department.name.toCapitalized(), style: myStyle),
                      ),
                      QueueSetup.terminal: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(QueueSetup.terminal.name.toCapitalized(), style: myStyle),
                      ),
                      QueueSetup.agent: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(QueueSetup.agent.name.toCapitalized(), style: myStyle),
                      ),
                    },
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(child: _buildSelectedWidget(selected)),
                        _buildInfo(),
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

  Widget _buildSelectedWidget(QueueSetup selected){
    Logger.log(tag, message: '_selectedSegment: $_selectedSegment');
    if (selected==QueueSetup.department){
      return DepartmentPage(prefs: widget.prefs);
    } else if (selected==QueueSetup.terminal){
      return TerminalPage(prefs: widget.prefs);
    } else if (selected==QueueSetup.agent){
      return AgentPage(prefs: widget.prefs);
    } else {
      return const SizedBox();
    }
  }

  Widget _buildInfo(){
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChoiceChip(
              avatar: const Icon(CupertinoIcons.bookmark), 
              label: Text(S.of(context).department),
              selected: false
            ),
            const SizedBox(width: 8),
            ChoiceChip(
              avatar: const Icon(CupertinoIcons.cursor_rays), 
              label: Text(S.of(context).service),
              selected: false
            ),
            const SizedBox(width: 8),
            ChoiceChip(
              avatar: const Icon(CupertinoIcons.star), 
              label: Text(S.of(context).terminal),
              selected: false
            ),
            const SizedBox(width: 8),
            ChoiceChip(
              avatar: const Icon(CupertinoIcons.person), 
              label: Text(S.of(context).agent),
              selected: false
            ),
          ],
        ),
      ),
    );
  }
}
