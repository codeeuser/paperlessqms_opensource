part of 'service_bloc.dart';

@immutable
sealed class ServiceEvent {}

class ServiceResetEvent extends ServiceEvent {}

class ServiceLoadAllEvent extends ServiceEvent {
  ServiceLoadAllEvent();
}
class ServiceLoadByDepartmentEvent extends ServiceEvent {
  final QueueDepartmentModel department;
  final bool? enable;
  ServiceLoadByDepartmentEvent({
    required this.department,
    this.enable,
  });
}

class ServiceAddEvent extends ServiceEvent {
  final QueueServiceModel service;
  ServiceAddEvent({
    required this.service,
  });
}

class ServiceUpdateEvent extends ServiceEvent {
  final QueueServiceModel service;
  ServiceUpdateEvent({
    required this.service,
  });
}

class ServiceRemoveEvent extends ServiceEvent {
  final QueueServiceModel service;
  ServiceRemoveEvent({
    required this.service,
  });
}

class ServiceSearchEvent extends ServiceEvent {
  final String text;
  ServiceSearchEvent({
    required this.text,
  });
}