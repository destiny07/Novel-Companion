import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:project_lyca/blocs/blocs.dart';

class CameraView extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Function(InputImage, Offset) onTapWord;
  final bool enableTap;
  final CameraViewController? controller;
  final double width;
  // final double densityPixel;

  const CameraView({
    required this.cameras,
    required this.onTapWord,
    required this.width,
    // required this.densityPixel,
    this.enableTap = true,
    this.controller,
  });

  @override
  State<StatefulWidget> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  final textDetector = GoogleMlKit.vision.textDetector();
  late CameraController? _cameraController;
  late InputImage _inputImage;
  late bool _enableTap;

  @override
  void initState() {
    super.initState();

    var resolutionPreset =
        widget.width < 1080 ? ResolutionPreset.high : ResolutionPreset.veryHigh;

    // Camera Setup
    _cameraController =
        CameraController(widget.cameras.first, resolutionPreset);
    _cameraController?.initialize().then((_) async {
      if (!mounted) {
        return;
      }

      // Controller Setup
      _enableTap = widget.enableTap;
      final controller = widget.controller;
      if (controller != null) {
        controller.setEnableTap = _setEnableTap;
      }

      await _cameraController?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (_cameraController != null) {
      } else {
        _cameraController?.initialize().then((_) async {
          if (!mounted) {
            return;
          }

          // Controller Setup
          _enableTap = widget.enableTap;
          final controller = widget.controller;
          if (controller != null) {
            controller.setEnableTap = _setEnableTap;
          }

          await _cameraController?.startImageStream(_processCameraImage);
          setState(() {});
        });
      }
    }
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = widget.cameras[0];
    final imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.NV21;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    _inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController!.value.isInitialized) {
      return Container();
    }
    // final mediaSize = MediaQuery.of(context).size;
    // final scale =
    //     1 / (_cameraController!.value.aspectRatio * mediaSize.aspectRatio);
    // print('Preview Size: ${_cameraController!.value.previewSize}');
    // return ClipRect(
    //   clipper: MediaSizeClipper(mediaSize),
    //   child: Transform.scale(
    //     scale: scale,
    //     alignment: Alignment.topCenter,
    //     child: GestureDetector(
    //       child: CameraPreview(_cameraController!),
    //       onTapDown: _enableTap ? _onTap : null,
    //     ),
    //   ),
    // );
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          previous.isTorchOn != current.isTorchOn,
      listener: (context, state) async {
        if (state.isTorchOn) {
          await _cameraController?.setFlashMode(FlashMode.torch);
        } else {
          await _cameraController?.setFlashMode(FlashMode.off);
        }
      },
      // child: SizedBox(
      //   width: width,
      //   height: height,
      //   child: GestureDetector(
      //     child: CameraPreview(_cameraController!),
      //     onTapDown: _enableTap ? _onTap : null,
      //   ),
      // ),
      child: GestureDetector(
        child: CameraPreview(_cameraController!),
        onTapDown: _enableTap ? _onTap : null,
      ),
    );
  }

  void _onTap(TapDownDetails details) async {
    // final RecognisedText recognisedText =
    //     await textDetector.processImage(_inputImage);

    // for (TextBlock block in recognisedText.blocks) {
    //   for (TextLine line in block.lines) {
    //     for (TextElement element in line.elements) {
    //       final densityPixel = MediaQuery.of(context).devicePixelRatio;
    //       final newOffset = Offset(details.localPosition.dx * densityPixel,
    //           details.localPosition.dy * densityPixel);
    //       final isOverlaps = element.rect.contains(newOffset);

    //       if (isOverlaps) {
    //         widget.onTapWord(element.text);
    //         return;
    //       }
    //     }
    //   }
    // }

    // widget.onTapWord('');
    // final newOffset = Offset(details.localPosition.dx * densityPixel,
    //     details.localPosition.dy * densityPixel);
    widget.onTapWord(_inputImage, details.localPosition);
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  // Controller Implementation
  void _setEnableTap(bool enable) {
    setState(() {
      _enableTap = enable;
    });
  }
}

class CameraViewController {
  Function(bool)? setEnableTap;
}
