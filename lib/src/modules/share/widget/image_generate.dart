import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class ImageGeneration {
  static Future<void> generateImage(GlobalKey globalKey) async {
    RenderRepaintBoundary? boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    ui.Image? image = await boundary?.toImage();
    ByteData? byteData =
        await image?.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();

    final directory = (await getApplicationDocumentsDirectory()).path;
    File imgFile = File('$directory/photo.png');
    await imgFile.writeAsBytes(pngBytes!);

    // final files = <File>[];
    // files.add(File(imgFile.path));

    // await Share.shareXFiles(files, subject: 'Lista de Números');
    await Share.shareFiles([imgFile.path]);
  }
}
