import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_3/user_list/cubit/user_list_state.dart';
import 'package:flutter_application_3/user_list/model/user.dart';

// part "user_list_state.dart";
class UserListCubit extends Cubit<UserListState> {
  List<User> _users = []; // Menyimpan daftar users

  UserListCubit() : super(const UserListState.initial());

  fetchUser() async {
    try {
      emit(const UserListState.loading());
      Dio dio = Dio();

      final res = await dio.get("https://jsonplaceholder.typicode.com/posts");

      if (res.statusCode == 200) {
        _users = res.data.map<User>((d) => User.fromJson(d)).toList();
        emit(UserListState.success(_users));
      } else {
        emit(UserListState.error("error loading data: ${res.data.toString()}"));
      }
    } catch (e) {
      emit(UserListState.error("error loading data: ${e.toString()}"));
    }
  }

  void removeData(User user) {
    if (state is UserListSuccess) {
      final currentState = state as UserListSuccess;
      final updatedUsers = List<User>.from(currentState.users)..remove(user);

      // Emit state baru dengan daftar pengguna yang sudah diperbarui
      emit(UserListState.success(updatedUsers));
    }
  }
}
