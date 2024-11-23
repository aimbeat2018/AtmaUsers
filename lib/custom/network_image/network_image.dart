import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PreviewNetworkImageUi extends StatelessWidget {
  final String image;
  const PreviewNetworkImageUi({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return (image != "")
        ? CachedNetworkImage(imageUrl: image, fit: BoxFit.cover)
        : FutureBuilder(
            future: _onCheckImage(image),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Offstage();
              } else if (snapshot.hasError) {
                return const Offstage();
              } else {
                if (snapshot.data == true) {
                  return CachedNetworkImage(imageUrl: image, fit: BoxFit.cover);
                } else {
                  return const Offstage();
                }
              }
            },
          );
  }
}

Future<bool> _onCheckImage(String image) async {
  try {
    final response = await http.head(Uri.parse(image));

    return response.statusCode == 200;
  } catch (e) {
    log('Check Profile Image Filed !! => $e');
    return false;
  }
}
