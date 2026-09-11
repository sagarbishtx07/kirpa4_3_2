import 'package:kirpa/widgets/cirilla_text.dart';
import 'package:flutter/material.dart';

import 'package:kirpa/mixins/utility_mixin.dart';

import 'package:kirpa/widgets/widgets.dart';

class ProductExpiryDate extends StatelessWidget with Utility {
  //final Product? product;
  final String? pTitle;
  const ProductExpiryDate({Key? key, this.pTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CirillaText(pTitle);
  }
}
