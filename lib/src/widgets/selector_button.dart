import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/src/models/country_model.dart';
import 'package:intl_phone_number_input/src/utils/selector_config.dart';
import 'package:intl_phone_number_input/src/utils/test/test_helper.dart';
import 'package:intl_phone_number_input/src/widgets/countries_search_list_widget.dart';
import 'package:intl_phone_number_input/src/widgets/input_widget.dart';
import 'package:intl_phone_number_input/src/widgets/item.dart';

/// [SelectorButton]
class SelectorButton extends StatelessWidget {
  final List<Country> countries;
  final Country? country;
  final SelectorConfig selectorConfig;
  final TextStyle? selectorTextStyle;
  final InputDecoration? searchBoxDecoration;
  final bool autoFocusSearchField;
  final String? locale;
  final bool isEnabled;
  final bool isScrollControlled;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Widget? dropdownIcon;
  final TextStyle? hintStyleForSearchBox;

  final ValueChanged<Country?> onCountryChanged;

  const SelectorButton({
    Key? key,
    required this.countries,
    required this.country,
    required this.selectorConfig,
    required this.selectorTextStyle,
    required this.searchBoxDecoration,
    required this.autoFocusSearchField,
    required this.locale,
    required this.onCountryChanged,
    required this.isEnabled,
    required this.isScrollControlled,
    this.suffixIcon,
    this.backgroundColor,
    this.borderColor,
    this.dropdownIcon,
    this.hintStyleForSearchBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return selectorConfig.selectorType == PhoneInputSelectorType.DROPDOWN
        ? countries.isNotEmpty && countries.length > 1
            ? DropdownButtonHideUnderline(
                child: Container(
                  decoration: BoxDecoration(
                    color: backgroundColor ?? Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: borderColor ?? Colors.transparent,
                    ),
                  ),
                  child: DropdownButton<Country>(
                    key: Key(TestHelper.DropdownButtonKeyValue),
                    padding: EdgeInsets.only(left: 12),
                    hint: Item(
                      country: country,
                      useEmoji: selectorConfig.useEmoji,
                      trailingSpace: selectorConfig.trailingSpace,
                      textStyle: selectorTextStyle,
                    ),
                    value: country,
                    items: mapCountryToDropdownItem(countries),
                    onChanged: isEnabled ? onCountryChanged : null,
                  ),
                ),
              )
            : Item(
                country: country,
                useEmoji: selectorConfig.useEmoji,
                trailingSpace: selectorConfig.trailingSpace,
                textStyle: selectorTextStyle,
              )
        : Container(
            color: backgroundColor ?? Colors.transparent,
            child: InkWell(
              key: Key(TestHelper.DropdownButtonKeyValue),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: borderColor ?? Colors.transparent,
                ),
              ),
              onTap: countries.isNotEmpty && countries.length > 1 && isEnabled
                  ? () async {
                      Country? selected;
                      if (selectorConfig.selectorType ==
                          PhoneInputSelectorType.BOTTOM_SHEET) {
                        selected = await showCountrySelectorBottomSheet(
                            context, countries);
                      } else {
                        selected =
                            await showCountrySelectorDialog(context, countries);
                      }

                      if (selected != null) {
                        onCountryChanged(selected);
                      }
                    }
                  : null,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 12, right: 10, top: 16, bottom: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Item(
                      country: country,
                      useEmoji: selectorConfig.useEmoji,
                      trailingSpace: selectorConfig.trailingSpace,
                      textStyle: selectorTextStyle,
                    ),
                    const SizedBox(width: 18),
                    dropdownIcon ??
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey,
                        ),
                  ],
                ),
              ),
            ),
          );
  }

  /// Converts the list [countries] to `DropdownMenuItem`
  List<DropdownMenuItem<Country>> mapCountryToDropdownItem(
      List<Country> countries) {
    return countries.map((country) {
      return DropdownMenuItem<Country>(
        value: country,
        child: Item(
          key: Key(TestHelper.countryItemKeyValue(country.alpha2Code)),
          country: country,
          useEmoji: selectorConfig.useEmoji,
          textStyle: selectorTextStyle,
          withCountryNames: false,
          trailingSpace: selectorConfig.trailingSpace,
        ),
      );
    }).toList();
  }

  /// shows a Dialog with list [countries] if the [PhoneInputSelectorType.DIALOG] is selected
  Future<Country?> showCountrySelectorDialog(
      BuildContext inheritedContext, List<Country> countries) {
    return showDialog(
      context: inheritedContext,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        content: Directionality(
          textDirection: Directionality.of(inheritedContext),
          child: Container(
            width: double.maxFinite,
            child: CountrySearchListWidget(
              countries,
              locale,
              suffixIcon,
              textStyle: selectorTextStyle ?? TextStyle(),
              searchBoxDecoration: searchBoxDecoration,
              showFlags: selectorConfig.showFlags,
              useEmoji: selectorConfig.useEmoji,
              autoFocus: autoFocusSearchField,
            ),
          ),
        ),
      ),
    );
  }

  /// shows a Dialog with list [countries] if the [PhoneInputSelectorType.BOTTOM_SHEET] is selected
  Future<Country?> showCountrySelectorBottomSheet(
      BuildContext inheritedContext, List<Country> countries) {
    return showModalBottomSheet(
      context: inheritedContext,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      useSafeArea: true,
      builder: (BuildContext context) {
        return Stack(children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: DraggableScrollableSheet(
              builder: (BuildContext context, ScrollController controller) {
                return Directionality(
                  textDirection: Directionality.of(inheritedContext),
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Theme.of(context).canvasColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    child: CountrySearchListWidget(
                      countries,
                      locale,
                      suffixIcon,
                      fillColorForDialog: backgroundColor,
                      borderColor: borderColor,
                      hintStyleForSearchBox: hintStyleForSearchBox,
                      textStyle: selectorTextStyle ?? TextStyle(),
                      searchBoxDecoration: searchBoxDecoration,
                      scrollController: controller,
                      showFlags: selectorConfig.showFlags,
                      useEmoji: selectorConfig.useEmoji,
                      autoFocus: autoFocusSearchField,
                    ),
                  ),
                );
              },
            ),
          ),
        ]);
      },
    );
  }
}
