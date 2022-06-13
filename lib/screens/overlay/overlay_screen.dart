// import 'package:flutter/material.dart';
// import 'package:system_alert_window/system_alert_window.dart';

// SystemWindowHeader header = SystemWindowHeader(
//   title: SystemWindowText(
//       text: "Incoming Call", fontSize: 10, textColor: Colors.black45),
//   padding: SystemWindowPadding.setSymmetricPadding(12, 12),
//   decoration: SystemWindowDecoration(startColor: Colors.grey[100]),
//   buttonPosition: ButtonPosition.TRAILING,
// );

// SystemWindowBody body = SystemWindowBody(
//   rows: [
//     EachRow(
//       columns: [
//         EachColumn(
//           text: SystemWindowText(
//             text: "Some body",
//             fontSize: 12,
//             textColor: Colors.black45,
//           ),
//         ),
//       ],
//       gravity: ContentGravity.CENTER,
//     ),
//   ],
//   padding: SystemWindowPadding(left: 16, right: 16, bottom: 12, top: 12),
// );
// SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;
// showSystemWindow() {
//   SystemAlertWindow.requestPermissions(prefMode: prefMode);

//   SystemAlertWindow.showSystemWindow(
//     height: 230,
//     header: header,
//     body: body,
//     margin: SystemWindowMargin(left: 8, right: 8, top: 100, bottom: 0),
//     gravity: SystemWindowGravity.TOP,
//     notificationTitle: "SimplyTranslate Mobile",
//     prefMode: SystemWindowPrefMode.OVERLAY,
//   );
//   //Using SystemWindowPrefMode.DEFAULT uses Overlay window till Android 10 and bubble in Android 11
//   //Using SystemWindowPrefMode.OVERLAY forces overlay window instead of bubble in Android 11.
//   //Using SystemWindowPrefMode.BUBBLE forces Bubble instead of overlay window in Android 10 & above
// }
