import 'package:fit_food/Models/show_order_model.dart';
import '../../Constants/export.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderData orderData;
  final GetController controller;

  const OrderDetailsScreen({
    super.key,
    required this.orderData,
    required this.controller,
  });

  String _getImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return '';
    if (imagePath.startsWith('http')) return imagePath;
    return 'https://fitfood.stilld.in/admin/build/$imagePath';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.isDarkTheme.value ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: TextStyle(
            color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: controller.isDarkTheme.value ? Colors.grey[850] : Colors.white,
        iconTheme: IconThemeData(
          color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderHeader(),
            const SizedBox(height: 16),
            _buildDeliveryAddress(),
            const SizedBox(height: 16),
            _buildOrderStatus(),
            const SizedBox(height: 16),
            _buildOrderedItems(),
            const SizedBox(height: 16),
            _buildOrderSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHeader() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: controller.isDarkTheme.value ? Colors.grey[850] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_long,
                  color: primaryColor,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  'Order #${orderData.orderDetailId}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            if (orderData.orderProducts?.isNotEmpty == true) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: controller.isDarkTheme.value ? Colors.white70 : Colors.grey[600],
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Ordered on: ${orderData.orderProducts![0].orderDate ?? ''}',
                    style: TextStyle(
                      fontSize: 14,
                      color: controller.isDarkTheme.value ? Colors.white70 : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryAddress() {
    if (orderData.address == null) return const SizedBox.shrink();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: controller.isDarkTheme.value ? Colors.grey[850] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: primaryColor,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  'Delivery Address',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (orderData.address?.address1 != null && orderData.address!.address1!.isNotEmpty)
                    Text(
                      orderData.address!.address1!,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: controller.isDarkTheme.value ? Colors.white70 : Colors.grey[700],
                      ),
                    ),
                  const SizedBox(height: 2),
                  if (orderData.address?.locality != null && orderData.address!.locality!.isNotEmpty)
                    Text(
                      orderData.address!.locality!,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: controller.isDarkTheme.value ? Colors.white70 : Colors.grey[700],
                      ),
                    ),
                  const SizedBox(height: 2),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: orderData.address?.city ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: controller.isDarkTheme.value ? Colors.white70 : Colors.grey[700],
                          ),
                        ),
                        if ((orderData.address?.city?.isNotEmpty ?? false) && 
                            (orderData.address?.state?.isNotEmpty ?? false))
                          TextSpan(
                            text: ', ',
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: controller.isDarkTheme.value ? Colors.white70 : Colors.grey[700],
                            ),
                          ),
                        TextSpan(
                          text: orderData.address?.state ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: controller.isDarkTheme.value ? Colors.white70 : Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  if (orderData.address?.pinCode != null && orderData.address!.pinCode!.isNotEmpty)
                    Text(
                      orderData.address!.pinCode!,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: controller.isDarkTheme.value ? Colors.white70 : Colors.grey[700],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatus() {
    if (orderData.orderProducts == null || orderData.orderProducts!.isEmpty) {
      return const SizedBox.shrink();
    }

    final status = orderData.orderProducts![0].status;
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: controller.isDarkTheme.value ? Colors.grey[850] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_shipping_outlined,
                  color: primaryColor,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  'Order Status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: _getStatusColor(status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _getStatusColor(status),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getStatusIcon(status ?? ''),
                    color: _getStatusColor(status),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    status?.capitalize ?? 'Unknown',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(status),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Icons.check_circle_outline;
      case 'processing':
        return Icons.hourglass_empty;
      case 'shipped':
        return Icons.local_shipping_outlined;
      case 'delivered':
        return Icons.done_all;
      case 'cancelled':
        return Icons.cancel_outlined;
      default:
        return Icons.help_outline;
    }
  }

  Widget _buildOrderedItems() {
    if (orderData.orderProducts == null || orderData.orderProducts!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: controller.isDarkTheme.value ? Colors.grey[850] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  color: primaryColor,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  'Ordered Items',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orderData.orderProducts!.length,
              separatorBuilder: (context, index) => Divider(
                color: controller.isDarkTheme.value ? Colors.grey[700] : Colors.grey[200],
                height: 24,
              ),
              itemBuilder: (context, index) {
                final item = orderData.orderProducts![index];
                final imageUrl = _getImageUrl(item.products?.image);
                
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: controller.isDarkTheme.value ? Colors.grey[800] : Colors.grey[200],
                        ),
                        child: imageUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Shimmer.fromColors(
                                  baseColor: controller.isDarkTheme.value
                                      ? Colors.grey[800]!
                                      : Colors.grey[300]!,
                                  highlightColor: controller.isDarkTheme.value
                                      ? Colors.grey[700]!
                                      : Colors.grey[100]!,
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.white,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: controller.isDarkTheme.value
                                        ? Colors.grey[400]
                                        : Colors.grey[600],
                                  ),
                                ),
                              )
                            : Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: controller.isDarkTheme.value
                                      ? Colors.grey[400]
                                      : Colors.grey[600],
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.products?.subcategory ?? 'Unknown Item',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Qty: ${item.quantity}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '₹${item.price}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: controller.isDarkTheme.value
                                      ? primaryColor
                                      : primaryDarkColor,
                                ),
                              ),
                            ],
                          ),
                          if (item.products?.description != null &&
                              item.products!.description!.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              item.products!.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: controller.isDarkTheme.value
                                    ? Colors.white70
                                    : Colors.grey[600],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    if (orderData.orderProducts == null || orderData.orderProducts!.isEmpty) {
      return const SizedBox.shrink();
    }

    // Calculate total price from order items
    double itemsTotal = 0;
    for (var item in orderData.orderProducts!) {
      itemsTotal += double.tryParse(item.price ?? '0') ?? 0;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: controller.isDarkTheme.value ? Colors.grey[850] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.receipt_outlined,
                  color: primaryColor,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  'Order Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Show individual items and their prices
            ...orderData.orderProducts!.map((item) {
              final quantity = int.tryParse(item.quantity ?? '1') ?? 1;
              final pricePerItem = (double.tryParse(item.price ?? '0') ?? 0) / quantity;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${item.products?.subcategory ?? 'Item'} × $quantity',
                        style: TextStyle(
                          fontSize: 14,
                          color: controller.isDarkTheme.value ? Colors.white70 : Colors.grey[700],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '₹${item.price}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(),
            ),
            
            _buildSummaryRow(
              'Total Amount',
              '₹${itemsTotal.toStringAsFixed(2)}',
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: controller.isDarkTheme.value
                ? isBold ? Colors.white : Colors.white70
                : isBold ? Colors.black87 : Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: isBold
                ? controller.isDarkTheme.value
                    ? primaryColor
                    : primaryDarkColor
                : controller.isDarkTheme.value
                    ? Colors.white
                    : Colors.black87,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'confirmed':
        return Colors.blue;
      case 'processing':
        return Colors.orange;
      case 'shipped':
        return Colors.amber;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
} 