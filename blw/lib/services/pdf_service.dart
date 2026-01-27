import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/food_log.dart';
import '../data/foods_data.dart';

class PdfService {
  static Future<void> generateAndShareReport({
    required List<FoodLog> logs,
    required Set<String> introducedFoodIds,
    required String title,
    required String subtitle,
    required Map<String, String> labels,
  }) async {
    final pdf = pw.Document();

    // Group logs by food
    final foodStats = <String, _FoodStats>{};
    for (final log in logs) {
      if (!foodStats.containsKey(log.foodId)) {
        foodStats[log.foodId] = _FoodStats(
          foodName: log.foodName,
          foodId: log.foodId,
        );
      }
      foodStats[log.foodId]!.addLog(log);
    }

    // Get reactions
    final logsWithReactions = logs.where((l) => l.reaction != Reaction.none).toList();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        header: (context) => _buildHeader(title, subtitle),
        footer: (context) => _buildFooter(context, labels['page'] ?? 'Página'),
        build: (context) => [
          _buildSummarySection(
            labels: labels,
            totalFoods: allFoods.length,
            introducedFoods: introducedFoodIds.length,
            totalLogs: logs.length,
            reactionsCount: logsWithReactions.length,
          ),
          pw.SizedBox(height: 20),
          _buildFoodsIntroducedSection(
            labels: labels,
            foodStats: foodStats,
          ),
          if (logsWithReactions.isNotEmpty) ...[
            pw.SizedBox(height: 20),
            _buildReactionsSection(
              labels: labels,
              reactions: logsWithReactions,
            ),
          ],
          pw.SizedBox(height: 20),
          _buildRecentLogsSection(
            labels: labels,
            logs: logs.take(20).toList(),
          ),
        ],
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'relatorio_blw_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
  }

  static pw.Widget _buildHeader(String title, String subtitle) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromHex('#34C759'),
                ),
              ),
              pw.Text(
                _formatDate(DateTime.now()),
                style: const pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.grey600,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            subtitle,
            style: const pw.TextStyle(
              fontSize: 14,
              color: PdfColors.grey700,
            ),
          ),
          pw.Divider(color: PdfColors.grey300),
        ],
      ),
    );
  }

  static pw.Widget _buildFooter(pw.Context context, String pageLabel) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(top: 10),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'BLW App - Baby Led Weaning',
            style: const pw.TextStyle(
              fontSize: 10,
              color: PdfColors.grey500,
            ),
          ),
          pw.Text(
            '$pageLabel ${context.pageNumber}/${context.pagesCount}',
            style: const pw.TextStyle(
              fontSize: 10,
              color: PdfColors.grey500,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSummarySection({
    required Map<String, String> labels,
    required int totalFoods,
    required int introducedFoods,
    required int totalLogs,
    required int reactionsCount,
  }) {
    final progress = (introducedFoods / totalFoods * 100).toStringAsFixed(1);

    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#F2F2F7'),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            labels['summary'] ?? 'Resumo',
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 12),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              _buildStatBox(
                label: labels['foodsTried'] ?? 'Alimentos\nExperimentados',
                value: '$introducedFoods/$totalFoods',
                subvalue: '$progress%',
              ),
              _buildStatBox(
                label: labels['totalRecords'] ?? 'Total de\nRegistros',
                value: totalLogs.toString(),
                subvalue: '',
              ),
              _buildStatBox(
                label: labels['reactions'] ?? 'Reações\nRegistradas',
                value: reactionsCount.toString(),
                subvalue: reactionsCount > 0 ? '⚠️' : '✓',
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildStatBox({
    required String label,
    required String value,
    required String subvalue,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 20,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromHex('#34C759'),
            ),
          ),
          if (subvalue.isNotEmpty)
            pw.Text(
              subvalue,
              style: const pw.TextStyle(
                fontSize: 12,
                color: PdfColors.grey600,
              ),
            ),
          pw.SizedBox(height: 4),
          pw.Text(
            label,
            style: const pw.TextStyle(
              fontSize: 10,
              color: PdfColors.grey700,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildFoodsIntroducedSection({
    required Map<String, String> labels,
    required Map<String, _FoodStats> foodStats,
  }) {
    final sortedFoods = foodStats.values.toList()
      ..sort((a, b) => b.count.compareTo(a.count));

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          labels['foodsIntroduced'] ?? 'Alimentos Introduzidos',
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 12),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          columnWidths: {
            0: const pw.FlexColumnWidth(3),
            1: const pw.FlexColumnWidth(1),
            2: const pw.FlexColumnWidth(2),
            3: const pw.FlexColumnWidth(2),
          },
          children: [
            pw.TableRow(
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('#34C759'),
              ),
              children: [
                _buildTableHeader(labels['food'] ?? 'Alimento'),
                _buildTableHeader(labels['times'] ?? 'Vezes'),
                _buildTableHeader(labels['acceptance'] ?? 'Aceitação'),
                _buildTableHeader(labels['lastDate'] ?? 'Última Data'),
              ],
            ),
            ...sortedFoods.take(30).map((food) => pw.TableRow(
              children: [
                _buildTableCell(food.foodName),
                _buildTableCell(food.count.toString()),
                _buildTableCell(food.mostCommonAcceptance),
                _buildTableCell(_formatDate(food.lastDate)),
              ],
            )),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildReactionsSection({
    required Map<String, String> labels,
    required List<FoodLog> reactions,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#FFF3E0'),
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColor.fromHex('#FF9500')),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Text(
                '⚠️ ',
                style: const pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                labels['reactionsTitle'] ?? 'Reações Registradas',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromHex('#E65100'),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 8),
          ...reactions.map((log) => pw.Padding(
            padding: const pw.EdgeInsets.symmetric(vertical: 2),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 6,
                  height: 6,
                  decoration: pw.BoxDecoration(
                    color: _getReactionColor(log.reaction),
                    shape: pw.BoxShape.circle,
                  ),
                ),
                pw.SizedBox(width: 8),
                pw.Expanded(
                  child: pw.Text(
                    '${log.foodName} - ${_getReactionLabel(log.reaction, labels)} (${_formatDate(log.date)})',
                    style: const pw.TextStyle(fontSize: 11),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  static pw.Widget _buildRecentLogsSection({
    required Map<String, String> labels,
    required List<FoodLog> logs,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          labels['recentRecords'] ?? 'Registros Recentes',
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 12),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          columnWidths: {
            0: const pw.FlexColumnWidth(2),
            1: const pw.FlexColumnWidth(3),
            2: const pw.FlexColumnWidth(2),
            3: const pw.FlexColumnWidth(2),
          },
          children: [
            pw.TableRow(
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('#34C759'),
              ),
              children: [
                _buildTableHeader(labels['date'] ?? 'Data'),
                _buildTableHeader(labels['food'] ?? 'Alimento'),
                _buildTableHeader(labels['acceptance'] ?? 'Aceitação'),
                _buildTableHeader(labels['reaction'] ?? 'Reação'),
              ],
            ),
            ...logs.map((log) => pw.TableRow(
              children: [
                _buildTableCell(_formatDate(log.date)),
                _buildTableCell(log.foodName),
                _buildTableCell(_getAcceptanceEmoji(log.acceptance)),
                _buildTableCell(log.reaction == Reaction.none
                    ? '-'
                    : _getReactionLabel(log.reaction, labels)),
              ],
            )),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildTableHeader(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 11,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.white,
        ),
      ),
    );
  }

  static pw.Widget _buildTableCell(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 10),
      ),
    );
  }

  static String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  static String _getAcceptanceEmoji(Acceptance acceptance) {
    switch (acceptance) {
      case Acceptance.loved:
        return '😍 Adorou';
      case Acceptance.liked:
        return '😊 Gostou';
      case Acceptance.neutral:
        return '😐 Neutro';
      case Acceptance.disliked:
        return '😕 Não gostou';
      case Acceptance.refused:
        return '🙅 Recusou';
    }
  }

  static String _getReactionLabel(Reaction reaction, Map<String, String> labels) {
    switch (reaction) {
      case Reaction.none:
        return labels['noReaction'] ?? 'Nenhuma';
      case Reaction.mild:
        return labels['mildReaction'] ?? 'Leve';
      case Reaction.moderate:
        return labels['moderateReaction'] ?? 'Moderada';
      case Reaction.severe:
        return labels['severeReaction'] ?? 'Severa';
    }
  }

  static PdfColor _getReactionColor(Reaction reaction) {
    switch (reaction) {
      case Reaction.none:
        return PdfColor.fromHex('#34C759');
      case Reaction.mild:
        return PdfColor.fromHex('#FF9500');
      case Reaction.moderate:
        return PdfColor.fromHex('#FF6B00');
      case Reaction.severe:
        return PdfColor.fromHex('#FF3B30');
    }
  }
}

class _FoodStats {
  final String foodName;
  final String foodId;
  int count = 0;
  DateTime lastDate = DateTime(2020);
  final Map<Acceptance, int> acceptanceCounts = {};

  _FoodStats({required this.foodName, required this.foodId});

  void addLog(FoodLog log) {
    count++;
    if (log.date.isAfter(lastDate)) {
      lastDate = log.date;
    }
    acceptanceCounts[log.acceptance] = (acceptanceCounts[log.acceptance] ?? 0) + 1;
  }

  String get mostCommonAcceptance {
    if (acceptanceCounts.isEmpty) return '-';
    final sorted = acceptanceCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final acceptance = sorted.first.key;
    switch (acceptance) {
      case Acceptance.loved:
        return '😍 Adorou';
      case Acceptance.liked:
        return '😊 Gostou';
      case Acceptance.neutral:
        return '😐 Neutro';
      case Acceptance.disliked:
        return '😕 Não gostou';
      case Acceptance.refused:
        return '🙅 Recusou';
    }
  }
}
