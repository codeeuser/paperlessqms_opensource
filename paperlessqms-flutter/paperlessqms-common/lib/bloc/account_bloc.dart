import 'dart:convert';

import 'package:common/models/register_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:common/models/account_model.dart';
import 'package:common/models/change_password_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/repositories/account_repository.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository repository;
  AccountBloc({
    required this.repository}) : super(AccountLoadingState()) {
    on<AccountResetEvent>(_resetEvent);
    on<AccountLoadAllEvent>(_loadAllEvent);
    on<AccountLoadOneEvent>(_loadOneEvent);
    on<AccountAddEvent>(_addEvent);
    on<AccountUpdateEvent>(_updateEvent);
    on<AccountRemoveEvent>(_removeEvent);
    on<AccountSearchEvent>(_searchEvent);
    on<ChangePasswordEvent>(_changePasswordEvent);
    on<ResetPasswordEvent>(_resetPasswordEvent);
    on<CheckAccountEvent>(_checkAccountEvent);
    on<RegisterEvent>(_registerEvent);
    on<AuthEvent>(_authEvent);
  }

  Future<void> _resetEvent(AccountResetEvent ev, Emitter<AccountState> emit) async{ 
    emit(AccountLoadingState());
  }

  Future<void> _loadAllEvent(AccountLoadAllEvent ev, Emitter<AccountState> emit) async{ 
    
  }

  Future<void> _loadOneEvent(AccountLoadOneEvent ev, Emitter<AccountState> emit) async{ 
    final login  = ev.login;
    dynamic data = await repository.getUser(login);
    if (data is ServerErrorModel) {
      emit(AccountErrorState(error: data));
      return;
    }
    emit(AccountOneLoadedState(account: data));
  }

  Future<void> _addEvent(AccountAddEvent ev, Emitter<AccountState> emit) async{ 
    final register = ev.register;
    dynamic data = await repository.register(jsonEncode(register));
    if (data is ServerErrorModel) {
      emit(AccountErrorState(error: data));
      return;
    }
  }

  Future<void> _updateEvent(AccountUpdateEvent ev, Emitter<AccountState> emit) async{ 
    final account = ev.account;
    dynamic data = await repository.updateAccount(account);
    if (data is ServerErrorModel) {
      emit(AccountErrorState(error: data));
      return;
    }
    emit(AccountOneLoadedState(account: data));
  }

  Future<void> _removeEvent(AccountRemoveEvent ev, Emitter<AccountState> emit) async{ 
    final account = ev.account;
    dynamic data = await repository.deleteAccount(account);
    if (data is ServerErrorModel) {
      emit(AccountErrorState(error: data));
      return;
    } 
    emit(AccountOneLoadedState(account: data));
  }

  Future<void> _searchEvent(AccountSearchEvent ev, Emitter<AccountState> emit) async{ 

  }

  Future<void> _changePasswordEvent(ChangePasswordEvent ev, Emitter<AccountState> emit) async{ 
    final changePassword = ev.changePassword;
    dynamic data = await repository.changePassword(changePassword);
    if (data is ServerErrorModel) {
      emit(AccountErrorState(error: data));
      return;
    }
    emit(AccountSuccessState()); 
  }

  Future<void> _resetPasswordEvent(ResetPasswordEvent ev, Emitter<AccountState> emit) async{ 
    final body = ev.body;
    dynamic data = await repository.resetPassword(body);
    if (data is ServerErrorModel) {
      emit(AccountErrorState(error: data));
      return;
    } 
  }

  Future<void> _checkAccountEvent(CheckAccountEvent ev, Emitter<AccountState> emit) async{ 
    dynamic data = await repository.checkAccount();
    if (data is ServerErrorModel) {
      emit(AccountErrorState(error: data));
      return;
    } 
    emit(AccountOneLoadedState(account: data));
  }

  Future<void> _registerEvent(RegisterEvent ev, Emitter<AccountState> emit) async{ 
    final body = ev.body;
    dynamic data = await repository.register(body);
    if (data is ServerErrorModel) {
      emit(AccountErrorState(error: data));
      return;
    } 
    emit(AccountOneLoadedState(account: data));
  }

  Future<void> _authEvent(AuthEvent ev, Emitter<AccountState> emit) async{ 
    final body = ev.body;
    dynamic data = await repository.auth(body);
    if (data is ServerErrorModel) {
      emit(AccountErrorState(error: data));
      return;
    } 
    emit(AccountOneLoadedState(account: data));
  }
}
