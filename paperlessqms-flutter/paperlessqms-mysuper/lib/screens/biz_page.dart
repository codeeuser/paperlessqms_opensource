import 'package:common/bloc/biz_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:mysuper/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BizPage extends StatefulWidget {
  final SharedPreferences prefs;
  final ProfileBizModel biz;
  const BizPage({super.key, required this.prefs, required this.biz});

  @override
  State<BizPage> createState() => _BizPageState();
}

class _BizPageState extends State<BizPage> {
  static const String tag = 'BizPage';

  final ValueNotifier<int> _bizLevel = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async{
    _bizLevel.value = widget.biz.bizLevel??0;
  }

  @override
  void dispose() {
    _bizLevel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: _buildBusiness()
      ),
    );
  }

  Widget _buildBusiness(){
    TextStyle? styleLarge = Theme.of(context).textTheme.headlineMedium;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width>ScreenProp.widthPhoneScreenLimit){
      width = ScreenProp.widthPhoneScreenLimit;
    }

    return Center(
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: DecoratorUtils.actionBar(),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  Text(widget.biz.bizName??'', style: styleLarge),
                  Text('ID: ${widget.biz.id}', style: styleLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).businessLevel),
                      ValueListenableBuilder(
                        valueListenable: _bizLevel,
                        builder: (context, int bizLevel, _) {
                          return InputQty.int(
                            maxVal: 100,
                            initVal: bizLevel,
                            minVal: 0,
                            steps: 1,
                            onQtyChanged: (val) async{
                              Logger.log(tag, message: 'bizLevel: $val');
                              int level = int.tryParse(val.toString())??0;
                              widget.biz.bizLevel = level;
                              context.read<BizBloc>().add(BizUpdateEvent(biz: widget.biz));
                              _bizLevel.value = level;
                            },
                          );
                        }
                      ),
                    ],
                  ),
                ],
              )
            )
          ]
        )
      )
    );
  }
}