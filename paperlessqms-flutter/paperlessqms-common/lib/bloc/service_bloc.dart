import 'package:common/models/queue_department_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/repositories/biz_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:common/models/queue_service_model.dart';
import 'package:common/repositories/service_repository.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepository repository;
  final BizRepository bizRepository;
  ServiceBloc({
    required this.repository,
    required this.bizRepository}) : super(ServiceLoadingState()) {
    on<ServiceResetEvent>(_resetEvent);
    on<ServiceLoadAllEvent>(_loadAllEvent);
    on<ServiceLoadByDepartmentEvent>(_loadByDepartmentEvent);
    on<ServiceAddEvent>(_addEvent);
    on<ServiceUpdateEvent>(_updateEvent);
    on<ServiceRemoveEvent>(_removeEvent);
    on<ServiceSearchEvent>(_searchEvent);
  }

  Future<void> _resetEvent(ServiceResetEvent ev, Emitter<ServiceState> emit) async{ 
    emit(ServiceLoadingState());
  }

  Future<void> _loadAllEvent(ServiceLoadAllEvent ev, Emitter<ServiceState> emit) async{ 

  }

  Future<void> _loadByDepartmentEvent(ServiceLoadByDepartmentEvent ev, Emitter<ServiceState> emit) async{ 
    emit(ServiceLoadingState());
    final dep = ev.department;
    final enable = ev.enable;
    final data = await repository.findServiceByDepartment(dep, enable: enable);
    final error = ServerErrorModel.fromMap(data);
    if (error.data!=null) {
      emit(ServiceErrorState(error: error));
      return;
    } 
    emit(ServiceLoadedState(services: data??[]));
  }

  Future<void> _addEvent(ServiceAddEvent ev, Emitter<ServiceState> emit) async{ 
    emit(ServiceLoadingState());
    final profileBiz = await bizRepository.getProfileBiz();
    if (profileBiz==null){
      emit(ServiceMissingBizState());
      return;
    }
    final service = ev.service;
    final department = service.queueDepartment;
    service.profileBizId = profileBiz.id;
    dynamic data = await repository.saveService(service);
    if (data is ServerErrorModel) {
      emit(ServiceErrorState(error: data));
      return;
    } 
    if (department!=null){
      add(ServiceLoadByDepartmentEvent(department: department));
    }
  }

  Future<void> _updateEvent(ServiceUpdateEvent ev, Emitter<ServiceState> emit) async{ 
    emit(ServiceLoadingState());
    final service = ev.service;
    final department = service.queueDepartment;
    await repository.updateService(service);
    if (department!=null) {
      add(ServiceLoadByDepartmentEvent(department: department));
    }
  }

  Future<void> _removeEvent(ServiceRemoveEvent ev, Emitter<ServiceState> emit) async{ 
    emit(ServiceLoadingState());
    final service = ev.service;
    final department = service.queueDepartment;
    final data = await repository.deleteService(service);
    final error = ServerErrorModel.fromMap(data);
    if (error.data!=null) {
      emit(ServiceErrorState(error: error));
      return;
    } 
    if (department!=null){
      add(ServiceLoadByDepartmentEvent(department: department));
    }
  }

  Future<void> _searchEvent(ServiceSearchEvent ev, Emitter<ServiceState> emit) async{ 

  }
}
