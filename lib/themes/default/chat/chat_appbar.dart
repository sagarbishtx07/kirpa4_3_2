import 'package:kirpa/constants/assets.dart';
import 'package:kirpa/models/vendor/vendor.dart';
import 'package:kirpa/types/types.dart';
import 'package:kirpa/utils/utils.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget {
  final Vendor vendor;
  const ChatAppBar({Key? key, required this.vendor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: theme.dividerColor),
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(image: NetworkImage(vendor.banner ?? Assets.noImageUrl)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(vendor.storeName ?? '', style: theme.textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(translate('chat_detail_online'), style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}
