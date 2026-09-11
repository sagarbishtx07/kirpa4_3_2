import 'package:kirpa/mixins/mixins.dart';
import 'package:kirpa/screens/post/post.dart';
import 'package:kirpa/types/types.dart';
import 'package:kirpa/utils/utils.dart';
import 'package:kirpa/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:gutenberg_blocks/gutenberg_blocks.dart';
import 'package:kirpa/extension/strings.dart';

class RehubPostOfferbox extends StatelessWidget with Utility {
  final Map<String, dynamic>? block;

  const RehubPostOfferbox({Key? key, this.block}) : super(key: key);

  void goDetail(BuildContext context, dynamic postId) {
    Navigator.of(context).pushNamed('${PostScreen.routeName}/$postId');
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    Map? attrs = get(block, ['attrs'], {}) is Map ? get(block, ['attrs'], {}) : {};
    dynamic postId = get(attrs, ['selectedPost'], null);
    String? name = get(attrs, ['name'], '');
    String? image = get(attrs, ['thumbnail', 'url'], '');
    String? buttonText = get(attrs, ['button', 'text'], translate('post_detail_offerbox_button'));
    double? rating = ConvertData.stringToDouble(get(attrs, ['rating'], 0));
    if (postId == null) {
      return Container();
    }
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth;
        double screenWidth = MediaQuery.of(context).size.width;
        double width = maxWidth != double.infinity ? maxWidth : screenWidth;
        double widthImage = width;
        double heightImage = (widthImage * 200) / 335;
        return SizedBox(
          width: width,
          child: PostOfferBox(
            image: CirillaCacheImage(image, width: widthImage, height: heightImage),
            title: Text(
              name!,
              style: theme.textTheme.titleMedium,
            ),
            rating: rating > 0 ? CirillaRating(value: rating) : null,
            button: SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                child: Text(buttonText!.capitalizeFirstOfEach),
                onPressed: () => goDetail(context, postId),
              ),
            ),
          ),
        );
      },
    );
  }
}
