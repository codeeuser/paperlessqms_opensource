part of 'openhour_bloc.dart';

@immutable
sealed class OpenhourEvent {}

class OpenhourResetEvent extends OpenhourEvent {}

class OpenhourLoadAllEvent extends OpenhourEvent {
  OpenhourLoadAllEvent();
}

class OpenhourLoadOneEvent extends OpenhourEvent {
  final int id;
  OpenhourLoadOneEvent({
    required this.id,
  });
}

class OpenhourAddEvent extends OpenhourEvent {
  final OpenhourModel openhour;
  OpenhourAddEvent({
    required this.openhour,
  });
}

class OpenhourUpdateEvent extends OpenhourEvent {
  final OpenhourModel openhour;
  OpenhourUpdateEvent({
    required this.openhour,
  });
}

class OpenhourRemoveEvent extends OpenhourEvent {
  final OpenhourModel openhour;
  OpenhourRemoveEvent({
    required this.openhour,
  });
}

class OpenhourSearchEvent extends OpenhourEvent {
  final String text;
  OpenhourSearchEvent({
    required this.text,
  });
}

class OpenhourEnableEvent extends OpenhourEvent {
  final OpenhourModel openhour;
  final bool enable;
  OpenhourEnableEvent({
    required this.openhour,
    required this.enable,
  });
}

class OpenhourSaveOrUpdateEvent extends OpenhourEvent {
  final int? id;
  final int startHour;
  final int startMin;
  final int endHour;
  final int endMin;
  final int dayNum;
  final bool enable;
  OpenhourSaveOrUpdateEvent({
    this.id,
    required this.startHour,
    required this.startMin,
    required this.endHour,
    required this.endMin,
    required this.dayNum,
    required this.enable,
  });
}

class OpenhourByBizEvent extends OpenhourEvent {
  final ProfileBizModel biz;
  final bool? enable;
  OpenhourByBizEvent({
    required this.biz,
    this.enable,
  });
}
