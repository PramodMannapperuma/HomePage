import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../styles/sidebar.dart';

class Policies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PolicyScreen();
  }
}

class PolicyScreen extends StatefulWidget {
  @override
  _PolicyScreenState createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _policies = [
    'Leave Policy',
    'Attendance Policy',
    'Request Policy',
    'Leave Policy',
    'Leave Policy'
  ];
  List<String> _filteredPolicies = [];

  @override
  void initState() {
    super.initState();
    _filteredPolicies = _policies;
    _searchController.addListener(_filterPolicies);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterPolicies);
    _searchController.dispose();
    super.dispose();
  }

  void _filterPolicies() {
    setState(() {
      _filteredPolicies = _policies
          .where((policy) =>
          policy.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Policies',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true, // Show back button instead of hamburger icon
      ),
      drawer: CustomSidebar(token: ''),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Policies...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredPolicies.length,
                itemBuilder: (context, index) {
                  return PolicyItem(
                    policyName: _filteredPolicies[index],
                    onTap: () {
                      Navigator.pushNamed(context, '/leavePolicy');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PolicyItem extends StatelessWidget {
  final String policyName;
  final VoidCallback onTap;

  const PolicyItem({
    Key? key,
    required this.policyName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onTap,
            child: Text(
              policyName,
              style: TextStyle(fontSize: 18),
            ),
          ),
          IconButton(
            onPressed: onTap,
            icon: Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}
