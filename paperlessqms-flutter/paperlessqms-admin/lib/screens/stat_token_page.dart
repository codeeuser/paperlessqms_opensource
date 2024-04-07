import 'package:admin/logger.dart';
import 'package:admin/screens/stat_page.dart';
import 'package:common/bloc/token_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/stat_count_status.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StatTokenPage extends StatefulWidget {
  final SharedPreferences prefs;
  const StatTokenPage({super.key, required this.prefs});

  @override
  State<StatTokenPage> createState() => _StatTokenPageState();
}

class _StatTokenPageState extends State<StatTokenPage> {
  static const String tag = 'StatTokenPage';

  final ValueNotifier<StatTotalDay> _totalDay = ValueNotifier(StatTotalDay.day7);

  int _statusCode = StatusCode.onwait;
  StatCountStatus? _countStatus;
  List<(DateTime, int)>? _recordDays;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async{  
    await _refresh(_statusCode, StatTotalDay.day7);
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
                  _refresh(_statusCode, totalDay);
                },
              ),
              const SizedBox(width: 8),
              ActionChip(
                label: const Text('14 days'),
                backgroundColor: (totalDay==StatTotalDay.day14)? Colors.lightBlue: null,
                onPressed: (){
                  StatTotalDay totalDay = StatTotalDay.day14;
                  _totalDay.value = totalDay;
                  _refresh(_statusCode, totalDay);
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
        if (state is TokenCountByBizWithStatusLoadedState){
          _countStatus = state.statCountStatus;
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
                        _buildCountBox(StatusCode.onwait, _countStatus?.countWait, totalDay),
                        _buildCountBox(StatusCode.onqueue, _countStatus?.countQueue, totalDay),
                        _buildCountBox(StatusCode.completed, _countStatus?.countCompleted, totalDay),
                        _buildCountBox(StatusCode.recall, _countStatus?.countRecall, totalDay),
                        _buildCountBox(StatusCode.timeout, _countStatus?.countTimeout, totalDay),
                        _buildCountBox(StatusCode.cancel, _countStatus?.countCancel, totalDay),
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

  Widget _buildChart(){
    TextStyle? styleTitle = Theme.of(context).textTheme.bodyLarge;
    return BlocBuilder<TokenBloc, TokenState>(
      builder: (context, state) {
        if (state is TokenCountByBizWithStatusLoadedState){
          _recordDays = state.statCountStatus.dateCountList;
        }
        Logger.log(tag, message: '_recordDays: $_recordDays');
        _recordDays?.sort((a, b)=> a.$1.compareTo(b.$1));
        String insight = (_recordDays?.length==7)?S.of(context).insightLast7days:
            (_recordDays?.length==14)?S.of(context).insightLast14days:
            (_recordDays?.length==30)?S.of(context).insightLast30days: ''; 
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              Text('$insight "${Utils.getStatusName(_statusCode)}" Status', style: styleTitle),
              const SizedBox(height: 4),
              Expanded(
                child: DChartBarO(                          
                  groupList: [
                    OrdinalGroup(
                      id: '${_recordDays?.length}',
                      color: Utils.getStatusColor(Utils.getStatusName(_statusCode)),
                      data: [
                        for((DateTime, int) count in _recordDays??[])...[
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

  Widget _buildCountBox(int statusCode, int? count, StatTotalDay totalDay){
    TextStyle? styleTitle = Theme.of(context).textTheme.bodyLarge?.apply(color: Colors.white);
    TextStyle? styleCount = Theme.of(context).textTheme.headlineLarge?.apply(color: Colors.white);
    String statusName = Utils.getStatusName(statusCode);
    Color color = Utils.getStatusColor(statusName);
    double width = 110;
    double height = 100;
    return InkWell(
      child: DottedBorder(
        color: (_statusCode==statusCode)? Colors.orangeAccent: Colors.transparent,
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
              Text(statusName, style: styleTitle),
              const SizedBox(height: 4),
              FittedBox(
                child: Text('${count??0}', style: styleCount)
              ),
            ],
          ),
        ),
      ),
      onTap: () async{
        _statusCode = statusCode;
        await _refresh(statusCode, totalDay);
      },
    );
  }
  
  Future<void> _refresh(int statusCode, StatTotalDay totalDay) async{
    Logger.log(tag, message: '_refresh---');
    int day = (totalDay==StatTotalDay.day7)? 7: (totalDay==StatTotalDay.day14)?14: 0;
    context.read<TokenBloc>().add(TokenCountByBizAndDayEvent(totalDay: day, statusCode: statusCode));
  }
}
