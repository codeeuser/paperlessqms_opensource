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
import 'package:common/generated/l10n.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String? messageTop;
  final String? message;
  final Widget? child;
  final bool? showText;
  const NoData({super.key, this.showText=true, this.messageTop, this.message, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      margin: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (messageTop!=null)...[
              Text(messageTop??'', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 16),
            ],
            Image.asset('assets/images/nodata.png', width: 300, height: 300),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (showText==true)...[
                  Text(S.of(context).oop, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                ],
                if (message!=null)...[
                  Text(message!, style: const TextStyle(fontSize: 32, color: Colors.blue), textAlign: TextAlign.center),
                ],
                if (child!=null)...[
                  const SizedBox(height: 20),
                  child?? const SizedBox(),
                ]
              ],
            ),                       
          ],
        ),
      ),
    );
  }
}