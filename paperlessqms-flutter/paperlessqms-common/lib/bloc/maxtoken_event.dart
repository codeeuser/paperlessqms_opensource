part of 'maxtoken_bloc.dart';

@immutable
sealed class MaxtokenEvent {}

class MaxtokenResetEvent extends MaxtokenEvent {}

class MaxtokenLoadAllEvent extends MaxtokenEvent {
  MaxtokenLoadAllEvent();
}

class MaxtokenLoadOneEvent extends MaxtokenEvent {
  final int id;
  MaxtokenLoadOneEvent({
    required this.id,
  });
}

class MaxtokenAddEvent extends MaxtokenEvent {
  final MaxtokenModel maxtoken;
  MaxtokenAddEvent({
    required this.maxtoken,
  });
}

class MaxtokenUpdateEvent extends MaxtokenEvent {
  final MaxtokenModel maxtoken;
  MaxtokenUpdateEvent({
    required this.maxtoken,
  });
}

class MaxtokenRemoveEvent extends MaxtokenEvent {
  final MaxtokenModel maxtoken;
  MaxtokenRemoveEvent({
    required this.maxtoken,
  });
}

class MaxtokenSearchEvent extends MaxtokenEvent {
  final String text;
  MaxtokenSearchEvent({
    required this.text,
  });
}

class MaxtokenSaveOrUpdateEvent extends MaxtokenEvent {
  final int? id;
  final int dayNum;
  final int maxToken;
  MaxtokenSaveOrUpdateEvent({
    this.id,
    required this.dayNum,
    required this.maxToken,
  });
}

class MaxtokenByBizEvent extends MaxtokenEvent {
  final ProfileBizModel biz;
  final bool? enable;
  MaxtokenByBizEvent({
    required this.biz,
    this.enable,
  });
}