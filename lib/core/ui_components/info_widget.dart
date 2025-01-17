import 'package:flutter/material.dart';
import 'package:together_for_you/core/functions/get_devicee_type.dart';
import 'package:together_for_you/core/models/device_info.dart';

class InfoWidget extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceInfo deviceInfo) builder;

  const InfoWidget({Key? key, required this.builder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        var mediaQueryData = MediaQuery.of(context);
        var deviceInfo = DeviceInfo(
          orientation: mediaQueryData.orientation,
          deviceType: getDeviceType(mediaQueryData),
          screenWidth: mediaQueryData.size.width,
          screenHeight: mediaQueryData.size.height,
          localHeight: constrains.maxHeight,
          localWidth: constrains.maxWidth,
        );
        return builder(context, deviceInfo);
      },
    );
  }
}
