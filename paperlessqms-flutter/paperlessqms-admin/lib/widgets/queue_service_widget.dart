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

import 'package:admin/logger.dart';
import 'package:common/models/queue_service_model.dart';
import 'package:common/utils/constants.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/validation_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef DeleteCallback = void Function(QueueServiceModel queueService);

class QueueServiceWidget extends StatefulWidget {
  final DeleteCallback deleteCallback;
  final QueueServiceModel queueService;

  const QueueServiceWidget({super.key, 
    required this.deleteCallback, 
    required this.queueService,
  });

  @override
  State<QueueServiceWidget> createState() => _QueueServiceWidgetState();
}

class _QueueServiceWidgetState extends State<QueueServiceWidget> {
  static const String tag = 'QueueServiceWidget';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _letterController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    _nameController.text = widget.queueService.name??''.trim();
    _letterController.text = widget.queueService.letter??''.trim();
    _startController.text = (widget.queueService.start??'').toString().trim();
    _descController.text = widget.queueService.desc??''.trim();
    Logger.log(tag, message: 'orderNum: ${widget.queueService.orderNum}, name: ${widget.queueService.name}');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _letterController.dispose();
    _startController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReorderableDragStartListener(
                index: widget.queueService.orderNum??0,
                child: const Icon(CupertinoIcons.line_horizontal_3),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: _nameController,
                  textAlignVertical: TextAlignVertical.center,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value?.isNotEmpty==true) {
                      return ValidateUtils.validateStringMinMax(value, 1, 20, 'Service Name');
                    } 
                    return null;
                  },
                  decoration: DecoratorUtils.inputDecoration(
                    S.of(context).serviceName, 
                    suffixIcon: CupertinoIcons.xmark,
                    clear: (){
                      _nameController.clear();
                    },
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty==true) {
                      widget.queueService.name = value;
                    }
                  },                  
                ),
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.trash),
                onPressed: (){
                  widget.deleteCallback(widget.queueService);
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: TextFormField(
                  controller: _letterController,
                  textAlignVertical: TextAlignVertical.center,
                  textCapitalization: TextCapitalization.characters,
                  decoration: DecoratorUtils.inputDecoration(
                    S.of(context).serviceLetter, 
                    suffixIcon: CupertinoIcons.xmark,
                    clear: (){
                      _letterController.clear();
                    },
                  ),
                  validator: (value) {
                    if (value?.isNotEmpty==true) {
                      return ValidateUtils.validateStringMinMax(value, 1, 5, 'Service Letter');
                    } 
                    return null;
                  },
                  onChanged: (value){
                    dynamic myNum = num.tryParse(value);
                    if (myNum is! num) {
                      widget.queueService.letter = value;
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 6,
                child: TextFormField(
                  controller: _startController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                  decoration: DecoratorUtils.inputDecoration(
                    S.of(context).startNumber, 
                    suffixIcon: CupertinoIcons.xmark,
                    clear: (){
                      _startController.clear();
                    },
                  ),
                  validator: (value) {
                    if (value?.isNotEmpty==true) {
                      return ValidateUtils.validateDigitMinMax(value, 1, 9999);
                    } 
                    return null;
                  },
                  onChanged: (value){
                    final start = int.tryParse(value.trim());
                    if (start is int && start > 0){
                      widget.queueService.start = start;
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: _descController,
            textAlignVertical: TextAlignVertical.center,
            textCapitalization: TextCapitalization.sentences,
            decoration: DecoratorUtils.inputDecoration(
              S.of(context).description, 
              suffixIcon: CupertinoIcons.xmark,
              clear: (){
                _descController.clear();
              },
            ),
            onChanged: (value) {
              widget.queueService.desc = value;
            },
          ),
          Constants.divider,
        ],
      ),
    );
  }
}