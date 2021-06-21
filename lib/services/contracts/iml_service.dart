import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

abstract class IMlService {
  Future getTextFromImage(InputImage inputImage, Rect point);
}
