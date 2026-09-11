import 'package:kirpa/mixins/mixins.dart';
import 'package:kirpa/models/models.dart';
import 'package:kirpa/screens/cart/cart_body.dart';
import 'package:kirpa/screens/screens.dart';
import 'package:kirpa/types/types.dart';
import 'package:kirpa/utils/utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ui/notification/notification_screen.dart';

import 'customer_view.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> with TransitionMixin {
  Customer? _customer;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    TextTheme textTheme = theme.textTheme;

    return Column(
      children: [
        CustomerView(
          customer: _customer,
          onChangeCustomer: (value) => setState(() {
            _customer = value;
          }),
        ),
        const Divider(height: 1, thickness: 1),
        Expanded(
          child: CartBody(
            emptyChild: NotificationScreen(
              title: Text(translate('cart_no_count'), style: textTheme.titleLarge),
              content: Text(
                translate('cart_is_currently_empty'),
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              iconData: FeatherIcons.shoppingCart,
              isButton: false,
            ),
            onBuilderButtonCheckout: (disable) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
                onPressed: disable
                    ? null
                    : () async {
                        await Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, _, __) => Checkout(
                              customer: _customer,
                              onClickButtonSuccess: () => Navigator.pop(context),
                              onSuccess: () => setState(() {
                                _customer = null;
                              }),
                            ),
                            transitionsBuilder: slideTransition,
                          ),
                        );
                      },
                child: Text(translate('cart_proceed_to_checkout')),
              );
            },
          ),
        ),
      ],
    );
  }
}
