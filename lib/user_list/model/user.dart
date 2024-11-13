class User {
  final String title;
  final String body;

  const User({
    required this.title, //required artinya wajib diisi
    required this.body,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}
// factory itu apa? hampir sama dengan constructor tapi dia lebih custom dan bisa dikasih logic
