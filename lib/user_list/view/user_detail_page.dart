import 'package:flutter/material.dart';
import 'package:flutter_application_3/user_list/user_list.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage(
      {super.key,
      required this.user,
      required this.userList,
      required this.currentIndex});
  final User user;
  final List<User> userList;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("User Details", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 9, 80, 89),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: const Color.fromARGB(255, 9, 80, 89),
                child: Text(
                  user.title.substring(0, 2).toUpperCase(),
                  style: const TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                user.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 9, 80, 89),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.body,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol Prev
                  ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    label: const Text("Prev",
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 9, 80, 89),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                    ),
                    onPressed: () {
                      int prevIndex = currentIndex == 0
                          ? userList.length - 1
                          : currentIndex - 1;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserDetailPage(
                            user: userList[prevIndex],
                            userList: userList,
                            currentIndex: prevIndex,
                          ),
                        ),
                      );
                    },
                  ),
                  // Tombol Next
                  ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    label: const Text("Next",
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 9, 80, 89),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                    ),
                    onPressed: () {
                      int nextIndex = currentIndex == userList.length - 1
                          ? 0
                          : currentIndex + 1;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserDetailPage(
                            user: userList[nextIndex],
                            userList: userList,
                            currentIndex: nextIndex,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.delete, color: Colors.white),
                label:
                    const Text("Remove", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 24.0),
                ),
                onPressed: () {
                  // Menghapus user dari userList
                  userList.removeAt(currentIndex);
                  Navigator.pop(context,
                      userList); // Mengirim kembali userList yang telah diperbarui
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.home, color: Colors.white),
                label: const Text("Back to Main Menu",
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 9, 80, 89),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 24.0),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
