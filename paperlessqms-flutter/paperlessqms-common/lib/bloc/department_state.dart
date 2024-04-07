part of 'department_bloc.dart';

@immutable
sealed class DepartmentState {}

class DepartmentLoadingState extends DepartmentState {
  DepartmentLoadingState();
}

class DepartmentLoadedState extends DepartmentState {
  final List<QueueDepartmentModel> departments;
  DepartmentLoadedState({
    required this.departments,
  });
}

class DepartmentOneLoadedState extends DepartmentState {
  final QueueDepartmentModel department;
  DepartmentOneLoadedState({
    required this.department,
  });
}

class DepartmentQrSuccessState extends DepartmentState {
  final QueueDepartmentModel department;
  final ProfileBizModel biz;
  final List<QueueDepartmentModel> departments;
  DepartmentQrSuccessState({
    required this.department,
    required this.biz,
    required this.departments,
  });
}

class DepartmentSuccessState extends DepartmentState {}

class DepartmentMissingBizState extends DepartmentState {}

class DepartmentErrorTerminalState extends DepartmentState {}

class DepartmentErrorState extends DepartmentState {
  final ServerErrorModel error;
  DepartmentErrorState({
    required this.error,
  });
}