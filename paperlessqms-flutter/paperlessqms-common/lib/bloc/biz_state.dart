part of 'biz_bloc.dart';

@immutable
sealed class BizState {}

class BizLoadingState extends BizState {
  BizLoadingState();
}

class BizLoadedState extends BizState {
  final List<ProfileBizModel> bizs;
  BizLoadedState({
    required this.bizs,
  });
}

class BizOneLoadedState extends BizState {
  final ProfileBizModel biz;
  BizOneLoadedState({
    required this.biz,
  });
}

class BizSuccessState extends BizState {}

class BizFailureState extends BizState {}

class BizMissingBizState extends BizState {}

class BizErrorState extends BizState {
  final ServerErrorModel error;
  BizErrorState({
    required this.error,
  });
}