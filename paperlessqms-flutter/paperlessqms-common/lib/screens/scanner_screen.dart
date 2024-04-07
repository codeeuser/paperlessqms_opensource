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

import 'package:common/generated/l10n.dart';
import 'package:common/logger.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/no_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef ActionCallback = void Function(String text, QRCodeDartScanController? controller);

class ScannerScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final Widget back;
  final ActionCallback actionCallback;
  final bool live;
  const ScannerScreen({super.key, required this.prefs, required this.back, required this.actionCallback, required this.live});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  static const String tag = 'ScannerScreen';

  final QRCodeDartScanController _controller = QRCodeDartScanController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(S.of(context).scan),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.chevron_back),
          onPressed: (){
            _controller.dispose();
            Utils.pushAndRemoveUntilPage(context, widget.back, 'Back');
          },
        ),
      ),
      body: (Utils.isMobile)? _buildScan(): _buildNoSupport()
    );
  }

  Widget _buildNoSupport(){
    return Center(
      child: NoData(message: S.of(context).noSupportForDesktop),
    );
  }

  Widget _buildScan(){
    return Center(
      child: QRCodeDartScanView(
        scanInvertedQRCode: true,
        typeScan: (widget.live)? TypeScan.live: TypeScan.takePicture,
        formats: const [
          BarcodeFormat.qrCode,
        ],
        // typeCamera: (widget.live)? TypeCamera.back: TypeCamera.front,
        controller: _controller,
        onCapture: (Result result) async{
          String text = result.text;
          Logger.log(tag, message: 'text: $text');
          if (text.isNotEmpty){
            String textNew = Utils.aesDecrypt(text, Constants.password);
            widget.actionCallback(textNew, _controller);
          }
        },
        child: Center(
          child: Container(
            width: 30,
            height: 30,
            decoration: DecoratorUtils.box(),
          ),
        ),
      ),
    );
  }
}