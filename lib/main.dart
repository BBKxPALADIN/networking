import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './controllers/album_controller.dart';
import 'models/album.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final albumController = Get.put(AlbumController());

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: albumController.futureAlbum,
            builder: (context, controller) {
              if (controller.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(controller.data.title ?? 'Deleted'),
                    ElevatedButton(
                      child: const Text('Delete Data'),
                      onPressed: () {
                        albumController.futureAlbum = albumController
                            .deleteAlbum(controller.data.id.toString());
                      },
                    ),
                  ],
                );
              } else if (controller.hasError) {
                return Text('${controller.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
