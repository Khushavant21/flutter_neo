import 'package:flutter/material.dart';

class Product {
  int id;
  String name;
  String type;
  String price;
  String returnsText;
  String risk;
  bool enabled;
  String status; // "approved" or "pending"

  Product({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.returnsText,
    required this.risk,
    required this.enabled,
    required this.status,
  });

  Product copyWith({
    int? id,
    String? name,
    String? type,
    String? price,
    String? returnsText,
    String? risk,
    bool? enabled,
    String? status,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      price: price ?? this.price,
      returnsText: returnsText ?? this.returnsText,
      risk: risk ?? this.risk,
      enabled: enabled ?? this.enabled,
      status: status ?? this.status,
    );
  }
}

class ProductCatalogScreen extends StatefulWidget {
  const ProductCatalogScreen({Key? key}) : super(key: key);

  @override
  State<ProductCatalogScreen> createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  late List<Product> products;
  late List<Product> requests;

  final Map<String, String> productImages = {
    'Mutual Fund':
        'https://images.pexels.com/photos/8437000/pexels-photo-8437000.jpeg?auto=compress&cs=tinysrgb&w=800',
    'Bank FD':
        'https://images.pexels.com/photos/843700/pexels-photo-843700.jpeg?auto=compress&cs=tinysrgb&w=800',
    'Exchange Traded Fund':
        'https://images.pexels.com/photos/5980742/pexels-photo-5980742.jpeg?auto=compress&cs=tinysrgb&w=800',
    'Stock':
        'https://images.pexels.com/photos/5716004/pexels-photo-5716004.jpeg?auto=compress&cs=tinysrgb&w=800',
  };

  final List<String> typeOptions = [
    'Mutual Fund',
    'Bank FD',
    'Exchange Traded Fund',
    'Stock',
  ];
  final List<String> riskOptions = ['Low Risk', 'Medium Risk', 'High Risk'];

  @override
  void initState() {
    super.initState();
    products = [
      Product(
        id: 1,
        name: 'Equity Mutual Fund',
        type: 'Mutual Fund',
        price: '₹5,000',
        returnsText: '12-15% annually',
        risk: 'High Risk',
        enabled: true,
        status: 'approved',
      ),
      Product(
        id: 2,
        name: 'Fixed Deposit',
        type: 'Bank FD',
        price: '₹1,000',
        returnsText: '6-7% annually',
        risk: 'Low Risk',
        enabled: true,
        status: 'approved',
      ),
    ];

    requests = [
      Product(
        id: 101,
        name: 'Gold ETF',
        type: 'Exchange Traded Fund',
        price: '₹2,000',
        returnsText: '8-10% annually',
        risk: 'Medium Risk',
        enabled: true,
        status: 'pending',
      ),
      Product(
        id: 102,
        name: 'Bluechip Stocks',
        type: 'Stock',
        price: '₹10,000',
        returnsText: '15% annually',
        risk: 'High Risk',
        enabled: true,
        status: 'pending',
      ),
    ];
  }

  Color riskColor(String risk) {
    switch (risk) {
      case 'High Risk':
        return Colors.red.shade700;
      case 'Medium Risk':
        return Colors.amber.shade700;
      case 'Low Risk':
        return Colors.green.shade600;
      default:
        return Colors.grey;
    }
  }

  void _showAddEditBottomSheet({Product? product}) {
    final isEdit = product != null;

    final nameController = TextEditingController(text: product?.name ?? '');
    String selectedType = product?.type ?? 'Mutual Fund';
    final priceController = TextEditingController(text: product?.price ?? '');
    final returnsController = TextEditingController(
      text: product?.returnsText ?? '',
    );
    String selectedRisk = product?.risk ?? 'Low Risk';
    bool enabled = product?.enabled ?? true;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isEdit ? 'Edit Product' : 'Add Product',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    Text(
                      'Product Name',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 6),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter product name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),

                    Text('Type', style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(height: 6),
                    InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 2,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedType,
                          items: typeOptions
                              .map(
                                (t) =>
                                    DropdownMenuItem(value: t, child: Text(t)),
                              )
                              .toList(),
                          onChanged: (v) => setState(() {
                            selectedType = v ?? selectedType;
                          }),
                        ),
                      ),
                    ),

                    SizedBox(height: 12),

                    Text(
                      'Price / Minimum Investment',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 6),
                    TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                        hintText: 'e.g., ₹5,000',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),

                    SizedBox(height: 12),

                    Text(
                      'Expected Returns',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 6),
                    TextField(
                      controller: returnsController,
                      decoration: InputDecoration(
                        hintText: 'e.g., 12-15% annually',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),

                    SizedBox(height: 12),

                    Text('Risk', style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(height: 6),
                    InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 2,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedRisk,
                          items: riskOptions
                              .map(
                                (r) =>
                                    DropdownMenuItem(value: r, child: Text(r)),
                              )
                              .toList(),
                          onChanged: (v) => setState(() {
                            selectedRisk = v ?? selectedRisk;
                          }),
                        ),
                      ),
                    ),

                    SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Enable Product',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Switch(
                          value: enabled,
                          onChanged: (v) => setState(() {
                            enabled = v;
                          }),
                        ),
                      ],
                    ),

                    SizedBox(height: 18),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Cancel'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            final name = nameController.text.trim();
                            final price = priceController.text.trim();
                            final returnsText = returnsController.text.trim();

                            if (name.isEmpty ||
                                price.isEmpty ||
                                returnsText.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please fill all fields'),
                                ),
                              );
                              return;
                            }

                            if (isEdit) {
                              setState(() {
                                products = products.map((p) {
                                  if (p.id == product.id) {
                                    return p.copyWith(
                                      name: name,
                                      type: selectedType,
                                      price: price,
                                      returnsText: returnsText,
                                      risk: selectedRisk,
                                      enabled: enabled,
                                    );
                                  }
                                  return p;
                                }).toList();
                              });
                            } else {
                              final newProduct = Product(
                                id: DateTime.now().millisecondsSinceEpoch,
                                name: name,
                                type: selectedType,
                                price: price,
                                returnsText: returnsText,
                                risk: selectedRisk,
                                enabled: enabled,
                                status: 'approved',
                              );
                              setState(() {
                                products.add(newProduct);
                              });
                            }

                            Navigator.of(context).pop();
                          },
                          child: Text(isEdit ? 'Update' : 'Add'),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _approveRequest(int reqId) {
    final req = requests.firstWhere(
      (r) => r.id == reqId,
      orElse: () => throw 'not found',
    );
    setState(() {
      products.add(req.copyWith(status: 'approved'));
      requests.removeWhere((r) => r.id == reqId);
    });
  }

  void _rejectRequest(int reqId) {
    setState(() {
      requests.removeWhere((r) => r.id == reqId);
    });
  }

  void _deleteProduct(int id) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() => products.removeWhere((p) => p.id == id));
              Navigator.of(context).pop();
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _toggleEnable(int id) {
    setState(() {
      products = products
          .map((p) => p.id == id ? p.copyWith(enabled: !p.enabled) : p)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final allProducts = [...requests, ...products];
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = 1;

    if (width >= 1400)
      crossAxisCount = 3;
    else if (width >= 1024)
      crossAxisCount = 2;
    else if (width >= 481)
      crossAxisCount = 2;
    else
      crossAxisCount = 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Investment Options',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF900603),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              onPressed: () => _showAddEditBottomSheet(),
              icon: Icon(Icons.add, color: Colors.white),
              label: Text('Add Product', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFF5F5F5),
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: allProducts.length,
          itemBuilder: (context, index) {
            final item = allProducts[index];
            final isPending = item.status == 'pending';
            final isDisabled = item.status == 'approved' && !item.enabled;

            return Opacity(
              opacity: isDisabled ? 0.6 : 1.0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            productImages[item.type] ??
                                productImages.values.first,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      item.type,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: riskColor(item.risk),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  item.risk,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 8),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Expected Returns: ',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                TextSpan(text: item.returnsText),
                              ],
                            ),
                          ),
                          SizedBox(height: 6),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Min Investment: ',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                TextSpan(text: item.price),
                              ],
                            ),
                          ),

                          SizedBox(height: 10),

                          // ✅ PENDING REQUEST BUTTONS (Approve/Reject)
                          if (isPending) ...[
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () => _approveRequest(item.id),
                                    child: Text(
                                      'Approve',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF2E7D32), // Dark green
                                      minimumSize: Size.fromHeight(44),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () => _rejectRequest(item.id),
                                    child: Text(
                                      'Reject',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFD32F2F), // Dark red
                                      minimumSize: Size.fromHeight(44),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ] else ...[
                            // ✅ INVEST NOW BUTTON
                            ElevatedButton(
                              onPressed: item.enabled
                                  ? () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Invest flow for ${item.name}',
                                          ),
                                        ),
                                      );
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: item.enabled
                                    ? Color(0xFF900603)
                                    : Colors.grey,
                                minimumSize: Size.fromHeight(44),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                item.enabled ? 'Invest Now' : 'Disabled',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            SizedBox(height: 8),

                            // ✅ EDIT, DELETE, ENABLE/DISABLE BUTTONS
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () =>
                                        _showAddEditBottomSheet(product: item),
                                    child: Text('Edit'),
                                  ),
                                ),
                                SizedBox(width: 8),
                                IconButton(
                                  onPressed: () => _deleteProduct(item.id),
                                  icon: Icon(Icons.delete, color: Colors.red),
                                ),
                                SizedBox(width: 4),
                                ElevatedButton(
                                  onPressed: () => _toggleEnable(item.id),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: item.enabled
                                        ? Color(0xFF2E7D32) // Dark green
                                        : Color(0xFFD32F2F), // Dark red
                                  ),
                                  child: Text(
                                    item.enabled ? 'Disable' : 'Enable',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}