part of 'biz_bloc.dart';

@immutable
sealed class BizEvent {}

class BizResetEvent extends BizEvent {}

class BizLoadAllEvent extends BizEvent {
  final int? page;
  final int? pageSize;
  final String? sortBy;
  final bool? enable;
  BizLoadAllEvent({
    this.page,
    this.pageSize,
    this.sortBy,
    this.enable,
  });
}

class BizLoadOneEvent extends BizEvent {
  BizLoadOneEvent();
}

class BizAddEvent extends BizEvent {
  final ProfileBizModel biz;
  BizAddEvent({
    required this.biz,
  });
}

class BizUpdateEvent extends BizEvent {
  final ProfileBizModel biz;
  BizUpdateEvent({
    required this.biz,
  });
}

class BizRemoveEvent extends BizEvent {
  final ProfileBizModel biz;
  BizRemoveEvent({
    required this.biz,
  });
}

class BizSearchEvent extends BizEvent {
  final String text;
  BizSearchEvent({
    required this.text,
  });
}

class BizSaveOrUpdateEvent extends BizEvent {
  final int? id;
  final String name;
  final String desc;
  final String phone;
  final String email;
  final String address;
  final String website;
  final String bizLogoBase64;
  final String bizPhotoBase64;
  BizSaveOrUpdateEvent({
    this.id,
    required this.name,
    required this.desc,
    required this.phone,
    required this.email,
    required this.address,
    required this.website,
    required this.bizLogoBase64,
    required this.bizPhotoBase64,
  });
}

class BizEnableEvent extends BizEvent {
  final ProfileBizModel biz;
  final bool enable;
  BizEnableEvent({
    required this.biz,
    required this.enable,
  });
}

class BizByIdEvent extends BizEvent {
  final int id;
  BizByIdEvent({
    required this.id,
  });
}