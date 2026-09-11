import 'package:kirpa/models/models.dart';
import 'package:kirpa/register_product_custom_widget.dart';
import 'package:kirpa/service/constants/endpoints.dart';
import 'package:kirpa/types/types.dart';
import 'package:kirpa/utils/utils.dart';
import 'package:flutter/material.dart';

class ProductCustomWidget extends StatelessWidget {
  final Product? product;
  final String type;
  final String dataJson;

  const ProductCustomWidget({super.key, this.product, required this.type, required this.dataJson});

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return registerProductCustomWidget(context, product, type, dataJson, translate, Endpoints.restUrl, Endpoints.consumerKey, Endpoints.consumerSecret);
  }
}