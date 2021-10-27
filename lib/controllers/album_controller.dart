import 'dart:io';
import 'package:get/get.dart';
import '../models/album.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class AlbumController extends GetxController{
  Future<Album> futureAlbum;

  @override
  void onInit() {
    super.onInit();
    futureAlbum=fetchAlbum();
  }


  Future<Album> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    headers: {
          HttpHeaders.authorizationHeader:'Basic your_api_token_here',
    });

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Album> deleteAlbum(String id) async {
    final response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if(response.statusCode==200){
      return Album.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to delete album');
    }
  }

}