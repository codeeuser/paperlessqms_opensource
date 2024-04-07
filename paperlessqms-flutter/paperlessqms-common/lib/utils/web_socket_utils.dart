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
import 'package:common/utils/constants.dart';
import 'package:common/logger.dart';
import 'package:common/models/header_model.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class WebSocketUtils {
  static String tag = 'WebSocketUtils';

  static StompClient? connect(String urlWebSocket, Function(StompFrame) onConnect, List<HeaderModel>? headers){
    Map<String, String> mapHeader = {};
    for (HeaderModel header in headers ?? []) {
      mapHeader[header.name] = header.value;
    }
    Logger.log(tag, message: 'urlWebSocket: $urlWebSocket, mapHeader: $mapHeader');
    StompClient stompClient = StompClient(
      config: StompConfig.sockJS(
        url: urlWebSocket,
        onConnect: onConnect,
        beforeConnect: () async {
          Logger.log(tag, message: '===waiting to connect...$urlWebSocket');
          await Future.delayed(const Duration(milliseconds: Constants.delayLoadTime));
          Logger.log(tag, message: '===connecting...');
        },
        onWebSocketError: (dynamic error) =>
            Logger.log(tag, message: 'onWebSocketError: $error'),
        onStompError: (dynamic error) =>
            Logger.log(tag, message: 'onStompError: $error'),
        onDisconnect: (f) =>
            Logger.log(tag, message: 'StompClient DISCONNECT'),
        onDebugMessage: (dynamic m) {
            Logger.log(tag, message: 'onDebugMessage: $m');
        },
        stompConnectHeaders: mapHeader,
        webSocketConnectHeaders: mapHeader,
      ),
    );
    return stompClient;
  }
}