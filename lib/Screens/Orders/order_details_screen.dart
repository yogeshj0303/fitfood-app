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
      backgroundColor: controller.isDarkTheme.value ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: TextStyle(
            color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: controller.isDarkTheme.value ? 0 : 1,
        backgroundColor: controller.isDarkTheme.value ? Colors.grey[850] : Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderHeader(),
            const SizedBox(height: 20),
            _buildDeliveryAddress(),
            const SizedBox(height: 20),
            _buildOrderStatus(),
            const SizedBox(height: 20),
            _buildOrderedItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHeader() {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: controller.isDarkTheme.value ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: controller.isDarkTheme.value ? Colors.black12 : Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order #${orderData.orderDetailId}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
            ),
          ),
          if (orderData.orderProducts?.isNotEmpty == true) ...[
            const SizedBox(height: 8),
            Text(
              'Ordered on: ${orderData.orderProducts![0].orderDate ?? ''}',
              style: TextStyle(
                fontSize: 14,
                color: controller.isDarkTheme.value ? Colors.white70 : Colors.grey[600],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDeliveryAddress() {
    if (orderData.address == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: controller.isDarkTheme.value ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: controller.isDarkTheme.value ? Colors.black12 : Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery Address',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '''${orderData.address?.address1 ?? ''}
${orderData.address?.locality ?? ''}
${orderData.address?.city ?? ''}, ${orderData.address?.state ?? ''}
${orderData.address?.pinCode ?? ''}''',
            style: TextStyle(
              fontSize: 14,
              color: controller.isDarkTheme.value ? Colors.white70 : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatus() {
    if (orderData.orderProducts == null || orderData.orderProducts!.isEmpty) {
      return const SizedBox.shrink();
    }

    final status = orderData.orderProducts![0].status;
    
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: controller.isDarkTheme.value ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: controller.isDarkTheme.value ? Colors.black12 : Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Order Status',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getStatusColor(status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status?.toUpperCase() ?? 'UNKNOWN',
              style: TextStyle(
                color: _getStatusColor(status),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderedItems() {
    if (orderData.orderProducts == null || orderData.orderProducts!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: controller.isDarkTheme.value ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: controller.isDarkTheme.value ? Colors.black12 : Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ordered Items',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orderData.orderProducts!.length,
            itemBuilder: (context, index) {
              final item = orderData.orderProducts![index];
              final imageUrl = _getImageUrl(item.products?.image);
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: controller.isDarkTheme.value ? Colors.grey[800] : Colors.grey[200],
                      ),
                      child: imageUrl.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: controller.isDarkTheme.value ? Colors.grey[400] : Colors.grey[600],
                                    ),
                                  );
                                },
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
                                          : null,
                                      strokeWidth: 2,
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: controller.isDarkTheme.value ? Colors.grey[400] : Colors.grey[600],
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
                              fontWeight: FontWeight.w500,
                              color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Quantity: ${item.quantity}',
                            style: TextStyle(
                              fontSize: 14,
                              color: controller.isDarkTheme.value ? Colors.white70 : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Price: ₹${item.price}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'confirmed':
        return Colors.blue;
      case 'processing':
        return Colors.orange;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
} 