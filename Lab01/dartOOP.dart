import 'dart:collection';

class Social {
  int id;
  String name;
  String url;

  int get getId => this.id;
  set setId(int id) => this.id = id;

  get getName => this.name;
  set setName(name) => this.name = name;

  get getUrl => this.url;
  set setUrl(url) => this.url = url;

  Social(this.id, this.name, this.url);

  // Named constructor for Social
  Social.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        url = map['url'];

  @override
  String toString() => 'Social{id: $id, name: $name, url: $url}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Social &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          url == other.url;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ url.hashCode;
}

class Student {
  int id;
  String name;
  int age;
  String email;
  List<Social> social;

  get getAge => this.age;
  set setAge(age) => this.age = age;

  get getEmail => this.email;
  set setEmail(email) => this.email = email;

  get getSocial => this.social;
  set setSocial(social) => this.social = social;

  // Concise constructor for Student
  Student(
      {required this.id,
      required this.name,
      required this.age,
      required this.email,
      required this.social});

  @override
  String toString() =>
      'Student{id: $id, name: $name, age: $age, email: $email, social: $social}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Student &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          age == other.age &&
          email == other.email;
  // DeepCollectionEquality().equals(social, other.social);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      age.hashCode ^
      email.hashCode ^
      social.hashCode;
}

void main() {
  Student std1 =
      Student(age: 18, name: 'Nhu', id: 7, email: 'djwo@gmail.com', social: []);
  print(std1);
}
