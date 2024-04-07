import 'package:admin/logger.dart';
import 'package:admin/screens/stat_rating_page.dart';
import 'package:admin/screens/stat_token_page.dart';
import 'package:common/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum StatSegment { token, rating}
enum StatTotalDay {day7, day14}
class StatPage extends StatefulWidget {
  final SharedPreferences prefs;
  const StatPage({super.key, required this.prefs});

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  static const String tag = 'StatPage';

  final ValueNotifier<StatSegment> _selectedSegment = ValueNotifier(StatSegment.token);

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async{  
  }

  @override
  void dispose() {
    _selectedSegment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? myStyle = Theme.of(context).textTheme.bodySmall?.apply(color: Colors.black);
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width>ScreenProp.widthPhoneScreenLimit){
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return ValueListenableBuilder(
      valueListenable: _selectedSegment,
      builder: (context, StatSegment selected, _) {
        return Column(
          children: [
            const SizedBox(height: 4),
            CupertinoSegmentedControl<StatSegment>(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              groupValue: selected,
              onValueChanged: (StatSegment value) {
                _selectedSegment.value = value;
              },
              children: <StatSegment, Widget>{
                StatSegment.token: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(StatSegment.token.name.toCapitalized(), style: myStyle),
                ),
                StatSegment.rating: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(StatSegment.rating.name.toCapitalized(), style: myStyle),
                ),
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _buildSelectedWidget(selected)
            ),
          ]
        );
      }
    );
  }

  Widget _buildSelectedWidget(StatSegment selected){
    Logger.log(tag, message: '_selectedSegment: $_selectedSegment');
    if (selected==StatSegment.token){
      return StatTokenPage(prefs: widget.prefs);
    } else if (selected==StatSegment.rating){
      return StatRatingPage(prefs: widget.prefs);
    } else {
      return const SizedBox();
    }
  }  
}
