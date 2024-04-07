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
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:admin/logger.dart';
import 'package:common/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgentWidget extends StatelessWidget {

  const AgentWidget({super.key});

  static const String tag = 'AgentWidget';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
              icon: const Icon(CupertinoIcons.search),
              onPressed: () async{
                final text = await showTextInputDialog(
                  context: context, 
                  title: S.of(context).searchAgent,
                  message: 'Search the agent from database...',
                  textFields: [
                    DialogTextField(
                      hintText: S.of(context).agent
                    )
                  ]
                );
                Logger.log(tag, message: 'text: $text');
              },
            ),
          ),
          const Expanded(
            flex: 9,
            child: TextField(
              // placeholder: S.of(context).name,
              readOnly: true,
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: const Icon(CupertinoIcons.trash),
              onPressed: (){

              },
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          )
        ],
      ),
    );
  }
}