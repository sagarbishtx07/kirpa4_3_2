import 'package:kirpa/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kirpa/extension/strings.dart';
import 'package:kirpa/constants/styles.dart';
import 'package:kirpa/mixins/mixins.dart';
import 'package:kirpa/store/store.dart';

import '../../../types/types.dart';
import '../../../utils/app_localization.dart';
import '../widgets/text_subtitle.dart';

class BlockItemList extends StatelessWidget with Utility, NavigationMixin {
  final List blocks;
  final List Function(List) getItems;
  final double pad;

  const BlockItemList({
    super.key,
    required this.blocks,
    required this.getItems,
    this.pad = 28,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SettingStore settingStore = Provider.of<SettingStore>(context);

    if (blocks.isEmpty) {
      return Container();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (_, int index) {
        dynamic block = blocks.elementAt(index);
        String title = get(block, ["data", "title", settingStore.languageKey], "");
        List items = getItems(get(block, ["data", "items"], []));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleSmall),
            const SizedBox(height: itemPadding),
            if (items.isNotEmpty)
              ...List.generate(items.length, (i) {
                dynamic item = items.elementAt(i);

                String titleItem = get(item, ["value", "title", settingStore.languageKey], "");
                String subtitleItem = get(item, ["value", "subTitle", settingStore.languageKey], "");
                Map iconItem = get(item, [
                  "value",
                  "icon"
                ], {
                  "name": "settings",
                  "type": "feather",
                });
                Map action = get(item, ["value", "action"], {});
                bool isChevron = get(item, ["value", "enableChevron"], true);
                TranslateType translate = AppLocalizations.of(context)!.translate;
                print("TitleItem $titleItem \n LanguageKey ${settingStore.languageKey}");

                if(titleItem == "App Settings"||titleItem=="App Einstellungen"||titleItem==""){
                  titleItem = translate("app_settings");
                }else if(titleItem == "Help & Info"){
                  titleItem = translate("help_info");
                }else if(titleItem == "Hotline"){
                  titleItem = translate("hotline");
                }
                else if(titleItem=="Abmelden"||titleItem=="Logout"){
                  titleItem = translate("sign_out");
                }else if(titleItem=="Mein Konto"||titleItem=="My Account"){
                  titleItem = translate("edit_account_my_account");
                }
                else if(titleItem=="Returning the order"||titleItem=="Rückgabe der Bestellung"){
                  titleItem = translate("order_return");
                }


                return CirillaTile(
                  title: Text(titleItem.unescape, style: theme.textTheme.titleSmall),
                  leading: Icon(
                    getIconData(data: iconItem),
                    size: 16,
                  ),
                  trailing: subtitleItem.isNotEmpty
                      ? TextSubtitle(text: subtitleItem.unescape, style: theme.textTheme.bodyMedium)
                      : null,
                  isChevron: isChevron,
                  onTap: () => navigate(context, Map.castFrom<dynamic, dynamic, String, dynamic>(action)),
                );
              }),
          ],
        );
      },
      separatorBuilder: (_, __) => SizedBox(height: pad),
      itemCount: blocks.length,
    );
  }
}
