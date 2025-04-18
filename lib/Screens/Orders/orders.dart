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
          _controller.isDarkTheme.value ? blackColor : Colors.grey.shade100,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('My Orders'),
      centerTitle: true,
      elevation: 0,
      backgroundColor: _controller.isDarkTheme.value ? blackColor : whiteColor,
      foregroundColor: _controller.isDarkTheme.value ? whiteColor : blackColor,
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
        await _loadOrders(); // Actually reload the data
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(defaultPadding * 1.5),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: snapshot.orders!.length,
        itemBuilder: (context, index) => OrderCard(
          snapshot: snapshot,
          index: index,
          controller: _controller,
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
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Orders Yet',
            style: Style.largeLighttextStyle.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your order history will appear here',
            style: Style.smalltextStyle.copyWith(
              color: Colors.grey[500],
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

    return Card(
      color: controller.isDarkTheme.value ? blackColor : whiteColor,
      elevation: 1,
      margin: const EdgeInsets.only(bottom: defaultPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderHeader(order),
            const Divider(height: 24),
            _buildDeliveryAddress(order.address),
            const SizedBox(height: 6),
            _buildOrderItems(order),
            const Divider(height: 14),
            _buildOrderStatus(order.activeStatus),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHeader(Orders order) {
    final dateStr = order.orderdetails?[0].details?.createdAt?.split('T').first;
    final formattedDate = dateStr != null
        ? DateFormat('MMM dd, yyyy').format(DateTime.parse(dateStr))
        : 'Date not available';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order #${order.orderid}',
              style:
                  Style.mediumTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              formattedDate,
              style: Style.smalltextStyle.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.receipt_outlined),
          onPressed: () {
            // Implement invoice download
          },
          tooltip: 'Download Invoice',
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
}
