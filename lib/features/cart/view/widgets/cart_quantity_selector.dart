import 'package:commerce_app/core/utils/widgets/toast/app_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'quantity_widget.dart';

class CartQuantitySelector extends StatefulWidget {
  final int count;
  final Function(int) onQuantityChanged;
  final bool isUpdating;

  const CartQuantitySelector({
    super.key,
    required this.count,
    required this.onQuantityChanged,
    this.isUpdating = false,
  });

  @override
  State<CartQuantitySelector> createState() => _CartQuantitySelectorState();
}

class _CartQuantitySelectorState extends State<CartQuantitySelector> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.count.toString());
  }

  @override
  void didUpdateWidget(CartQuantitySelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.count.toString() != _controller.text) {
      _controller.text = widget.count.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateQuantity(int newCount) {
    if (widget.isUpdating) return;
    if (newCount >= 1) {
      widget.onQuantityChanged(newCount);
    } else {
      widget.onQuantityChanged(1);
      AppToast.show(
        context,
        message: 'quantity_at_least_one'.tr(),
        type: ToastificationType.warning,
      );
    }
  }

  void _handleManualSubmit(String value) {
    final int? newCount = int.tryParse(value);
    if (newCount != null) {
      _updateQuantity(newCount);
    } else {
      _controller.text = widget.count.toString();
    }
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return QuantitySelect(
      count: widget.count,
      isUpdating: widget.isUpdating,
      controller: _controller,
      onIncrement: () => _updateQuantity(widget.count + 1),
      onDecrement: () => _updateQuantity(widget.count - 1),
      onSubmitted: _handleManualSubmit,
    );
  }
}
