part of 'service_bloc.dart';

@immutable
sealed class ServiceState {}

class ServiceLoadingState extends ServiceState {
  ServiceLoadingState();
}

class ServiceLoadedState extends ServiceState {
  final List<QueueServiceModel> services;
  ServiceLoadedState({
    required this.services,
  });
}

class ServiceMissingBizState extends ServiceState {}

class ServiceErrorState extends ServiceState {
  final ServerErrorModel error;
  ServiceErrorState({
    required this.error,
  });
}