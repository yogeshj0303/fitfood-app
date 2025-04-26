import 'package:fit_food/Components/cart_controller.dart';
import 'package:fit_food/Models/show_order_model.dart';
import 'package:intl/intl.dart';
import '../../Constants/export.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _controller = Get.put(GetController());

  final _cartController = Get.put(CartController());

  ShowOrderModel? orderModel;

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
      backgroundColor:
          _controller.isDarkTheme.value ? Colors.grey[900] : Colors.white,
      appBar: _buildAppBar(),
      body: Container(
        decoration: BoxDecoration(
          color:
              _controller.isDarkTheme.value ? Colors.grey[900] : Colors.white,
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
      backgroundColor:
          _controller.isDarkTheme.value ? Colors.grey[850] : Colors.white,
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

      if (orders?.orders == null || orders!.orders!.isEmpty) {
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
          itemCount: snapshot.orders!.length,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.only(bottom: defaultPadding),
            decoration: BoxDecoration(
              color: _controller.isDarkTheme.value
                  ? Colors.grey[850]
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: _controller.isDarkTheme.value
                      ? Colors.black12
                      : Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: OrderCard(
              snapshot: snapshot,
              index: index,
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
            color: _controller.isDarkTheme.value
                ? Colors.grey[400]
                : Colors.grey[500],
          ),
          const SizedBox(height: 16),
          Text(
            'No Orders Yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: _controller.isDarkTheme.value
                  ? Colors.white
                  : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your order history will appear here',
            style: TextStyle(
              fontSize: 14,
              color: _controller.isDarkTheme.value
                  ? Colors.white70
                  : Colors.grey[500],
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
  final ShowOrderModel snapshot;
  final int index;
  final GetController controller;

  const OrderCard({
    super.key,
    required this.snapshot,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final order = snapshot.orders?[index];
    if (order == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderHeader(order),
          Divider(
            height: 24,
            color: controller.isDarkTheme.value
                ? Colors.white24
                : Colors.grey.shade200,
          ),
          _buildDeliveryAddress(order.address),
          const SizedBox(height: 6),
          _buildOrderItems(order),
          Divider(
            height: 14,
            color: controller.isDarkTheme.value
                ? Colors.white24
                : Colors.grey.shade200,
          ),
          _buildOrderStatus(order.activeStatus),
        ],
      ),
    );
  }

  Widget _buildOrderHeader(Orders order) {
    String? formattedDate =
        _formatDate(order.orderdetails?[0].details?.createdAt);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order #${order.orderid}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: controller.isDarkTheme.value
                    ? Colors.white
                    : Colors.black87,
              ),
            ),
            if (formattedDate != null) ...[
              const SizedBox(height: 4),
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 14,
                  color: controller.isDarkTheme.value
                      ? Colors.white70
                      : Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildDeliveryAddress(Address? address) {
    if (address == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Address:',
          style: Style.mediumTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          '''${address.address1 ?? ''},
${address.locality ?? ''},
${address.city ?? ''}, ${address.state ?? ''},
${address.pinCode ?? ''}''',
          style: Style.smalltextStyle.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildOrderItems(Orders order) {
    if (order.orderdetails == null || order.orderdetails!.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: order.orderdetails?.length ?? 0,
      itemBuilder: (context, ind) {
        final item = order.orderdetails?[ind].details;
        if (item == null) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(top: defaultPadding),
          child: Row(
            children: [
              RoundedContainer(
                height: 100,
                width: 100,
                isImage: true,
                networkImg:
                    item.image != null ? '$imgPath/${item.image}' : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (item.subcategory ?? 'Unknown Item').toUpperCase(),
                      style: Style.mediumTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${item.price ?? 0}',
                      style: Style.mediumTextStyle.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Quantity: ${order.orderdetails?[ind].quantity ?? 0}',
                      style: Style.smalltextStyle.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOrderStatus(String? status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Status:',
          style: Style.mediumTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          status ?? 'Unknown',
          style: Style.mediumTextStyle.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }

  // Add this helper method to safely format the date
  String? _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return null;
    }

    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      print('Error parsing date: $dateString');
      return null;
    }
  }
}
