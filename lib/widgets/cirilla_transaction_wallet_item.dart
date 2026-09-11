import 'package:kirpa/types/types.dart';
import 'package:kirpa/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:kirpa/mixins/mixins.dart';
import 'package:kirpa/models/models.dart';
import 'package:ui/ui.dart';

class CirillaTransactionWalletItem extends StatelessWidget with TransactionWalletMixin {
  final TransactionWallet? item;

  CirillaTransactionWalletItem({
    Key? key,
    this.item,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return TransactionWalletContainedItem(
      title: buildName(data: item, theme: theme),
      amount: buildAmount(context, data: item, theme: theme),
      type: buildType(context, data: item, theme: theme, translate: translate),
      date: buildDate(data: item, theme: theme, translate: translate),
      color: theme.colorScheme.surface,
      onClick: () => {},
    );
  }
}
