import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart' as intl;
import '/data.dart';
import '/google/screens/maximized/maximized.dart';
import '/google/widgets/translation_input/widgets/copy_button.dart';
import 'widgets/tts_output.dart';

class GoogleTranslationOutput extends StatefulWidget {
  const GoogleTranslationOutput({Key? key}) : super(key: key);

  @override
  _TranslationOutputState createState() => _TranslationOutputState();
}

class _TranslationOutputState extends State<GoogleTranslationOutput> {
  double _outputFontSize = 20;

  @override
  Widget build(BuildContext context) {
    String translatedText = googleOutput;
    return Container(
      height: textFieldHeight,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Scrollbar(
                child: Directionality(
                  textDirection:
                      intl.Bidi.detectRtlDirectionality(translatedText)
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                  child: SelectableText(
                    translatedText,
                    selectionControls: _MyMaterialTextSelectionControls(),
                    style: TextStyle(fontSize: _outputFontSize),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              CopyToClipboardButton(translatedText),
              IconButton(
                icon: Icon(Icons.fullscreen),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: translatedText == ''
                    ? null
                    : () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MaximizedScreen())),
              ),
              IconButton(
                icon: Icon(Icons.add),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: translatedText == ''
                    ? null
                    : () => setState(() {
                          if (_outputFontSize + 3 <= 90) _outputFontSize += 3;
                        }),
              ),
              IconButton(
                icon: Icon(Icons.remove),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: translatedText == ''
                    ? null
                    : () => setState(() {
                          if (_outputFontSize - 3 >= 8) _outputFontSize -= 3;
                        }),
              ),
              TtsOutput(),
            ],
          ),
        ],
      ),
    );
  }
}

var _isVisible = true;

class _MyMaterialTextSelectionControls extends MaterialTextSelectionControls {
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
    final TextSelectionPoint startSelectionPoint = endpoints[0];
    final TextSelectionPoint endSelectionPoint =
        endpoints.length > 1 ? endpoints[1] : endpoints[0];
    final Offset anchorAbove = Offset(
      globalEditableRegion.left + selectionMidpoint.dx,
      globalEditableRegion.top +
          startSelectionPoint.point.dy -
          textLineHeight -
          _kToolbarContentDistance,
    );

    final Offset anchorBelow = Offset(
      globalEditableRegion.left + selectionMidpoint.dx,
      globalEditableRegion.top +
          endSelectionPoint.point.dy +
          _kToolbarContentDistanceBelow,
    );
    _isVisible = () {
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        if (startSelectionPoint.point.dy < 20) return false;
        if (startSelectionPoint.point.dy > textFieldHeight + 65) return false;
      }
      return true;
    }();

    return _MyTextSelectionToolbar(
      anchorAbove: anchorAbove,
      anchorBelow: anchorBelow,
      clipboardStatus: clipboardStatus,
      handleCopy: canCopy(delegate)
          ? () => handleCopy(delegate, clipboardStatus)
          : () {},
      handleSelectAll:
          canSelectAll(delegate) ? () => handleSelectAll(delegate) : null,
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

class _MyTextSelectionToolbar extends StatefulWidget {
  const _MyTextSelectionToolbar({
    Key? key,
    required this.anchorAbove,
    required this.anchorBelow,
    required this.clipboardStatus,
    required this.handleCopy,
    required this.handleSelectAll,
  }) : super(key: key);

  final Offset anchorAbove;
  final Offset anchorBelow;
  final ClipboardStatusNotifier clipboardStatus;
  final VoidCallback handleCopy;
  final VoidCallback? handleSelectAll;

  @override
  __MyTextSelectionToolbarState createState() =>
      __MyTextSelectionToolbarState();
}

class __MyTextSelectionToolbarState extends State<_MyTextSelectionToolbar> {
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
  void didUpdateWidget(_MyTextSelectionToolbar oldWidget) {
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
        label: localizations.copyButtonLabel,
        onPressed: widget.handleCopy,
      ),
      if (widget.handleSelectAll != null)
        _TextSelectionToolbarItemData(
          label: localizations.selectAllButtonLabel,
          onPressed: widget.handleSelectAll!,
        ),
    ];

    int childIndex = 0;
    return TextSelectionToolbar(
      anchorAbove: widget.anchorAbove,
      anchorBelow: widget.anchorBelow,
      toolbarBuilder: (BuildContext context, Widget child) {
        if (_isVisible)
          return Container(
            color: theme == Brightness.dark ? secondgreyColor : greenColor,
            child: child,
          );
        return SizedBox.shrink();
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
