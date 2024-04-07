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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MsgBoxWidget extends StatelessWidget {
  final ValueNotifier<List<String>> messages;
  final double width;
  const MsgBoxWidget({super.key, required this.messages, required this.width});

  @override
  Widget build(BuildContext context) {
    return _buildErrors(context, width);
  }

  Widget _buildErrors(BuildContext context, double width){
    TextStyle? style = Theme.of(context).textTheme.bodyLarge?.apply(color: Colors.green.shade900);
    return ValueListenableBuilder(
      valueListenable: messages, 
      builder: (context, List<String> msgList, _){
        if (msgList.isEmpty){
          return const SizedBox();
        }
        return Card(
          child: Container(
            padding: const EdgeInsets.all(8),
            width: width,
            color: Colors.lightGreen.shade200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 11,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: msgList.map((e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Icon(CupertinoIcons.check_mark_circled, color: Colors.green.shade900),
                            ),
                            const SizedBox(width: 16),
                            Expanded(flex: 11, child: Text(e, style: style)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  flex:  1,
                  child: IconButton(
                    icon: const Icon(CupertinoIcons.xmark),
                    onPressed: (){
                      messages.value = [];
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}