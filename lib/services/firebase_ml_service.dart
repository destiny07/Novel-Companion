import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:project_lyca/services/contracts/contracts.dart';

class FirebaseMlService implements IMlService {
  Future getTextFromImage(InputImage inputImage, Rect touchPointRect) async {
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText recognisedText =
        await textDetector.processImage(inputImage);

    String text = recognisedText.text;

    for (TextBlock block in recognisedText.blocks) {
      final Rect rect = block.rect;
      print(
          'left: ${rect.left}, top: ${rect.top}, right: ${rect.right}, bottom: ${rect.bottom}');
      var intersectionRect = rect.intersect(touchPointRect);
      var isIntersect =
          intersectionRect.height > 0 && intersectionRect.width > 0;
      final List<Offset> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
        }
      }
    }
  }
}
