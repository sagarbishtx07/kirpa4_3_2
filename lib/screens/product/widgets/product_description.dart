import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:feather_icons/feather_icons.dart';

import 'package:kirpa/constants/constants.dart';
import 'package:kirpa/mixins/mixins.dart';
import 'package:kirpa/models/product/product.dart';
import 'package:kirpa/types/types.dart';
import 'package:kirpa/utils/app_localization.dart';
import 'package:kirpa/utils/convert_data.dart';
import 'package:kirpa/widgets/widgets.dart';

class ProductDescription extends StatelessWidget with TransitionMixin {
  final Product? product;
  final bool? expand;
  final String? align;
  final String pTitle;
  final String pDetails;

  const ProductDescription({Key? key,
    this.product,
    this.expand,
    this.align = 'left',
    this.pTitle = "",
    this.pDetails = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    if (expand!) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              pTitle,
              textAlign: ConvertData.toTextAlignDirection(align),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          buildContent(description: pDetails),
        ],
      );
    }
    return CirillaTile(
      title: Text(pTitle, style: theme.textTheme.titleSmall),
      isDivider: false,
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, _, __) => ProductDescriptionModal(
              description: product?.description,
              content: buildContent(description: pDetails),
            ),
            transitionsBuilder: slideTransition,
          ),
        );
      },
    );
  }

  buildContent({String? description}) {
    return CirillaHtml(html: description ?? '');
  }
}

class ProductDescriptionModal extends StatelessWidget with AppBarMixin, TransitionMixin {
  final String? description;
  final Widget? content;
  final String? pTitle;


  const ProductDescriptionModal({Key? key, this.description, this.content, this.pTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      TranslateType translate = AppLocalizations.of(context)!.translate;
      log("Content ${[content]} \nlayoutpadding $layoutPadding");

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(pTitle ?? ' ', style: Theme.of(context).textTheme.titleMedium),
          actions: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                FeatherIcons.x,
                size: 20.0,
              ),
            ),
          ],
        ),
        body: ListView(
          padding: paddingHorizontal.copyWith(bottom: layoutPadding),
          children: [
            if (content != null) content!,
          ], // Fallback to an empty list if content is null
        ),
      );
    } catch (e, stackTrace) {
      log("Error in build method: $e");
      log("StackTrace: $stackTrace");

      // You can show a fallback UI here in case of an error
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
          centerTitle: true,
        ),
        body: Center(
          child: Text("Something went wrong. Please try again later."),
        ),
      );
    }
  }

}
