// part of "user_list_cubit.dart";

import 'package:equatable/equatable.dart';
import 'package:flutter_application_3/user_list/user_list.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  const factory UserListState.initial() = UserListInitial;
  const factory UserListState.loading() = UserListLoading;
  const factory UserListState.success(List<User> users) = UserListSuccess;
  // melemparkan data user ketika succes
  const factory UserListState.error(String errorMessage) = UserListError;

// equatable adalah library tambahan untuk comparasi, jadi ketika ada dua objek yang dibuat berbarengan gunakan equatable
// ketika menggunakan equateble, gunakan override seperti code dibawah ini
// misalnya var a = user("fira")
// var b = user("fira")
// ketika di compile hasilnya akan false, walaupun isi dari var nya itu sama-sama fira
// tapi kalau kita pakai equatable, dia akan mengembalikan nilai true
  @override
  List<Object?> get props => [];
}

// membuat 4 class yaitu intial, loading, succes, dan error
class UserListInitial extends UserListState {
  const UserListInitial();
}

class UserListLoading extends UserListState {
  const UserListLoading();
}

class UserListSuccess extends UserListState {
  final List<User> users;

  const UserListSuccess(this.users);

  @override
  List<Object?> get props => [users];
}

class UserListError extends UserListState {
  final String errorMessage;

  const UserListError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
