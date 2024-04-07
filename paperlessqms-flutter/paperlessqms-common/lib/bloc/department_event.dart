part of 'department_bloc.dart';

@immutable
sealed class DepartmentEvent {}

class DepartmentResetEvent extends DepartmentEvent {}

class DepartmentLoadAllEvent extends DepartmentEvent {
  final bool? enable;
  DepartmentLoadAllEvent({
    this.enable,
  });
}

class DepartmentLoadOneEvent extends DepartmentEvent {
  final int id;
  DepartmentLoadOneEvent({
    required this.id,
  });
}

class DepartmentAddEvent extends DepartmentEvent {
  final QueueDepartmentModel department;
  DepartmentAddEvent({
    required this.department,
  });
}

class DepartmentUpdateEvent extends DepartmentEvent {
  final QueueDepartmentModel department;
  DepartmentUpdateEvent({
    required this.department,
  });
}

class DepartmentRemoveEvent extends DepartmentEvent {
  final QueueDepartmentModel department;
  DepartmentRemoveEvent({
    required this.department,
  });
}

class DepartmentSearchEvent extends DepartmentEvent {
  final String text;
  DepartmentSearchEvent({
    required this.text,
  });
}

class DepartmentEnableEvent extends DepartmentEvent {
  final QueueDepartmentModel department;
  final bool enable;
  DepartmentEnableEvent({
    required this.department,
    required this.enable,
  });
}

class DepartmentDummyEvent extends DepartmentEvent {
  DepartmentDummyEvent();
}

class DepartmentSaveOrUpdateEvent extends DepartmentEvent {
  final int? id;
  final String name;
  final String desc;
  final String banner;
  final List<QueueServiceModel> services;
  DepartmentSaveOrUpdateEvent({
    this.id,
    required this.name,
    required this.desc,
    required this.banner,
    required this.services,
  });
}

class DepartmentByBizEvent extends DepartmentEvent {
  final ProfileBizModel biz;
  final bool? enable;
  DepartmentByBizEvent({
    required this.biz,
    this.enable,
  });
}

class DepartmentWithQrEvent extends DepartmentEvent {
  final int depId;
  final String banner;
  final QRCodeDartScanController? controller;
  DepartmentWithQrEvent({
    required this.depId,
    required this.banner,
    this.controller,
  });
}
