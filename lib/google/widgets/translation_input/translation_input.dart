import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart' as intl;
import 'package:simplytranslate_mobile/generated/l10n.dart';
import '/google/widgets/translation_input/buttons/tts_input.dart';
import '/data.dart';
import 'buttons/camera/camera.dart';
import 'buttons/copy_button.dart';
import 'buttons/delete_button.dart';
import 'buttons/paste_button.dart';
import 'buttons/character_limit.dart';

class GoogleTranslationInput extends StatefulWidget {
  const GoogleTranslationInput({Key? key}) : super(key: key);

  @override
  _TranslationInputState createState() => _TranslationInputState();
}

class _TranslationInputState extends State<GoogleTranslationInput> {
  @override
  void initState() {
    googleInCtrl.addListener(() async {
      final tmp = googleInCtrl.selection;
      if (!tmp.isCollapsed && isFirst) {
        print('selection');
        googleInCtrl.selection = TextSelection.fromPosition(tmp.base);
        await Future.delayed(const Duration(milliseconds: 50));
        googleInCtrl.selection = tmp;
        isFirst = false;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    googleInCtrl.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    inTextFieldHeight = 10;
    for (var k in inList.keys)
      if (inList[k] == true) {
        if (k != "Counter")
          inTextFieldHeight += 48;
        else
          inTextFieldHeight += 50;
      }
    if (inTextFieldHeight < 100) inTextFieldHeight = 100;
    print("inTextFieldHeight " + inTextFieldHeight.toString());
    return Container(
      height: inTextFieldHeight,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: theme == Brightness.dark ? const Color(0xff131618) : null,
        border: Border.all(
          color: theme == Brightness.dark
              ? const Color(0xff495057)
              : lightThemeGreyColor,
          width: 1.5,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Scrollbar(
              child: TextField(
                onTap: () => isFirst = true,
                // selectionControls: _MyMaterialTextSelectionControls(),
                textDirection: googleInCtrl.text.length == 0
                    ? intl.Bidi.detectRtlDirectionality(
                        L10n.of(context).arabic,
                      )
                        ? TextDirection.rtl
                        : TextDirection.ltr
                    : intl.Bidi.detectRtlDirectionality(googleInCtrl.text)
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                focusNode: focus,
                minLines: 10,
                maxLines: null,
                controller: googleInCtrl,
                keyboardType: TextInputType.multiline,
                onChanged: (String input) {
                  if (googleInCtrl.text.length > 5000 && !isSnackBarVisible) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 2),
                        width: 300,
                        content: Text(
                          L10n.of(context).input_limit,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                    isSnackBarVisible = true;
                  } else if (isSnackBarVisible) isSnackBarVisible = false;
                  setStateOverlord(() {});
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: L10n.of(context).enter_text_here,
                  hintTextDirection:
                      intl.Bidi.detectRtlDirectionality(L10n.of(context).arabic)
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                ),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (inList['Remove'] == true) DeleteTranslationInputButton(),
              if (inList['Copy'] == true)
                CopyToClipboardButton(googleInCtrl.text),
              if (inList['Camera'] == true) Camera(),
              if (inList['Paste'] == true) PasteClipboardButton(),
              if (inList['Text-To-Speech'] == true) TtsInput(),
              if (inList['Counter'] == true) CharacterLimit(),
            ],
          )
        ],
      ),
    );
  }
}

// var _isVisible = true;

// class _MyMaterialTextSelectionControls extends MaterialTextSelectionControls {
//   // Padding between the toolbar and the anchor.
//   static const double _kToolbarContentDistanceBelow = 20.0;
//   static const double _kToolbarContentDistance = 8.0;

//   /// Builder for material-style copy/paste text selection toolbar.
//   @override
//   Widget buildToolbar(
//     BuildContext context,
//     Rect globalEditableRegion,
//     double textLineHeight,
//     Offset selectionMidpoint,
//     List<TextSelectionPoint> endpoints,
//     TextSelectionDelegate delegate,
//     ClipboardStatusNotifier clipboardStatus,
//     Offset? lastSecondaryTapDownPosition,
//   ) {
//     final TextSelectionPoint startSelectionPoint = endpoints[0];
//     final TextSelectionPoint endSelectionPoint =
//         endpoints.length > 1 ? endpoints[1] : endpoints[0];

//     final Offset anchorAbove = Offset(
//       globalEditableRegion.left + selectionMidpoint.dx,
//       globalEditableRegion.top +
//           startSelectionPoint.point.dy -
//           textLineHeight -
//           _kToolbarContentDistance,
//     );

//     final Offset anchorBelow = Offset(
//       globalEditableRegion.left + selectionMidpoint.dx,
//       globalEditableRegion.top +
//           endSelectionPoint.point.dy +
//           _kToolbarContentDistanceBelow,
//     );
//     _isVisible = () {
//       if (MediaQuery.of(context).orientation == Orientation.portrait) {
//         if (startSelectionPoint.point.dy < 20) return false;
//         if (startSelectionPoint.point.dy > inTextFieldHeight + 65) return false;
//       }
//       return true;
//     }();
//     return _MyTextSelectionToolbar(
//       anchorAbove: anchorAbove,
//       anchorBelow: anchorBelow,
//       clipboardStatus: clipboardStatus,
//       handleCopy: canCopy(delegate)
//           ? () => handleCopy(delegate, clipboardStatus)
//           : () {},
//       handleCut:
//           canCut(delegate) ? () => handleCut(delegate, clipboardStatus) : () {},
//       handlePaste: canPaste(delegate)
//           ? () async {
//               isFirst = true;
//               handlePaste(delegate);
//             }
//           : () {},
//       handleSelectAll:
//           canSelectAll(delegate) ? () => handleSelectAll(delegate) : null,
//     );
//   }
// }

// class _TextSelectionToolbarItemData {
//   const _TextSelectionToolbarItemData({
//     required this.label,
//     required this.onPressed,
//   });
//   final String label;
//   final VoidCallback onPressed;
// }

// class _MyTextSelectionToolbar extends StatefulWidget {
//   const _MyTextSelectionToolbar({
//     Key? key,
//     required this.anchorAbove,
//     required this.anchorBelow,
//     required this.clipboardStatus,
//     required this.handleCopy,
//     required this.handleCut,
//     required this.handlePaste,
//     required this.handleSelectAll,
//   }) : super(key: key);

//   final Offset anchorAbove;
//   final Offset anchorBelow;
//   final ClipboardStatusNotifier clipboardStatus;
//   final VoidCallback handleCopy;
//   final VoidCallback handleCut;
//   final VoidCallback handlePaste;
//   final VoidCallback? handleSelectAll;

//   @override
//   _MyTextSelectionToolbarState createState() => _MyTextSelectionToolbarState();
// }

// class _MyTextSelectionToolbarState extends State<_MyTextSelectionToolbar> {
//   void _onChangedClipboardStatus() {
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     widget.clipboardStatus.addListener(_onChangedClipboardStatus);
//     widget.clipboardStatus.update();
//   }

//   @override
//   void didUpdateWidget(_MyTextSelectionToolbar oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.clipboardStatus != oldWidget.clipboardStatus) {
//       widget.clipboardStatus.addListener(_onChangedClipboardStatus);
//       oldWidget.clipboardStatus.removeListener(_onChangedClipboardStatus);
//     }
//     widget.clipboardStatus.update();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     if (!widget.clipboardStatus.disposed) {
//       widget.clipboardStatus.removeListener(_onChangedClipboardStatus);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     assert(debugCheckHasMaterialLocalizations(context));
//     final MaterialLocalizations localizations =
//         MaterialLocalizations.of(context);

//     final List<_TextSelectionToolbarItemData> itemDatas =
//         <_TextSelectionToolbarItemData>[
//       _TextSelectionToolbarItemData(
//         label: localizations.cutButtonLabel,
//         onPressed: widget.handleCut,
//       ),
//       _TextSelectionToolbarItemData(
//         label: localizations.copyButtonLabel,
//         onPressed: widget.handleCopy,
//       ),
//       if (widget.clipboardStatus.value == ClipboardStatus.pasteable)
//         _TextSelectionToolbarItemData(
//           label: localizations.pasteButtonLabel,
//           onPressed: widget.handlePaste,
//         ),
//       if (widget.handleSelectAll != null)
//         _TextSelectionToolbarItemData(
//           label: localizations.selectAllButtonLabel,
//           onPressed: widget.handleSelectAll!,
//         ),
//     ];

//     int childIndex = 0;
//     return TextSelectionToolbar(
//       anchorAbove: widget.anchorAbove,
//       anchorBelow: widget.anchorBelow,
//       toolbarBuilder: (BuildContext context, Widget child) {
//         if (_isVisible)
//           return Container(
//             color: theme == Brightness.dark ? secondgreyColor : greenColor,
//             child: child,
//           );
//         return SizedBox.shrink();
//       },
//       children: itemDatas.map((_TextSelectionToolbarItemData itemData) {
//         return TextSelectionToolbarTextButton(
//           padding: TextSelectionToolbarTextButton.getPadding(
//               childIndex++, itemDatas.length),
//           onPressed: itemData.onPressed,
//           child: Text(itemData.label, style: TextStyle(color: Colors.white)),
//         );
//       }).toList(),
//     );
//   }
// }
