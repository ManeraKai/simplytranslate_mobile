import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '/google/widgets/translation_input/widgets/tts_input.dart';
import '/data.dart';
import 'widgets/copy_button.dart';
import 'widgets/delete_button.dart';
import 'widgets/paste_button.dart';
import 'widgets/character_limit.dart';

class GoogleTranslationInput extends StatefulWidget {
  const GoogleTranslationInput({Key? key}) : super(key: key);

  @override
  _TranslationInputState createState() => _TranslationInputState();
}

class _TranslationInputState extends State<GoogleTranslationInput> {
  @override
  void initState() {
    googleTranslationInputController.addListener(() async {
      final tmp = googleTranslationInputController.selection;

      if (!tmp.isCollapsed && isFirst) {
        print('selection');
        googleTranslationInputController.selection =
            TextSelection.fromPosition(tmp.base);
        await Future.delayed(Duration(milliseconds: 100));
        googleTranslationInputController.selection = tmp;
        isFirst = false;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    googleTranslationInputController.removeListener(() {});
    // _scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height / 3 < 250
              ? 250
              : MediaQuery.of(context).size.height / 3
          : 250,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: theme == Brightness.dark ? Color(0xff131618) : null,
        border: Border.all(
          color:
              theme == Brightness.dark ? Color(0xff495057) : Color(0xffa9a9a9),
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
                onTap: () {
                  isFirst = true;
                },
                selectionControls: MyMaterialTextSelectionControls(),
                textDirection: googleTranslationInputController.text.length == 0
                    ? intl.Bidi.detectRtlDirectionality(
                        AppLocalizations.of(context)!.arabic,
                      )
                        ? TextDirection.rtl
                        : TextDirection.ltr
                    : intl.Bidi.detectRtlDirectionality(
                            googleTranslationInputController.text)
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                focusNode: focus,
                minLines: 10,
                maxLines: null,
                controller: googleTranslationInputController,
                keyboardType: TextInputType.multiline,
                onChanged: (String input) {
                  if (googleTranslationInputController.text.length > 99999) {
                    final tmpSelection;
                    if (googleTranslationInputController.selection.baseOffset >=
                        100000) {
                      tmpSelection = TextSelection.collapsed(offset: 99999);
                    } else {
                      tmpSelection = TextSelection.collapsed(
                          offset: googleTranslationInputController
                              .selection.baseOffset);
                    }

                    googleTranslationInputController.text =
                        googleTranslationInputController.text
                            .substring(0, 99999);
                    print(tmpSelection.baseOffset);

                    googleTranslationInputController.selection = tmpSelection;
                  } else if (googleTranslationInputController.text.length >
                      5000) {
                    if (!isSnackBarVisible) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 1),
                          width: 300,
                          content: Text(
                            AppLocalizations.of(context)!.input_limit,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                      isSnackBarVisible = true;
                    }
                  } else {
                    if (isSnackBarVisible) isSnackBarVisible = false;
                  }
                  setStateOverlordData(() {});
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: AppLocalizations.of(context)!.enter_text_here,
                  hintTextDirection: intl.Bidi.detectRtlDirectionality(
                          AppLocalizations.of(context)!.arabic)
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
              DeleteTranslationInputButton(),
              CopyToClipboardButton(googleTranslationInputController.text),
              PasteClipboardButton(),
              TtsInput(),
              CharacterLimit(),
            ],
          )
        ],
      ),
    );
  }
}

class MyMaterialTextSelectionControls extends MaterialTextSelectionControls {
  // Padding between the toolbar and the anchor.
  static const double _kToolbarContentDistanceBelow = 20.0;
  static const double _kToolbarContentDistance = 8.0;

  /// Builder for material-style copy/paste text selection toolbar.
  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ClipboardStatusNotifier clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) {
    final TextSelectionPoint startTextSelectionPoint = endpoints[0];
    final TextSelectionPoint endTextSelectionPoint =
        endpoints.length > 1 ? endpoints[1] : endpoints[0];
    final Offset anchorAbove = () {
      if (startTextSelectionPoint.point.dy < 10 &&
          MediaQuery.of(context).orientation == Orientation.portrait) {
        return Offset(
          Offset(
            globalEditableRegion.left + selectionMidpoint.dx,
            globalEditableRegion.top +
                startTextSelectionPoint.point.dy -
                textLineHeight -
                _kToolbarContentDistance,
          ).dx,
          140,
        );
      } else if (startTextSelectionPoint.point.dy >
          70 + MediaQuery.of(context).size.height / 3) {
        return Offset(
          Offset(
            globalEditableRegion.left + selectionMidpoint.dx,
            globalEditableRegion.top +
                endTextSelectionPoint.point.dy +
                _kToolbarContentDistanceBelow,
          ).dx,
          200 + MediaQuery.of(context).size.height / 3,
        );
      } else {
        return Offset(
          globalEditableRegion.left + selectionMidpoint.dx,
          globalEditableRegion.top +
              startTextSelectionPoint.point.dy -
              textLineHeight -
              _kToolbarContentDistance,
        );
      }
    }();

    final Offset anchorBelow = Offset(
      globalEditableRegion.left + selectionMidpoint.dx,
      globalEditableRegion.top +
          endTextSelectionPoint.point.dy +
          _kToolbarContentDistanceBelow,
    );

    return MyTextSelectionToolbar(
      anchorAbove: anchorAbove,
      anchorBelow: anchorBelow,
      clipboardStatus: clipboardStatus,
      handleCopy: canCopy(delegate)
          ? () => handleCopy(delegate, clipboardStatus)
          : () {},
      handleCut: canCut(delegate) ? () => handleCut(delegate) : () {},
      handlePaste: canPaste(delegate) ? () => handlePaste(delegate) : () {},
      handleSelectAll:
          canSelectAll(delegate) ? () => handleSelectAll(delegate) : () {},
    );
  }
}

class _TextSelectionToolbarItemData {
  const _TextSelectionToolbarItemData({
    required this.label,
    required this.onPressed,
  });
  final String label;
  final VoidCallback onPressed;
}

class MyTextSelectionToolbar extends StatefulWidget {
  const MyTextSelectionToolbar({
    Key? key,
    required this.anchorAbove,
    required this.anchorBelow,
    required this.clipboardStatus,
    required this.handleCopy,
    required this.handleCut,
    required this.handlePaste,
    required this.handleSelectAll,
  }) : super(key: key);

  final Offset anchorAbove;
  final Offset anchorBelow;
  final ClipboardStatusNotifier clipboardStatus;
  final VoidCallback handleCopy;
  final VoidCallback handleCut;
  final VoidCallback handlePaste;
  final VoidCallback handleSelectAll;

  @override
  MyTextSelectionToolbarState createState() => MyTextSelectionToolbarState();
}

class MyTextSelectionToolbarState extends State<MyTextSelectionToolbar> {
  void _onChangedClipboardStatus() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.clipboardStatus.addListener(_onChangedClipboardStatus);
    widget.clipboardStatus.update();
  }

  @override
  void didUpdateWidget(MyTextSelectionToolbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.clipboardStatus != oldWidget.clipboardStatus) {
      widget.clipboardStatus.addListener(_onChangedClipboardStatus);
      oldWidget.clipboardStatus.removeListener(_onChangedClipboardStatus);
    }
    widget.clipboardStatus.update();
  }

  @override
  void dispose() {
    super.dispose();
    if (!widget.clipboardStatus.disposed) {
      widget.clipboardStatus.removeListener(_onChangedClipboardStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    final List<_TextSelectionToolbarItemData> itemDatas =
        <_TextSelectionToolbarItemData>[
      _TextSelectionToolbarItemData(
        label: localizations.cutButtonLabel,
        onPressed: widget.handleCut,
      ),
      _TextSelectionToolbarItemData(
        label: localizations.copyButtonLabel,
        onPressed: widget.handleCopy,
      ),
      if (widget.clipboardStatus.value == ClipboardStatus.pasteable)
        _TextSelectionToolbarItemData(
          label: localizations.pasteButtonLabel,
          onPressed: widget.handlePaste,
        ),
      _TextSelectionToolbarItemData(
        label: localizations.selectAllButtonLabel,
        onPressed: widget.handleSelectAll,
      ),
    ];

    int childIndex = 0;
    return TextSelectionToolbar(
      anchorAbove: widget.anchorAbove,
      anchorBelow: widget.anchorBelow,
      toolbarBuilder: (BuildContext context, Widget child) {
        return Container(
          color: theme == Brightness.dark ? secondgreyColor : greenColor,
          child: child,
        );
      },
      children: itemDatas.map((_TextSelectionToolbarItemData itemData) {
        return TextSelectionToolbarTextButton(
          padding: TextSelectionToolbarTextButton.getPadding(
              childIndex++, itemDatas.length),
          onPressed: itemData.onPressed,
          child: Text(
            itemData.label,
            style: TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
    );
  }
}
