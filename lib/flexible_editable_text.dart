import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toolkit/flutter_toolkit.dart';

part 'gesture_builder.dart';

class CustomCupertinoTextSelectionControls
    extends CupertinoTextSelectionControls {
  CustomCupertinoTextSelectionControls({
    required this.handleColor,
  });

  final Color? handleColor;

  @override
  Widget buildHandle(
    BuildContext context,
    TextSelectionHandleType type,
    double textLineHeight, [
    VoidCallback? onTap,
  ]) {
    final handleColor = this.handleColor;
    final child = super.buildHandle(context, type, textLineHeight, onTap);
    if (handleColor != null) {
      return ColorFiltered(
        colorFilter: ColorFilter.mode(handleColor, BlendMode.srcIn),
        child: child,
      );
    } else {
      return child;
    }
  }
}

class FlexibleEditableText extends InputBuilder {
  const FlexibleEditableText({
    super.key,
    this.textScaler,
    this.gestureDetectorBuilder,
    super.controller,
    super.focusNode,
    super.onChanged,
    super.onFocusChanged,
    this.enabled = true,
    this.cursorColor,
    this.textAlign = defaultTextAlign,
    bool? enableInteractiveSelection,
    this.onTapAlwaysCalled = defaultOnTapAlwaysCalled,
    this.readOnly = defaultReadOnly,
    this.undoController,
    this.showCursor,
    this.onTap,
    this.scrollBehavior,
    this.textInputAction,
    this.textCapitalization = defaultTextCapitalization,
    TextInputType? keyboardType,
    this.strutStyle,
    this.autofocus = defaultAutofocus,
    this.textDirection,
    this.obscuringCharacter = defaultObscuringCharacter,
    this.obscureText = defaultObscureText,
    this.maxLength,
    this.inputFormatters,
    this.maxLengthEnforcement,
    this.selectionControls,
    this.scrollController,
    this.cursorWidth,
    this.maxLines = defaultMaxLines,
    this.minLines,
    this.cursorRadius,
    this.cursorHeight,
    this.onAppPrivateCommand,
    this.onEditingComplete,
    this.onSubmitted,
    this.autocorrect,
    this.expands = defaultExpands,
    this.selectionHeightStyle,
    this.selectionWidthStyle,
    this.enableSuggestions = defaultEnableSuggestions,
    this.restorationId,
    this.stylusHandwritingEnabled = defaultStylusHandwritingEnabled,
    this.dragStartBehavior = defaultDragStartBehavior,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    this.canRequestFocus = defaultCanRequestFocus,
    this.cursorOpacityAnimates,
    this.selectAllOnFocus,
    this.autofillHints = defaultAutofillHints,
    this.keyboardAppearance,
    this.groupId = defaultGroupId,
    this.spellCheckConfiguration,
    this.enableIMEPersonalizedLearning = defaultEnableIMEPersonalizedLearning,
    this.clipBehavior = defaultClipBehaviour,
    this.mouseCursor,
    this.contentInsertionConfiguration,
    this.hintLocales,
    this.ignorePointers,
    this.magnifierConfiguration,
    this.onTapOutside,
    this.onTapUpOutside,
    this.selectionHandleColor,
    this.hintStyle,
    this.style,
    this.hintText,
    this.selectionColor,
    this.locale,
    this.textHeightBehavior,
    this.forceLine = defaultForceLine,
    this.selectionHitTestBehaviour,
    this.textWidthBasis = defaultTextWidthBasis,
    this.contextMenuBuilder = defaultContextMenuBuilder,
    this.scrollPhysics,
    this.overrideValue,
    this.debug = defaultDebug,
    this.unfocusOnTapOutside = defaultUnfocusOnTapOutside,
    this.scrollPadding = defaultScrollPadding,
  })  : assert(obscuringCharacter.length == 1),
        smartDashesType = smartDashesType ??
            (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
        smartQuotesType = smartQuotesType ??
            (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(
          !obscureText || maxLines == 1,
          'Obscured fields cannot be multiline.',
        ),
        assert(
          maxLength == null ||
              maxLength == TextField.noMaxLength ||
              maxLength > 0,
        ),
        assert(
          !identical(textInputAction, TextInputAction.newline) ||
              maxLines == 1 ||
              !identical(keyboardType, TextInputType.text),
          'Use keyboardType TextInputType.multiline when using TextInputAction.newline on a multiline TextField.',
        ),
        keyboardType = keyboardType ??
            (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        enableInteractiveSelection =
            enableInteractiveSelection ?? (!readOnly || !obscureText);

  static const defaultScrollPadding = EdgeInsets.all(20);

  static const defaultUnfocusOnTapOutside = true;

  static const defaultTextWidthBasis = TextWidthBasis.parent;

  static const defaultForceLine = true;

  static const defaultDebug = false;

  static const defaultClipBehaviour = Clip.hardEdge;

  static const defaultEnableIMEPersonalizedLearning = true;

  static const defaultGroupId = EditableText;

  static const defaultDragStartBehavior = DragStartBehavior.start;

  static const defaultStylusHandwritingEnabled =
      EditableText.defaultStylusHandwritingEnabled;

  static const defaultAutofocus = false;

  static const defaultObscuringCharacter = '•';

  static const Iterable<String> defaultAutofillHints = [];

  static const defaultCanRequestFocus = true;

  static const defaultEnableSuggestions = true;

  static const defaultExpands = false;

  static const defaultMaxLines = 1;

  static const defaultObscureText = false;

  static const defaultTextCapitalization = TextCapitalization.none;

  static const defaultReadOnly = false;

  static const defaultOnTapAlwaysCalled = false;

  static const defaultTextAlign = TextAlign.start;

  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final String? restorationId;
  final bool canRequestFocus;
  final bool autofocus;
  final bool enabled;
  final TextAlign textAlign;
  final bool enableInteractiveSelection;
  final bool onTapAlwaysCalled;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool? showCursor;
  final Color? selectionHandleColor;
  final UndoHistoryController? undoController;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final String obscuringCharacter;
  final bool obscureText;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final Object groupId;
  final TextSelectionControls? selectionControls;
  final ValueChanged<String>? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final ScrollController? scrollController;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final double? cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final MouseCursor? mouseCursor;
  final bool? autocorrect;
  final SmartDashesType smartDashesType;
  final SmartQuotesType smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final ui.BoxHeightStyle? selectionHeightStyle;
  final ui.BoxWidthStyle? selectionWidthStyle;
  final bool? cursorOpacityAnimates;
  final EdgeInsets scrollPadding;
  final Brightness? keyboardAppearance;
  final bool? selectAllOnFocus;
  final DragStartBehavior dragStartBehavior;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final Clip clipBehavior;
  final bool stylusHandwritingEnabled;
  final bool enableIMEPersonalizedLearning;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final List<Locale>? hintLocales;
  final bool? ignorePointers;
  final TapOutsideEvent? onTapOutside;
  final TapUpOutsideEvent? onTapUpOutside;
  final Color? selectionColor;
  final Color? cursorColor;
  final bool forceLine;
  final Locale? locale;
  final TextScaler? textScaler;
  final ScrollBehavior? scrollBehavior;
  final TextHeightBehavior? textHeightBehavior;
  final TextWidthBasis textWidthBasis;
  final HitTestBehavior? selectionHitTestBehaviour;
  final Widget Function(BuildContext context, Widget editableText)?
      gestureDetectorBuilder;
  final bool unfocusOnTapOutside;
  final bool debug;
  final String? overrideValue;

  bool get selectionEnabled => enableInteractiveSelection;

  static Widget defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    if (SystemContextMenu.isSupportedByField(editableTextState)) {
      return SystemContextMenu.editableText(
        editableTextState: editableTextState,
      );
    }
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  @override
  InputBuilderState<InputBuilder> createState() => _FlexibleEditableTextState();
}

class _FlexibleEditableTextState extends InputBuilderState<FlexibleEditableText>
    implements TextSelectionGestureDetectorBuilderDelegate, AutofillClient {
  late _FlexibleEditableTextGestureDetectorBuilder
      _selectionGestureDetectorBuilder;
  late final ValueNotifier<bool> _isEmpty;
  late final CustomLogger _logger = CustomLogger(
    owner: runtimeType.toString(),
    showLogs: widget.debug,
  );

  @override
  void initState() {
    super.initState();
    _selectionGestureDetectorBuilder =
        _FlexibleEditableTextGestureDetectorBuilder(
      state: this,
    );
    _isEmpty = ValueNotifier(controller.text.isEmpty);
  }

  @override
  void didChangeDependencies() {
    _updateCanRequest();
    super.didChangeDependencies();
  }

  void _updateCanRequest() {
    focusNode.canRequestFocus = _canRequestFocus;
  }

  void log(Object object) {
    _logger.log(object);
  }

  @override
  void onTextChanged(String value) {
    _isEmpty.value = value.isEmpty;
    super.onTextChanged(value);
  }

  @override
  void didUpdateWidget(covariant FlexibleEditableText oldWidget) {
    _updateCanRequest();
    if (focusNode.hasFocus &&
        widget.readOnly != oldWidget.readOnly &&
        enabled) {
      if (controller.selection.isCollapsed) {
        _showSelectionHandles = !widget.readOnly;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  bool get _canRequestFocus {
    final NavigationMode mode =
        MediaQuery.maybeNavigationModeOf(context) ?? NavigationMode.traditional;
    return switch (mode) {
      NavigationMode.traditional => widget.canRequestFocus && enabled,
      NavigationMode.directional => true,
    };
  }

  @override
  final GlobalKey<EditableTextState> editableTextKey =
      GlobalKey<EditableTextState>();

  @override
  late bool forcePressEnabled;

  bool get enabled => widget.enabled;

  bool get disabled => !enabled;

  @override
  bool get selectionEnabled => widget.selectionEnabled && enabled;

  bool _showSelectionHandles = false;

  EditableTextState? get _editableText => editableTextKey.currentState;

  @override
  void autofill(TextEditingValue newEditingValue) =>
      _editableText!.autofill(newEditingValue);

  @override
  String get autofillId => _editableText!.autofillId;

  @override
  TextInputConfiguration get textInputConfiguration {
    final List<String>? autofillHints = widget.autofillHints?.toList(
      growable: false,
    );
    final AutofillConfiguration autofillConfiguration = autofillHints != null
        ? AutofillConfiguration(
            uniqueIdentifier: autofillId,
            autofillHints: autofillHints,
            currentEditingValue: controller.value,
            hintText: widget.hintText,
          )
        : AutofillConfiguration.disabled;

    return _editableText!.textInputConfiguration.copyWith(
      autofillConfiguration: autofillConfiguration,
    );
  }

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    // When the text field is activated by something that doesn't trigger the
    // selection toolbar, we shouldn't show the handles either.
    if (!_selectionGestureDetectorBuilder.shouldShowSelectionToolbar ||
        !_selectionGestureDetectorBuilder.shouldShowSelectionHandles) {
      return false;
    }

    if (cause == SelectionChangedCause.keyboard) {
      return false;
    }

    if (widget.readOnly && controller.selection.isCollapsed) {
      return false;
    }

    if (!enabled) {
      return false;
    }

    if (cause == SelectionChangedCause.longPress ||
        cause == SelectionChangedCause.stylusHandwriting) {
      return true;
    }

    if (controller.text.isNotEmpty) {
      return true;
    }

    return false;
  }

  void _handleSelectionChanged(
    TextSelection selection,
    SelectionChangedCause? cause,
  ) {
    final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);
    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() {
        _showSelectionHandles = willShowSelectionHandles;
      });
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        if (cause == SelectionChangedCause.longPress) {
          _editableText?.bringIntoView(selection.extent);
        }
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        break;
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        if (cause == SelectionChangedCause.drag) {
          _editableText?.hideToolbar();
        }
    }
  }

  void _handleSelectionHandleTapped() {
    if (controller.selection.isCollapsed) {
      log('toggle toolbar');
      _editableText!.toggleToolbar();
    }
  }

  void _requestKeyboard() {
    log('request keyboard');
    _editableText?.requestKeyboard();
  }

  int get _currentLength => controller.value.text.characters.length;

  MaxLengthEnforcement get _effectiveMaxLengthEnforcement =>
      widget.maxLengthEnforcement ??
      LengthLimitingTextInputFormatter.getDefaultMaxLengthEnforcement(
        Theme.of(context).platform,
      );

  @override
  Widget build(BuildContext context) {
    VoidCallback? handleDidGainAccessibilityFocus;
    VoidCallback? handleDidLoseAccessibilityFocus;
    final overrideValue = widget.overrideValue;
    final hintText = widget.hintText;
    final style = widget.style ?? DefaultTextStyle.of(context).style;
    final List<TextInputFormatter> formatters = <TextInputFormatter>[
      ...?widget.inputFormatters,
      if (widget.maxLength != null)
        LengthLimitingTextInputFormatter(
          widget.maxLength,
          maxLengthEnforcement: _effectiveMaxLengthEnforcement,
        ),
    ];
    final cursorWidth = widget.cursorWidth ?? 2.0;
    final int? semanticsMaxValueLength;
    if (_effectiveMaxLengthEnforcement != MaxLengthEnforcement.none &&
        widget.maxLength != null &&
        widget.maxLength! > 0) {
      semanticsMaxValueLength = widget.maxLength;
    } else {
      semanticsMaxValueLength = null;
    }

    final theme = Theme.of(context);
    final platform = theme.platform;
    final primaryColor = theme.primaryColor;
    final selectionColor = widget.selectionColor ?? primaryColor;
    final cursorColor = widget.cursorColor ?? primaryColor;
    final Brightness keyboardAppearance =
        widget.keyboardAppearance ?? theme.brightness;
    var textSelectionControls = widget.selectionControls;
    Radius? cursorRadius = widget.cursorRadius;
    bool? cursorOpacityAnimates = widget.cursorOpacityAnimates;
    Offset? cursorOffset;
    final bool paintCursorAboveText;
    Color? autocorrectionTextRectColor;
    final SpellCheckConfiguration spellCheckConfiguration;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        spellCheckConfiguration =
            CupertinoTextField.inferIOSSpellCheckConfiguration(
          widget.spellCheckConfiguration,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        spellCheckConfiguration = TextField.inferAndroidSpellCheckConfiguration(
          widget.spellCheckConfiguration,
        );
    }

    switch (platform) {
      case TargetPlatform.iOS:
        forcePressEnabled = true;
        cursorOpacityAnimates ??= true;
        textSelectionControls ??= CustomCupertinoTextSelectionControls(
          handleColor: widget.selectionHandleColor,
        );
        cursorRadius ??= const Radius.circular(2.0);
        cursorOffset = Offset(
          iOSHorizontalOffset / MediaQuery.devicePixelRatioOf(context),
          0,
        );
        autocorrectionTextRectColor = selectionColor;
        paintCursorAboveText = true;
        break;
      case TargetPlatform.macOS:
        forcePressEnabled = false;
        cursorOpacityAnimates ??= false;
        textSelectionControls ??= cupertinoDesktopTextSelectionHandleControls;
        cursorRadius ??= const Radius.circular(2.0);
        cursorOffset = Offset(
          iOSHorizontalOffset / MediaQuery.devicePixelRatioOf(context),
          0,
        );
        paintCursorAboveText = true;
        handleDidGainAccessibilityFocus = () {
          // Automatically activate the TextField when it receives accessibility focus.
          if (!focusNode.hasFocus && focusNode.canRequestFocus) {
            focusNode.requestFocus();
          }
        };
        handleDidLoseAccessibilityFocus = () {
          focusNode.unfocus();
        };
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        forcePressEnabled = false;
        cursorOpacityAnimates ??= false;
        textSelectionControls ??= materialTextSelectionHandleControls;
        paintCursorAboveText = false;

        break;
      case TargetPlatform.linux:
        forcePressEnabled = false;
        cursorOpacityAnimates ??= false;
        textSelectionControls ??= desktopTextSelectionHandleControls;
        paintCursorAboveText = false;
        handleDidGainAccessibilityFocus = () {
          // Automatically activate the TextField when it receives accessibility focus.
          if (!focusNode.hasFocus && focusNode.canRequestFocus) {
            focusNode.requestFocus();
          }
        };
        handleDidLoseAccessibilityFocus = () {
          focusNode.unfocus();
        };
        break;
      case TargetPlatform.windows:
        forcePressEnabled = false;
        cursorOpacityAnimates ??= false;
        textSelectionControls ??= desktopTextSelectionHandleControls;
        paintCursorAboveText = false;
        handleDidGainAccessibilityFocus = () {
          // Automatically activate the TextField when it receives accessibility focus.
          if (!focusNode.hasFocus && focusNode.canRequestFocus) {
            focusNode.requestFocus();
          }
        };
        handleDidLoseAccessibilityFocus = () {
          focusNode.unfocus();
        };
        break;
    }
    final groupId = widget.groupId;

    Widget wrapGestureBuilder({
      required Widget child,
    }) {
      final gestureBuilder = widget.gestureDetectorBuilder;
      if (gestureBuilder != null) {
        return gestureBuilder(context, child);
      }
      return child;
    }

    return TapRegion(
      groupId: groupId,
      onTapOutside: (event) {
        focusNode.unfocus();
        widget.onTapOutside?.call(event);
      },
      onTapUpOutside: (event) {
        widget.onTapUpOutside?.call(event);
      },
      child: IgnorePointer(
        ignoring: widget.ignorePointers ?? disabled,
        child: _selectionGestureDetectorBuilder.buildGestureDetector(
          behavior: widget.selectionHitTestBehaviour,
          child: wrapGestureBuilder(
            child: ListenableBuilder(
              listenable: focusNode,
              builder: (context, child) {
                final hasFocus = focusNode.hasFocus;
                return ValueListenableBuilder(
                  valueListenable: _isEmpty,
                  builder: (context, isEmpty, child) {
                    return Stack(
                      children: [
                        if (hintText != null && isEmpty)
                          Positioned.fill(
                            child: Text(
                              hintText,
                              style: widget.hintStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: widget.textAlign,
                            ),
                          ),
                        Semantics(
                          enabled: enabled,
                          maxValueLength: semanticsMaxValueLength,
                          currentValueLength: _currentLength,
                          onTap: widget.readOnly
                              ? null
                              : () {
                                  if (!controller.selection.isValid) {
                                    controller.selection =
                                        TextSelection.collapsed(
                                      offset: controller.text.length,
                                    );
                                  }
                                  _requestKeyboard();
                                },
                          onDidGainAccessibilityFocus:
                              handleDidGainAccessibilityFocus,
                          onDidLoseAccessibilityFocus:
                              handleDidLoseAccessibilityFocus,
                          onFocus: enabled
                              ? () {
                                  log('on focus start');
                                  assert(
                                    focusNode.canRequestFocus,
                                    'Received SemanticsAction.focus from the engine. However, the FocusNode '
                                    'of this text field cannot gain focus. This likely indicates a bug. '
                                    'If this text field cannot be focused (e.g. because it is not '
                                    'enabled), then its corresponding semantics node must be configured '
                                    'such that the assistive technology cannot request focus on it.',
                                  );

                                  if (focusNode.canRequestFocus &&
                                      !focusNode.hasFocus) {
                                    log('request focus');
                                    focusNode.requestFocus();
                                  } else if (!widget.readOnly) {
                                    // If the platform requested focus, that means that previously the
                                    // platform believed that the text field did not have focus (even
                                    // though Flutter's widget system believed otherwise). This likely
                                    // means that the on-screen keyboard is hidden, or more generally,
                                    // there is no current editing session in this field. To correct
                                    // that, keyboard must be requested.
                                    //
                                    // A concrete scenario where this can happen is when the user
                                    // dismisses the keyboard on the web. The editing session is
                                    // closed by the engine, but the text field widget stays focused
                                    // in the framework.
                                    _requestKeyboard();
                                  }
                                }
                              : null,
                          child: overrideValue != null
                              ? Text(
                                  overrideValue,
                                  style: style,
                                  textHeightBehavior: widget.textHeightBehavior,
                                  textScaler: widget.textScaler,
                                  textAlign: widget.textAlign,
                                  locale: widget.locale,
                                  maxLines: widget.maxLines,
                                  textWidthBasis: widget.textWidthBasis,
                                  selectionColor: widget.selectionColor,
                                  strutStyle: widget.strutStyle,
                                  textDirection: widget.textDirection,
                                )
                              : EditableText(
                                  key: editableTextKey,
                                  readOnly: widget.readOnly || disabled,
                                  onSelectionChanged: _handleSelectionChanged,
                                  showCursor: widget.showCursor,
                                  showSelectionHandles: _showSelectionHandles,
                                  controller: controller,
                                  focusNode: focusNode,
                                  undoController: widget.undoController,
                                  keyboardType: widget.keyboardType,
                                  textInputAction: widget.textInputAction,
                                  textCapitalization: widget.textCapitalization,
                                  textAlign: widget.textAlign,
                                  style: style,
                                  cursorColor: cursorColor,
                                  strutStyle: widget.strutStyle,
                                  textDirection: widget.textDirection,
                                  autofocus: widget.autofocus,
                                  obscuringCharacter: widget.obscuringCharacter,
                                  obscureText: widget.obscureText,
                                  backgroundCursorColor: Colors.transparent,
                                  autocorrect: widget.autocorrect,
                                  smartDashesType: widget.smartDashesType,
                                  smartQuotesType: widget.smartQuotesType,
                                  enableSuggestions: widget.enableSuggestions,
                                  maxLines: widget.maxLines,
                                  minLines: widget.minLines,
                                  expands: widget.expands,
                                  selectionColor:
                                      hasFocus ? selectionColor : null,
                                  selectionControls: selectionEnabled
                                      ? textSelectionControls
                                      : null,
                                  onEditingComplete: widget.onEditingComplete ==
                                          null
                                      ? null
                                      : () => widget.onEditingComplete?.call(
                                            controller.text,
                                          ),
                                  // onTapOutside: widget.onTapOutside,
                                  // onTapUpOutside: widget.onTapUpOutside,
                                  forceLine: widget.forceLine,
                                  locale: widget.locale,
                                  onSubmitted: widget.onSubmitted,
                                  onAppPrivateCommand:
                                      widget.onAppPrivateCommand,
                                  groupId: groupId,
                                  onSelectionHandleTapped:
                                      _handleSelectionHandleTapped,
                                  inputFormatters: formatters,
                                  rendererIgnoresPointer: true,
                                  mouseCursor:
                                      widget.mouseCursor ?? MouseCursor.defer,
                                  cursorWidth: cursorWidth,
                                  cursorHeight: widget.cursorHeight,
                                  cursorRadius: cursorRadius,
                                  selectionHeightStyle:
                                      widget.selectionHeightStyle,
                                  selectionWidthStyle:
                                      widget.selectionWidthStyle,
                                  cursorOpacityAnimates:
                                      cursorOpacityAnimates ?? false,
                                  cursorOffset: cursorOffset,
                                  paintCursorAboveText: paintCursorAboveText,
                                  scrollPadding: widget.scrollPadding,
                                  keyboardAppearance: keyboardAppearance,
                                  enableInteractiveSelection:
                                      widget.enableInteractiveSelection,
                                  selectAllOnFocus: widget.selectAllOnFocus,
                                  dragStartBehavior: widget.dragStartBehavior,
                                  scrollController: widget.scrollController,
                                  scrollPhysics: widget.scrollPhysics,
                                  autofillHints: widget.autofillHints,
                                  autofillClient: this,
                                  autocorrectionTextRectColor:
                                      autocorrectionTextRectColor,
                                  clipBehavior: widget.clipBehavior,
                                  restorationId: widget.restorationId,
                                  stylusHandwritingEnabled:
                                      widget.stylusHandwritingEnabled,
                                  enableIMEPersonalizedLearning:
                                      widget.enableIMEPersonalizedLearning,
                                  contentInsertionConfiguration:
                                      widget.contentInsertionConfiguration,
                                  contextMenuBuilder: widget.contextMenuBuilder,
                                  spellCheckConfiguration:
                                      spellCheckConfiguration,
                                  magnifierConfiguration:
                                      widget.magnifierConfiguration ??
                                          TextMagnifier
                                              .adaptiveMagnifierConfiguration,
                                  hintLocales: widget.hintLocales,
                                  textScaler: widget.textScaler,
                                  scrollBehavior: widget.scrollBehavior,
                                  textHeightBehavior: widget.textHeightBehavior,
                                  textWidthBasis: widget.textWidthBasis,
                                ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
