// ignore_for_file: use_build_context_synchronously

import 'package:client/logger.dart';
import 'package:common/bloc/token_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/token_issued_model.dart';
import 'package:common/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final TokenIssuedModel issued;
  const FeedbackScreen({super.key, required this.prefs, required this.issued});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  static const String tag = 'FeedbackScreen';

  final TextEditingController _feedbackController = TextEditingController();

  double _rating = 3.0;

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
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.labelLarge;
    TextStyle? styleMedium = Theme.of(context).textTheme.headlineMedium;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width>ScreenProp.widthPhoneScreenLimit){
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(S.of(context).feedback),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.topCenter,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                _buildTokenInfo(widget.issued),
                if (widget.issued.rating==null)...[
                  _buildRating(),
                  const SizedBox(height: 16),
                  _buildFeedback(),
                  const SizedBox(height: 40),
                  Text('${S.of(context).feedback.toUpperCase()}: $_rating', style: style),
                ] else ...[
                  Text('${S.of(context).rating}: ${widget.issued.rating}', style: styleMedium),
                  if (widget.issued.feedback?.isNotEmpty==true)...[
                    const SizedBox(height: 16),
                    Text('${S.of(context).feedback}: ${widget.issued.feedback??'<${S.of(context).empty}>'}', 
                      overflow: TextOverflow.ellipsis),
                  ],
                ],
                const SizedBox(height: 80),
                ElevatedButton(
                  child: Text(S.of(context).done),
                  onPressed: () async{
                    TokenIssuedModel issued = widget.issued;
                    if (issued.rating==null) {
                      issued.rating = _rating;
                      issued.feedback = _feedbackController.text.trim();
                      context.read<TokenBloc>().add(TokenUpdateEvent(token: issued));
                    }                    
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeedback(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _feedbackController,
        maxLength: 200,
        maxLines: 3,
        minLines: 3,
      ),
    );
  }
  
  Widget _buildRating() {
    return RatingBar.builder(
      initialRating: _rating,
      itemCount: 5,
      itemSize: 50,
      itemPadding: const EdgeInsets.symmetric(horizontal: 8),
      wrapAlignment: WrapAlignment.center,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return const Icon(
                Icons.sentiment_very_dissatisfied,
                color: Colors.red,
            );
          case 1:
            return const Icon(
                Icons.sentiment_dissatisfied,
                color: Colors.redAccent,
            );
          case 2:
            return const Icon(
                Icons.sentiment_neutral,
                color: Colors.amber,
            );
          case 3:
            return const Icon(
                Icons.sentiment_satisfied,
                color: Colors.lightGreen,
            );
          case 4:
              return const Icon(
                Icons.sentiment_very_satisfied,
                color: Colors.green,
              );
        }
        return const SizedBox();
      },
      onRatingUpdate: (rating) {
        Logger.log(tag, message: 'rating: $rating');
        setState(() {
          _rating = rating;
        });
      },
    );
  }
  
  Widget _buildTokenInfo(TokenIssuedModel issued) {
    TextStyle? styleHeadLine = Theme.of(context).textTheme.headlineLarge;
    TextStyle? styleLabel = Theme.of(context).textTheme.labelLarge;
    String tokenInfo = '${issued.tokenLetter}-${issued.tokenNumber}';
    String? departmentName = issued.departmentName;
    String? serviceName = issued.serviceName;
    return Column(
      children: [
        Text(tokenInfo, style: styleHeadLine),
        const SizedBox(height: 8),
        Text(issued.bizName??'', style: styleLabel),
        const SizedBox(height: 16),
        if (departmentName!=null)...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(CupertinoIcons.bookmark),
              const SizedBox(width: 8.0),
              Text(departmentName, style: styleLabel),
            ],
          ),
          const SizedBox(height: 8),
        ],
        if (serviceName!=null)...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(CupertinoIcons.star),
              const SizedBox(width: 8.0),
              Text(serviceName, style: styleLabel),
            ],
          ),
          const SizedBox(height: 8),
        ],
        const SizedBox(height: 24),
      ],
    );
  }
}