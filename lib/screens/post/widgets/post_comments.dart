import 'package:kirpa/models/models.dart';
import 'package:kirpa/service/helpers/request_helper.dart';
import 'package:kirpa/types/types.dart';
import 'package:kirpa/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../comments.dart';

class PostComments extends StatelessWidget {
  final Post? post;

  const PostComments({Key? key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(translate('comment_s'), style: theme.textTheme.titleMedium),
        const SizedBox(height: 32),
        Comments(
          post: post!.id,
          requestHelper: Provider.of<RequestHelper>(context),
          top: 0,
        )
      ],
    );
  }
}
