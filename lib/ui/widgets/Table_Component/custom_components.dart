import 'package:facebilling/core/app_styles.dart';
import 'package:facebilling/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget customTableTextField({
  required BuildContext con,
  TextEditingController? controller,
  bool isNumeric = true,
  bool withoutMargin = false,
  IconData? icon,
  TextAlign textAlign = TextAlign.start,
  String placeHolder1 = "",
  String placeHolder2 = "",
  bool placeIconOutside = false,
  bool editable = true,
  bool doValidation = false,
  String value = "",
  String title = "",
  bool doubleControl = false,
  String title2 = "",
  TextEditingController? controller2,
  bool topLabel = false,
  bool removeLabel = false,
  Function(String)? onChange,
  Function()? onEditingComplete,
  Function()? onTap,
  Function()? onTap2,
}) {
  onChange = onChange ?? (u) {};
  onEditingComplete = onEditingComplete ?? () {};
  FocusNode focusNode = FocusNode();

  focusNode.addListener(() {
    if (!focusNode.hasFocus) {
      // When focus lost (editing completed)
      onEditingComplete?.call();
    }
  });

  return topLabel
      ? Column(
          children: [
            title.isNotEmpty && !removeLabel
                ? Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      title,
                      style: textStyle.copyWith(
                        fontSize: 14,
                        color: primary,
                      ),
                      textAlign: TextAlign.left,
                    ))
                : Container(),
            Row(
              children: [
                placeIconOutside
                    ? Row(
                        children: [
                          Icon(icon),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      )
                    : Container(),
                doubleControl
                    ? Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                focusNode: focusNode,
                                textAlignVertical: TextAlignVertical.center,
                                onChanged: onChange,
                                onEditingComplete: onEditingComplete,
                                onFieldSubmitted: (_) =>
                                    onEditingComplete?.call(),
                                enabled: editable,
                                controller: controller,
                                validator: (a) {
                                  if (a!.isEmpty) {
                                    return null;
                                  }
                                  return null;
                                },
                                decoration: boxBorderStyle.copyWith(
                                  prefixIcon: icon != null ? Icon(icon) : null,
                                  hintText: placeHolder1.isNotEmpty
                                      ? placeHolder1
                                      : "Enter the $title",
                                  hintStyle: normalGreyTextStyle,
                                ),
                                style: textStyle.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                textAlign: textAlign,
                                keyboardType: isNumeric
                                    ? TextInputType.number
                                    : TextInputType.text,
                                inputFormatters: isNumeric
                                    ? <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d*\.?\d{0,2}')),
                                      ]
                                    : [],
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                enabled: editable,
                                controller: controller2,
                                validator: (a) {
                                  if (a!.isEmpty) {
                                    return null;
                                  }
                                  return null;
                                },
                                decoration: boxBorderStyle.copyWith(
                                  prefixIcon: icon != null ? Icon(icon) : null,
                                  hintText: placeHolder2.isNotEmpty
                                      ? placeHolder2
                                      : "Enter the $title2",
                                  hintStyle: normalGreyTextStyle,
                                ),
                                style: textStyle.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                textAlign: textAlign,
                                inputFormatters: isNumeric
                                    ? <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d*\.?\d{0,2}')),
                                      ]
                                    : [],
                                keyboardType: isNumeric
                                    ? const TextInputType.numberWithOptions(
                                        decimal: true)
                                    : TextInputType.text,
                              ),
                            )
                          ],
                        ),
                      )
                    : Expanded(
                        flex: 4,
                        child: TextFormField(
                          focusNode: focusNode,
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: onChange,
                          onEditingComplete: onEditingComplete,
                          onFieldSubmitted: (_) => onEditingComplete?.call(),
                          //  initialValue: value,
                          enabled: editable,
                          controller: controller,

                          validator: (a) {
                            if (a!.isEmpty) {
                              return null;
                            }
                            return null;
                          },
                          decoration: boxBorderStyle.copyWith(
                            prefixIcon: icon != null ? Icon(icon) : null,
                            hintText: placeHolder1.isNotEmpty
                                ? placeHolder1
                                : "Enter the $title",
                            hintStyle: normalGreyTextStyle,
                          ),

                          style: textStyle.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),

                          textAlign: textAlign,

                          keyboardType: isNumeric
                              ? TextInputType.number
                              : TextInputType.text,
                          inputFormatters: isNumeric
                              ? <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d{0,2}')),
                                ]
                              : [],
                        ),
                      ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        )
      : Row(
          children: [
            title.isNotEmpty && !removeLabel
                ? Container(
                    alignment: Alignment.centerLeft,
                    width: 100,
                    child: Text(
                      title,
                      style: textStyle.copyWith(fontSize: 14, color: primary),
                    ))
                : Container(),
            placeIconOutside
                ? Row(
                    children: [
                      Icon(icon),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  )
                : Container(),
            withoutMargin
                ? Container()
                : const SizedBox(
                    width: 10,
                  ),
            doubleControl
                ? Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            focusNode: focusNode,
                            textAlignVertical: TextAlignVertical.center,
                            onChanged: onChange,
                            onEditingComplete: onEditingComplete,
                            onFieldSubmitted: (_) => onEditingComplete?.call(),
                            // initialValue: value,
                            enabled: editable,
                            controller: controller,

                            validator: (a) {
                              if (a!.isEmpty) {
                                return null;
                              }
                              return null;
                            },
                            decoration: boxBorderStyle.copyWith(
                              prefixIcon: icon != null ? Icon(icon) : null,
                              hintText: placeHolder1.isNotEmpty
                                  ? placeHolder1
                                  : "Enter the $title",
                              hintStyle: normalGreyTextStyle,
                            ),

                            style: textStyle.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w400),

                            textAlign: textAlign,

                            keyboardType: isNumeric
                                ? TextInputType.number
                                : TextInputType.text,
                            inputFormatters: isNumeric
                                ? <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d{0,2}')),
                                  ]
                                : [],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            focusNode: focusNode,
                            textAlignVertical: TextAlignVertical.center,
                            onChanged: onChange,
                            onEditingComplete: onEditingComplete,
                            onFieldSubmitted: (_) => onEditingComplete?.call(),
                            enabled: editable,
                            controller: controller2,
                            validator: (a) {
                              if (a!.isEmpty) {
                                return null;
                              }
                              return null;
                            },
                            decoration: boxBorderStyle.copyWith(
                              prefixIcon: icon != null ? Icon(icon) : null,
                              hintText: placeHolder2.isNotEmpty
                                  ? placeHolder2
                                  : "Enter the $title2",
                              hintStyle: normalGreyTextStyle,
                            ),
                            style: textStyle.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w400),
                            textAlign: textAlign,
                            keyboardType: isNumeric
                                ? TextInputType.number
                                : TextInputType.text,
                            inputFormatters: isNumeric
                                ? <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d{0,2}')),
                                  ]
                                : [],
                          ),
                        )
                      ],
                    ),
                  )
                : Expanded(
                    flex: 4,
                    child: TextFormField(
                      focusNode: focusNode,
                      textAlignVertical: TextAlignVertical.center,
                      //  initialValue: value,
                      onChanged: onChange,
                      onEditingComplete: onEditingComplete,
                      onFieldSubmitted: (_) => onEditingComplete?.call(),
                      enabled: editable,
                      controller: controller,

                      validator: (a) {
                        if (a!.isEmpty) {
                          return null;
                        }
                        return null;
                      },
                      decoration: boxBorderStyle.copyWith(
                        prefixIcon: icon != null ? Icon(icon) : null,
                        hintText: placeHolder1.isNotEmpty
                            ? placeHolder1
                            : "Enter the $title",
                        hintStyle: normalGreyTextStyle,
                      ),

                      style: textStyle.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w400),

                      textAlign: textAlign,

                      keyboardType:
                          isNumeric ? TextInputType.number : TextInputType.text,
                      inputFormatters: isNumeric
                          ? <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}')),
                            ]
                          : [],
                    ),
                  ),
            withoutMargin
                ? Container()
                : const SizedBox(
                    width: 10,
                  ),
          ],
        );
}
