import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qds_button/button.dart';
import 'package:qds_foundation/foundation.dart';
import 'package:qds_popup/src/type/popup_button_type.dart';
import 'package:qds_popup/src/type/popup_image_type.dart';
import 'package:qds_popup/src/wippy_popup_ui_state.dart';

class WippyPopup extends StatelessWidget {
  static const double _insetPaddingSize = 40;
  static const double _radiusSize = 16;

  static const double _dialogHorizontalPaddingSize = 16;
  static const double _dialogBottomPaddingSize = 16;
  static const double _dialogTopPaddingSize = 32;
  static const double _dialogMaxWidth = 380;

  static const int _titleMaxLine = 2;

  late final WippyPopupUiState _uiState;
  late final Widget? _customContents;

  WippyPopup({required WippyPopupUiState uiState, Widget? customContents}) {
    _uiState = uiState;
    _customContents = customContents;
  }

  Widget _buildDialogContent() {
    final PopupImageType? imageType = _uiState.popupImageType;
    final String? description = _uiState.description;
    PopupButtonType? buttonType = _uiState.popupButtonType;

    Widget? imageWidget;
    Widget? buttonWidget;

    if (imageType != null) {
      switch (imageType) {
        case NetworkPopupImage():
          imageWidget = Image.network(imageType.imageUrl, width: double.infinity);
        case AssetPopupImage():
          imageWidget = SvgPicture.asset(imageType.assetName, width: double.infinity);
      }
    }

    if (buttonType != null) {
      switch (buttonType) {
        case SinglePopupButton():
          buttonWidget = Container(
            width: double.infinity,
            child: WippyBoxButton(
                onPressed: () {
                  buttonType.onPressed?.call();
                },
                initUiState: ButtonUiState(
                    buttonLabelType: ButtonLabelType.labelOnly(label: buttonType.label),
                    buttonColorType: ButtonColorType.primary(),
                    buttonSizeType: ButtonSizeType.large())),
          );

        case MultiPopupButton():
          buttonWidget = Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                    width: double.infinity,
                    child: WippyBoxButton(
                        onPressed: () {
                          buttonType.onPressedLeftButton?.call();
                        },
                        initUiState: ButtonUiState(
                            buttonLabelType: ButtonLabelType.labelOnly(label: buttonType.leftButtonLabel),
                            buttonColorType: ButtonColorType.tertiary(),
                            buttonSizeType: ButtonSizeType.large()))),
              ),
              SizedBox(width: 8),
              Flexible(
                flex: 1,
                child: Container(
                    width: double.infinity,
                    child: WippyBoxButton(
                        onPressed: () {
                          buttonType.onPressedRightButton?.call();
                        },
                        initUiState: ButtonUiState(
                            buttonLabelType: ButtonLabelType.labelOnly(label: buttonType.rightButtonLabel),
                            buttonColorType: ButtonColorType.primary(),
                            buttonSizeType: ButtonSizeType.large()))),
              )
            ],
          );
        case VerticalMultiPopupButton():
          buttonWidget = Column(
            children: [
              Container(
                width: double.infinity,
                child: WippyBoxButton(
                    onPressed: () {
                      buttonType.onPressedTopButton?.call();
                    },
                    initUiState: ButtonUiState(
                        buttonLabelType: ButtonLabelType.labelOnly(label: buttonType.topButtonLabel),
                        buttonColorType: ButtonColorType.primary(),
                        buttonSizeType: ButtonSizeType.large())),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: WippyBoxButton(
                    onPressed: () {
                      buttonType.onPressedBottomButton?.call();
                    },
                    initUiState: ButtonUiState(
                        buttonLabelType: ButtonLabelType.labelOnly(label: buttonType.bottomButtonLabel),
                        buttonColorType: ButtonColorType.tertiary(),
                        buttonSizeType: ButtonSizeType.large())),
              ),
            ],
          );
      }
    }

    return Container(
      constraints: BoxConstraints(maxWidth: _dialogMaxWidth),
      width: double.infinity,
      decoration: BoxDecoration(
        color: wippyWhite,
        borderRadius: BorderRadius.all(Radius.circular(_radiusSize)),
      ),
      padding: EdgeInsets.fromLTRB(_dialogHorizontalPaddingSize, _dialogTopPaddingSize, _dialogHorizontalPaddingSize, _dialogBottomPaddingSize),
      child: Column(
        children: [
          if (imageWidget != null)
            Column(
              children: [imageWidget, SizedBox(height: 16)],
            ),
          Text(
            _uiState.title,
            maxLines: _titleMaxLine,
            style: body18Bold.copyWith(color: wippyGray900),
            textAlign: TextAlign.center,
          ),
          if (description != null)
            Column(
              children: [
                SizedBox(height: 16),
                Text(
                  description,
                  style: body14Medium.copyWith(color: wippyGray600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          if (_customContents != null) _customContents,
          if (buttonWidget != null) Column(children: [SizedBox(height: 24), buttonWidget])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: _insetPaddingSize),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildDialogContent()],
      ),
    );
  }
}
