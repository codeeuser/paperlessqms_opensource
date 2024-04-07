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
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Header extends StatelessWidget {
  final Color? backgroundColor;
  final Color? fontColor;
  const Header({super.key, this.backgroundColor, this.fontColor});

  @override
  Widget build(BuildContext context) {
    TextStyle? style = TextStyle(color: (fontColor!=null)? fontColor: Colors.black, fontSize: 40);
    return SizedBox(
      child: Column(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 40, bottom: 50),
              width: MediaQuery.of(context).size.width,
              color: (backgroundColor!=null)? backgroundColor: Colors.yellow,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(S.of(context).title, style: style),
                    ),
                  ],
                )
              ),
            ),
          ),
          _buildDesc(),
        ],
      ),
    );
  }

  Widget _buildDesc(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Utils.buildStatusBox(Status.onwait),
          const SizedBox(width: 24),
          Utils.buildStatusBox(Status.onqueue),
          const SizedBox(width: 24),
          Utils.buildStatusBox(Status.completed),
          const SizedBox(width: 24),
          Utils.buildStatusBox(Status.recall),
          const SizedBox(width: 24),
          Utils.buildStatusBox(Status.timeout),
          const SizedBox(width: 24),
          Utils.buildStatusBox(Status.transfer),
          const SizedBox(width: 24),
          Utils.buildStatusBox(Status.cancel),
        ],
      ),
    );
  }

  
}