import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:personal_finance_tracker/core/models/transaction.dart';
import 'package:personal_finance_tracker/core/constants/app_colors.dart';

class SpendingChart extends StatelessWidget {
  final Stream<List<Transaction>> transactions;

  const SpendingChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: StreamBuilder<List<Transaction>>(
        stream: transactions,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final expenses = snapshot.data!
              .where((t) => t.type == 'expense')
              .fold<Map<String, double>>({}, (map, t) {
                map[t.category] = (map[t.category] ?? 0) + t.amount;
                return map;
              });

          if (expenses.isEmpty) {
            return const Center(child: Text('No expenses to display'));
          }

          return PieChart(
            PieChartData(
              sections: expenses.entries
                  .toList()
                  .asMap()
                  .entries
                  .map((entry) => PieChartSectionData(
                        color: [
                          AppColors.accent,
                          Colors.blue,
                          Colors.green,
                          Colors.red,
                          Colors.purple,
                        ][entry.key % 5],
                        value: entry.value.value,
                        title: '${entry.value.key}\n${(entry.value.value / expenses.values.reduce((a, b) => a + b) * 100).toStringAsFixed(1)}%',
                        radius: 80,
                        titleStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ))
                  .toList(),
              centerSpaceRadius: 40,
              sectionsSpace: 2,
            ),
          );
        },
      ),
    );
  }
}