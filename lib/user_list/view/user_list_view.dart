import 'package:flutter/material.dart';
import 'package:flutter_application_3/user_list/cubit/user_list_state.dart';
import 'package:flutter_application_3/user_list/user_list.dart';
import 'package:flutter_application_3/user_list/view/user_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Welcome, Feed App",
          style: TextStyle(color: Colors.white), // Teks putih
        ),
        backgroundColor: const Color.fromARGB(255, 9, 80, 89),
      ),
      body: BlocBuilder<UserListCubit, UserListState>(
        builder: (context, state) {
          if (state is UserListSuccess) {
            // Tampilan ketika data berhasil dimuat
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                var user = state.users[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 9, 80, 89),
                        radius: 24,
                        child: Text(
                          state.users[index].title
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Teks avatar putih
                          ),
                        ),
                      ),
                      title: Text(
                        state.users[index].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        state.users[index].body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        // Mendapatkan indeks pengguna yang dipilih
                        final selectedUser = state.users[index];
                        final currentIndex = index;

                        // Navigasi ke halaman detail
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UserDetailPage(
                              user: selectedUser,
                              userList: state.users,
                              currentIndex: currentIndex,
                            ),
                          ),
                        );
                      },
                      onLongPress: () {
                        // Menampilkan modal konfirmasi sebelum menghapus
                        _showConfirmationDialog(context, user);
                      }),
                );
              },
            );
          } else if (state is UserListError) {
            // Tampilan ketika terjadi error
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.redAccent,
                  action: SnackBarAction(
                    label: 'Retry',
                    textColor: Colors.white,
                    onPressed: () => context.read<UserListCubit>().fetchUser(),
                  ),
                ),
              );
            });
            return _buildErrorView(context, "Unable to load users");
          } else if (state is UserListLoading) {
            // Tampilan ketika data sedang dimuat
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 9, 80, 89),
              ),
            );
          } else {
            // Tampilan awal atau keadaan tidak ada data
            return _buildInitialView(context);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 9, 80, 89),
        child: const Icon(
          Icons.refresh,
          color: Colors.white, // Ikon putih
        ),
        onPressed: () => context.read<UserListCubit>().fetchUser(),
      ),
    );
  }

  // Tampilan awal saat belum ada data yang dimuat
  Widget _buildInitialView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Menambahkan animasi Lottie di atas tombol load data
          Lottie.network(
            'assets/loading_animation.json',
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.download,
              color: Colors.white, // Ikon putih
            ),
            label: const Text(
              "Load Data",
              style: TextStyle(color: Colors.white), // Teks putih
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 9, 80, 89),
            ),
            onPressed: () => context.read<UserListCubit>().fetchUser(),
          ),
        ],
      ),
    );
  }

  // Tampilan saat terjadi error
  Widget _buildErrorView(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.redAccent,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 16, color: Colors.redAccent),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white, // Ikon putih
            ),
            label: const Text(
              "Retry",
              style: TextStyle(color: Colors.white), // Teks putih
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 9, 80, 89),
            ),
            onPressed: () => context.read<UserListCubit>().fetchUser(),
          ),
        ],
      ),
    );
  }

  // Menampilkan dialog konfirmasi untuk menghapus data
  void _showConfirmationDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to remove this user?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Menghapus data
                context.read<UserListCubit>().removeData(user);
                Navigator.of(context).pop(); // Menutup dialog
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }
}
