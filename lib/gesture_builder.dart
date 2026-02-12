part of 'flexible_editable_text.dart';

class _FlexibleEditableTextGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  _FlexibleEditableTextGestureDetectorBuilder({
    required _FlexibleEditableTextState state,
  }) : _state = state,
       super(delegate: state);

  final _FlexibleEditableTextState _state;

  @override
  bool get onUserTapAlwaysCalled => _state.widget.onTapAlwaysCalled;

  @override
  void onUserTap() {
    _state.widget.onTap?.call();
  }
}
