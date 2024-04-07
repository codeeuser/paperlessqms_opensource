import 'package:admin/logger.dart';
import 'package:admin/screens/stat_page.dart';
import 'package:common/bloc/token_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/stat_rating_status.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatRatingPage extends StatefulWidget {
  final SharedPreferences prefs;
  const StatRatingPage({super.key, required this.prefs});

  @override
  State<StatRatingPage> createState() => _StatRatingPageState();
}

class _StatRatingPageState extends State<StatRatingPage> {
  static const String tag = 'StatRatingPage';

  final ValueNotifier<StatTotalDay> _totalDay = ValueNotifier(StatTotalDay.day7);

  int _ratingCode = RatingCode.five;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async{  
    await _refresh(_ratingCode, StatTotalDay.day7);
  }

  @override
  void dispose() {
    _totalDay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width>ScreenProp.widthPhoneScreenLimit){
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return Center(
      child: Container(
        alignment: Alignment.topCenter,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTitle(),
              const SizedBox(height: 8),
              _buildBoxBar(width),
              Constants.divider,
              _buildChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart(){
    TextStyle? styleTitle = Theme.of(context).textTheme.bodyLarge;
    return BlocBuilder<TokenBloc, TokenState>(
      builder: (context, state) {
        String? insight;
        List<(DateTime, int)>? recordDays;
        if (state is TokenCountLoadedState){
          recordDays = state.statRatingStatus.dateCountList;
          Logger.log(tag, message: 'recordDays: $recordDays');
          recordDays?.sort((a, b)=> a.$1.compareTo(b.$1));
          insight = (recordDays?.length==7)?S.of(context).insightLast7days:
              (recordDays?.length==14)?S.of(context).insightLast14days:
              (recordDays?.length==30)?S.of(context).insightLast30days: ''; 
        }
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              Text(insight??'', style: styleTitle),
              const SizedBox(height: 4),
              Expanded(
                child: DChartBarO(                          
                  groupList: [
                    OrdinalGroup(
                      id: '${recordDays?.length}',
                      color: Utils.getRatingColor(_ratingCode),
                      data: [
                        for((DateTime, int) count in recordDays??[])...[
                          OrdinalData(domain: '${(count.$1).day}/${(count.$1).month}', measure: count.$2),
                        ],
                      ]
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildTitle(){
    TextStyle? styleHeader = Theme.of(context).textTheme.bodyLarge?.apply(color: Colors.white);
    Color colorHeader = Colors.grey.shade400;
    return ListTile(
      title: Text(S.of(context).statistic.toUpperCase(), style: styleHeader),
      subtitle: ValueListenableBuilder(
        valueListenable: _totalDay,
        builder: (context, StatTotalDay totalDay, _) {
          return Row(
            children: [
              ActionChip(
                label: const Text('7 days'),
                backgroundColor: (totalDay==StatTotalDay.day7)? Colors.lightBlue: null,
                onPressed: (){
                  StatTotalDay totalDay = StatTotalDay.day7;
                  _totalDay.value = totalDay;
                  _refresh(_ratingCode, totalDay);
                },
              ),
              const SizedBox(width: 8),
              ActionChip(
                label: const Text('14 days'),
                backgroundColor: (totalDay==StatTotalDay.day14)? Colors.lightBlue: null,
                onPressed: (){
                  StatTotalDay totalDay = StatTotalDay.day14;
                  _totalDay.value = totalDay;
                  _refresh(_ratingCode, totalDay);
                },
              ),
              const SizedBox(width: 8),
            ],
          );
        }
      ),
      tileColor: colorHeader,
    );
  }

  Widget _buildBoxBar(double width){
    return BlocBuilder<TokenBloc, TokenState>(
      builder: (context, state) {
        StatRatingStatus? ratingStatus;
        if (state is TokenCountLoadedState){
          ratingStatus = state.statRatingStatus;
        }
        return SizedBox(
          width: width,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RotatedBox(
                quarterTurns: -1,
                child: Text(S.of(context).total.toUpperCase(), 
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: _totalDay,
                    builder: (context, StatTotalDay totalDay, _) {
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCountBox(RatingCode.five, ratingStatus?.countFive, totalDay),
                        _buildCountBox(RatingCode.four, ratingStatus?.countFour, totalDay),
                        _buildCountBox(RatingCode.three, ratingStatus?.countThree, totalDay),
                        _buildCountBox(RatingCode.two, ratingStatus?.countTwo, totalDay),
                        _buildCountBox(RatingCode.one, ratingStatus?.countOne, totalDay),
                      ],
                    );
                  }
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildCountBox(int ratingCode, int? count, StatTotalDay totalDay){
    TextStyle? styleTitle = Theme.of(context).textTheme.bodyLarge?.apply(color: Colors.white);
    TextStyle? styleCount = Theme.of(context).textTheme.headlineLarge?.apply(color: Colors.white);
    Color color = Utils.getRatingColor(ratingCode);
    double width = 110;
    double height = 100;
    return InkWell(
      child: DottedBorder(
        color: (_ratingCode==ratingCode)? Colors.orangeAccent: Colors.transparent,
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [6, 4, 6, 4], 
        padding: const EdgeInsets.all(4),
        strokeWidth: 2,
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(8),
          decoration: DecoratorUtils.box(color: color),
          child: Column(
            children: [
              Text('Rating $ratingCode', style: styleTitle),
              const SizedBox(height: 4),
              FittedBox(
                child: Text('${count??0}', style: styleCount)
              ),
            ],
          ),
        ),
      ),
      onTap: () async{
        _ratingCode = ratingCode;
        await _refresh(ratingCode, totalDay);
      },
    );
  }

  Future<void> _refresh(int ratingCode, StatTotalDay totalDay) async{
    Logger.log(tag, message: '_refresh---');
    int day = (totalDay==StatTotalDay.day7)? 7: (totalDay==StatTotalDay.day14)?14: 0;
    context.read<TokenBloc>().add(TokenCountRatingByBizAndDayEvent(totalDay: day, ratingCode: ratingCode));
  }
}

