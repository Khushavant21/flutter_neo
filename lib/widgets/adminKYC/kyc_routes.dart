import 'package:flutter/material.dart';
import 'kyc_dashboard.dart';
import 'review_kyc.dart';
import 'review_transactions.dart';
import 'view_alerts.dart';
import 'transactions.dart';

class KYCComplianceRoutes extends StatelessWidget {
  const KYCComplianceRoutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const KYCDashboard());
          case '/review-kyc':
            return MaterialPageRoute(builder: (_) => const ReviewKYC());
          case '/review-transactions':
            return MaterialPageRoute(builder: (_) => const ReviewTransactions());
          case '/view-alerts':
            return MaterialPageRoute(builder: (_) => const ViewAlerts());
          case '/transactions':
            return MaterialPageRoute(builder: (_) => const Transactions());
          default:
            return MaterialPageRoute(builder: (_) => const KYCDashboard());
        }
      },
    );
  }
}