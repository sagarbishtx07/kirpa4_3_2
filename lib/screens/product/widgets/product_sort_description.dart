import 'package:kirpa/widgets/cirilla_html.dart';
import 'package:flutter/material.dart';

import 'package:kirpa/mixins/utility_mixin.dart';

import 'package:kirpa/models/product/product.dart';

class ProductSortDescription extends StatelessWidget with Utility {
  final Product? product;

  const ProductSortDescription({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CirillaHtml(html: product?.shortDescription ?? '');
  }
}
