import 'package:contacts_app/src/controller/auth_cubit/cubit/auth_repository.dart';
import 'package:contacts_app/src/core/network/api_response.dart';
import 'package:contacts_app/src/core/storage/storage_helper.dart';
import 'package:contacts_app/src/core/storage/storage_keys.dart';
// import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/user_requst_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthStateInitial());

  Future<void> login(String email, String password) async {
    emit(AuthStateLoading());

    AuthRepository authRepository = AuthRepository();

    try {
      ApiResponse apiResponse = await authRepository.login(email, password);
      if (apiResponse.Status == true) {
        await StorageHelper()
            .writeData(StorageKeys.userToken, apiResponse.token!);
        await StorageHelper()
            .writeData(StorageKeys.userId, apiResponse.data["_id"]);

        emit(AuthStateAuthenticated(email));
      } else {
        emit(AuthStateUnAuthenticated("Invalid Credentials"));
      }
    } catch (e) {
      emit(AuthStateUnAuthenticated("Authentication Error"));
    }
  }

  Future<void> signUp(UserRequestModel userRequestModel) async {
    emit(AuthStateLoading());
    AuthRepository authRepository = AuthRepository();

    try {
      ApiResponse apiResponse = await authRepository.signup(userRequestModel);
      if (apiResponse.Status) {
         StorageHelper().writeData(StorageKeys.userToken, apiResponse.token!);
         StorageHelper().writeData(StorageKeys.userId, apiResponse.data["_id"]);

        emit(AuthStateLoading());
      } else {
        emit(AuthStateUnAuthenticated(apiResponse.error!));
      }
    } catch (e) {
      emit(AuthStateAuthenticated("error"));
    }
  }
}
