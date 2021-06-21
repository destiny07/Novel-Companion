import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:project_lyca/blocs/blocs.dart';

class CameraView extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraView({required this.cameras});

  @override
  State<StatefulWidget> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _cameraController;
  late InputImage _inputImage;

  @override
  void initState() {
    super.initState();
    _cameraController =
        CameraController(widget.cameras.first, ResolutionPreset.max);
    _cameraController.initialize().then((_) async {
      if (!mounted) {
        return;
      }

      await _cameraController.startImageStream(_processCameraImage);
      setState(() {});
    });
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
    if (!_cameraController.value.isInitialized) {
      return Container();
    }
    return GestureDetector(
      child: CameraPreview(_cameraController),
      onTapDown: (details) async {
        var dips = MediaQuery.of(context).devicePixelRatio;
        
        BlocProvider.of<HomeBloc>(context).add(
          HomeTapText(
            _inputImage,
            details.localPosition.dx * dips,
            details.localPosition.dy * dips,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}
