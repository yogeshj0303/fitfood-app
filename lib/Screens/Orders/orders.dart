import 'package:fit_food/Models/show_order_model.dart';
import 'package:fit_food/Models/cart_model.dart';
import 'package:fit_food/Components/cart_controller.dart';
import 'package:intl/intl.dart';
import '../../Constants/export.dart';
import 'package:fit_food/Screens/Orders/order_details_screen.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _controller = Get.put(GetController());
  final _cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    try {
      if (_controller.role.value == 'Trainer') {
        await _cartController.showTrainersOrders();
      } else {
        await _cartController.showOrders();
      }
    } catch (e) {
      _cartController.hasError.value = true;
      _cartController.error.value = e.toString();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load orders: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _controller.isDarkTheme.value ? Colors.grey[900] : Colors.white,
      appBar: _buildAppBar(),
      body: Container(
        decoration: BoxDecoration(
          color: _controller.isDarkTheme.value ? Colors.grey[900] : Colors.white,
        ),
        child: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'My Orders',
        style: TextStyle(
          color: _controller.isDarkTheme.value ? Colors.white : Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: _controller.isDarkTheme.value ? 0 : 1,
      backgroundColor: _controller.isDarkTheme.value ? Colors.grey[850] : Colors.white,
    );
  }

  Widget _buildBody() {
    return Obx(() {
      if (_cartController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final orders = _cartController.showOrderModel.value;
      if (_cartController.hasError.value) {
        return _buildErrorWidget();
      }

      if (orders?.data == null || orders!.data!.isEmpty) {
        return _buildEmptyOrderWidget();
      }

      return _buildOrdersList(orders);
    });
  }

  Widget _buildOrdersList(ShowOrderModel snapshot) {
    return RefreshIndicator(
      onRefresh: () async {
        await _loadOrders();
      },
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.only(bottom: defaultPadding),
            decoration: BoxDecoration(
              color: _controller.isDarkTheme.value ? Colors.grey[850] : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: _controller.isDarkTheme.value ? Colors.black12 : Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: OrderCard(
              orderData: snapshot.data![index],
              controller: _controller,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyOrderWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64,
            color: _controller.isDarkTheme.value ? Colors.grey[400] : Colors.grey[500],
          ),
          const SizedBox(height: 16),
          Text(
            'No Orders Yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: _controller.isDarkTheme.value ? Colors.white : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your order history will appear here',
            style: TextStyle(
              fontSize: 14,
              color: _controller.isDarkTheme.value ? Colors.white70 : Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: Style.mediumTextStyle.copyWith(
              color: Colors.red[600],
            ),
          ),
          TextButton(
            onPressed: () {
              Get.forceAppUpdate();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderData orderData;
  final GetController controller;

  const OrderCard({
    super.key,
    required this.orderData,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailsScreen(
                orderData: orderData,
                controller: controller,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOrderHeader(),
                Divider(
                  height: 24,
                  color: controller.isDarkTheme.value ? Colors.white24 : Colors.grey.shade200,
                ),
                _buildDeliveryAddress(),
                Divider(
                  height: 14,
                  color: controller.isDarkTheme.value ? Colors.white24 : Colors.grey.shade200,
                ),
                _buildOrderStatus(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order #${orderData.orderDetailId}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: controller.isDarkTheme.value ? Colors.white : Colors.black87,
              ),
            ),
            if (orderData.orderProducts?.isNotEmpty == true) ...[
              const SizedBox(height: 4),
              Text(
                orderData.orderProducts![0].orderDate ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: controller.isDarkTheme.value ? Colors.white70 : Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildDeliveryAddress() {
    if (orderData.address == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Address:',
          style: Style.mediumTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          '''${orderData.address?.address1 ?? ''},
${orderData.address?.locality ?? ''},
${orderData.address?.city ?? ''}, ${orderData.address?.state ?? ''},
${orderData.address?.pinCode ?? ''}''',
          style: Style.smalltextStyle.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildOrderStatus() {
    if (orderData.orderProducts == null || orderData.orderProducts!.isEmpty) {
      return const SizedBox.shrink();
    }

    // Get the status from the first order product
    final status = orderData.orderProducts![0].status;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Status:',
          style: Style.mediumTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _getStatusColor(status).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            status?.toUpperCase() ?? 'UNKNOWN',
            style: Style.mediumTextStyle.copyWith(
              color: _getStatusColor(status),
              fontWeight: FontWeight.w500,
            ),
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
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
