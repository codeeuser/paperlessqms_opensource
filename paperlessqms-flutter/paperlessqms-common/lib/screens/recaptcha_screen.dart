import 'package:common/app_absorb.dart';
import 'package:common/logger.dart';
import 'package:common/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slider_captcha/slider_captcha.dart';

class RecaptchaScreen extends StatelessWidget {
  final Widget w;
  const RecaptchaScreen({super.key, required this.w});

  static const String tag = 'RecaptchaScreen';

  @override
  Widget build(BuildContext context) {
    final SliderController controller = SliderController();
    return Scaffold(
      body: Center(
        child: SliderCaptcha(
          controller: controller,
          image: Image.asset(
            'assets/images/1024.png',
            fit: BoxFit.fitWidth,
          ),
          colorBar: Colors.blue,
          colorCaptChar: Colors.blue,
          onConfirm: (value) async {
            AppAbsorb appAbsorb = context.read<AppAbsorb>();
            Logger.log(tag, message: 'value: $value');
            appAbsorb.recaptcha = value;
            if (value){
              Utils.pushAndRemoveUntilPage(context, w, 'FROM RecaptchaScreen');
            } else {
              controller.create.call();
            }
          },
        ),
      ),
    );
  }
}