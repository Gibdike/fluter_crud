import 'dart:convert' as convert;
import 'package:fluter_crud/models/user.dart';

import 'package:http/http.dart' as http;

class UserApi {
  static Future<List<User>> getUser() async {
    final String url = 'https://app-armario.firebaseio.com/users.json';
    var response = await http.get(url);
    print(response.body);
    String json = response.body;
    Map<String, dynamic> mapUsers = convert.json.decode(json);
    print("Tudo");
    print(mapUsers);
    print("Parte que eu quero");
    print(mapUsers.values);
    final user = new List<User>();
    print(mapUsers.length);

    for (int i = 0; i < mapUsers.length; i++) {
      print("Usuario $i");
      var mapUser = mapUsers.values.elementAt(i);
      print(mapUser.values.elementAt(1));
      User d = new User.fromJsogn(mapUsers, mapUser, i);
      user.add(d);
      print("Esse é o d");
      print(d);
      print("Esse é o d atributo name");
      print(d.name);
    }
    return user;
  }
}
/*try {
      final String _baseUrl = '${Constants.BASE_API_URL}/users';
      var response = await http.get(_baseUrl);
      String json = response.body;
      List list = convert.json.decode(json);
      final user = List<User>();
      for (Map map in list) {
        User c = User.fromJson(map);
        user.add(c);
      }
      return [];
    } catch (error) {
      print(error);
      return [];
    }
    
    final users = List<User>();
    await Future.delayed(Duration(seconds: 1));
    users.add(User(
      id: '1',
      name: 'Ernany',
      email: 'ernany@ifmt.cba.com',
      avatarUrl:
          'https://instagram.fcgb1-1.fna.fbcdn.net/v/t51.2885-15/e35/s1080x1080/118063984_168007518141648_5137414614789328208_n.jpg?_nc_ht=instagram.fcgb1-1.fna.fbcdn.net&_nc_cat=100&_nc_ohc=1bMipW8GYKwAX-BU0k1&_nc_tp=15&oh=160745796a10b1ad930bc08d65857d00&oe=5FBFDD64',
    ));
    users.add(User(
      id: '2',
      name: 'Angel',
      email: 'vitoria.angel2002@gmail.com',
      avatarUrl:
          'https://instagram.fcgb1-1.fna.fbcdn.net/v/t51.2885-15/e35/s1080x1080/118063984_168007518141648_5137414614789328208_n.jpg?_nc_ht=instagram.fcgb1-1.fna.fbcdn.net&_nc_cat=100&_nc_ohc=1bMipW8GYKwAX-BU0k1&_nc_tp=15&oh=160745796a10b1ad930bc08d65857d00&oe=5FBFDD64',
    ));
    */
