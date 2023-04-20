import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/maangaatholi_controller.dart';

class MaangaatholiView extends GetView<MaangaatholiController> {
  const MaangaatholiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaangaatholiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MaangaatholiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
