// lib/widgets/admin_invesment/product_catalog_screen.dart
import 'package:flutter/material.dart';

class Product {
  int id;
  String name;
  String type;
  String price;
  String returns;
  String risk;
  bool enabled;
  String status;

  Product({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.returns,
    required this.risk,
    required this.enabled,
    required this.status,
  });
}

class ProductCatalogScreen extends StatefulWidget {
  const ProductCatalogScreen({super.key});

  @override
  State<ProductCatalogScreen> createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  final Map<String, String> productImages = {
    "Mutual Fund":
        "https://images.pexels.com/photos/8437000/pexels-photo-8437000.jpeg?auto=compress&cs=tinysrgb&w=800",
    "Bank FD":
        "https://images.pexels.com/photos/843700/pexels-photo-843700.jpeg?auto=compress&cs=tinysrgb&w=800",
    "Exchange Traded Fund":
        "https://images.pexels.com/photos/5980742/pexels-photo-5980742.jpeg?auto=compress&cs=tinysrgb&w=800",
    "Stock":
        "https://images.pexels.com/photos/5716004/pexels-photo-5716004.jpeg?auto=compress&cs=tinysrgb&w=800",
  };

  final riskColors = {
    "High Risk": Colors.redAccent,
    "Medium Risk": Colors.orangeAccent,
    "Low Risk": Colors.green,
  };

  List<Product> products = [
    Product(
      id: 1,
      name: "Equity Mutual Fund",
      type: "Mutual Fund",
      price: "₹5,000",
      returns: "12-15% annually",
      risk: "High Risk",
      enabled: true,
      status: "approved",
    ),
    Product(
      id: 2,
      name: "Fixed Deposit",
      type: "Bank FD",
      price: "₹1,000",
      returns: "6-7% annually",
      risk: "Low Risk",
      enabled: true,
      status: "approved",
    ),
  ];

  List<Product> requests = [
    Product(
      id: 101,
      name: "Gold ETF",
      type: "Exchange Traded Fund",
      price: "₹2,000",
      returns: "8-10% annually",
      risk: "Medium Risk",
      enabled: true,
      status: "pending",
    ),
    Product(
      id: 102,
      name: "Bluechip Stocks",
      type: "Stock",
      price: "₹10,000",
      returns: "15% annually",
      risk: "High Risk",
      enabled: true,
      status: "pending",
    ),
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController returnsController = TextEditingController();

  String selectedType = "Mutual Fund";
  String selectedRisk = "Low Risk";
  bool enabled = true;
  Product? editProduct;

  // ========================= PRODUCT FORM =========================
  void _showProductForm({Product? product}) {
    if (product != null) {
      editProduct = product;
      nameController.text = product.name;
      priceController.text = product.price;
      returnsController.text = product.returns;
      selectedType = product.type;
      selectedRisk = product.risk;
      enabled = product.enabled;
    } else {
      editProduct = null;
      nameController.clear();
      priceController.clear();
      returnsController.clear();
      selectedType = "Mutual Fund";
      selectedRisk = "Low Risk";
      enabled = true;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  editProduct != null ? "Edit Product" : "Add Product",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF900603),
                  ),
                ),
                const SizedBox(height: 16),
                _buildInputField("Product Name", nameController),
                const SizedBox(height: 10),
                _buildDropdown(
                  label: "Type",
                  value: selectedType,
                  items: const [
                    "Mutual Fund",
                    "Bank FD",
                    "Exchange Traded Fund",
                    "Stock",
                  ],
                  onChanged: (val) => setState(() => selectedType = val!),
                ),
                const SizedBox(height: 10),
                _buildInputField("Price / Minimum Investment", priceController),
                const SizedBox(height: 10),
                _buildInputField("Expected Returns", returnsController),
                const SizedBox(height: 10),
                _buildDropdown(
                  label: "Risk",
                  value: selectedRisk,
                  items: const ["Low Risk", "Medium Risk", "High Risk"],
                  onChanged: (val) => setState(() => selectedRisk = val!),
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  value: enabled,
                  onChanged: (val) => setState(() => enabled = val),
                  activeThumbColor: const Color(0xFF900603),
                  title: const Text("Enable Product"),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF900603),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _saveProduct,
                      child: Text(editProduct != null ? "Update" : "Add"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      onChanged: onChanged,
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
    );
  }

  void _saveProduct() {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        returnsController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    setState(() {
      if (editProduct != null) {
        editProduct!
          ..name = nameController.text
          ..price = priceController.text
          ..returns = returnsController.text
          ..type = selectedType
          ..risk = selectedRisk
          ..enabled = enabled;
      } else {
        products.add(
          Product(
            id: DateTime.now().millisecondsSinceEpoch,
            name: nameController.text,
            type: selectedType,
            price: priceController.text,
            returns: returnsController.text,
            risk: selectedRisk,
            enabled: enabled,
            status: "approved",
          ),
        );
      }
    });

    Navigator.pop(context);
  }

  void _deleteProduct(Product product) {
    setState(() => products.remove(product));
  }

  void _approveRequest(Product req) {
    setState(() {
      req.status = "approved";
      requests.remove(req);
      products.add(req);
    });
  }

  void _rejectRequest(Product req) {
    setState(() => requests.remove(req));
  }

  // ========================= MAIN UI =========================
  @override
  Widget build(BuildContext context) {
    final allItems = [...requests, ...products];
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final crossAxisCount = isMobile ? 1 : 2;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          "Investment Products",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF900603),
        elevation: 2,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF900603),
        onPressed: () => _showProductForm(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: GridView.builder(
          itemCount: allItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: isMobile ? 0.7 : 0.8,
          ),
          itemBuilder: (context, index) {
            final item = allItems[index];
            final isDisabled = item.status == "approved" && !item.enabled;

            return AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isDisabled ? 0.5 : 1,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                clipBehavior: Clip.antiAlias,
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(
                        productImages[item.type] ?? "",
                        height: isMobile ? 140 : 150,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              item.type,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: riskColors[item.risk],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                item.risk,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Expected Returns: ${item.returns}",
                              style: const TextStyle(fontSize: 13),
                            ),
                            Text(
                              "Min Investment: ${item.price}",
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 10),
                            if (item.status == "pending") ...[
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        minimumSize: const Size(0, 36),
                                        textStyle: const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                      onPressed: () => _approveRequest(item),
                                      child: const Text("Approve"),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        minimumSize: const Size(0, 36),
                                        textStyle: const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                      onPressed: () => _rejectRequest(item),
                                      child: const Text("Reject"),
                                    ),
                                  ),
                                ],
                              ),
                            ] else ...[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: item.enabled
                                      ? const Color(0xFF900603)
                                      : Colors.grey,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(0, 38),
                                  textStyle: const TextStyle(fontSize: 13),
                                ),
                                onPressed: item.enabled ? () {} : null,
                                child: Text(
                                  item.enabled ? "Invest Now" : "Disabled",
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () =>
                                          _showProductForm(product: item),
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                          color: Color(0xFF900603),
                                        ),
                                        minimumSize: const Size(0, 34),
                                        textStyle: const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                      child: const Text("Edit"),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () => _deleteProduct(item),
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                          color: Colors.red,
                                        ),
                                        minimumSize: const Size(0, 34),
                                        textStyle: const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
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
              ),
            );
          },
        ),
      ),
    );
  }
}

