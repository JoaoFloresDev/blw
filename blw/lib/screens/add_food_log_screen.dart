import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/food.dart';
import '../models/food_log.dart';
import '../data/foods_data.dart';
import '../providers/food_log_provider.dart';
import '../providers/premium_provider.dart';
import '../services/photo_service.dart';
import 'premium_screen.dart';

class AddFoodLogScreen extends StatefulWidget {
  final Food? preselectedFood;

  const AddFoodLogScreen({super.key, this.preselectedFood});

  @override
  State<AddFoodLogScreen> createState() => _AddFoodLogScreenState();
}

class _AddFoodLogScreenState extends State<AddFoodLogScreen> {
  Food? _selectedFood;
  DateTime _selectedDate = DateTime.now();
  Acceptance _selectedAcceptance = Acceptance.neutral;
  Reaction _selectedReaction = Reaction.none;
  final _notesController = TextEditingController();
  final List<String> _photoPaths = [];

  @override
  void initState() {
    super.initState();
    _selectedFood = widget.preselectedFood;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  String _getAcceptanceName(BuildContext context, Acceptance acceptance) {
    final l10n = AppLocalizations.of(context);
    switch (acceptance) {
      case Acceptance.loved:
        return l10n.loved;
      case Acceptance.liked:
        return l10n.liked;
      case Acceptance.neutral:
        return l10n.neutral;
      case Acceptance.disliked:
        return l10n.disliked;
      case Acceptance.refused:
        return l10n.refused;
    }
  }

  String _getReactionName(BuildContext context, Reaction reaction) {
    final l10n = AppLocalizations.of(context);
    switch (reaction) {
      case Reaction.none:
        return l10n.noReaction;
      case Reaction.mild:
        return l10n.mildReaction;
      case Reaction.moderate:
        return l10n.moderateReaction;
      case Reaction.severe:
        return l10n.severeReaction;
    }
  }

  String _getCategoryName(BuildContext context, FoodCategory category) {
    final l10n = AppLocalizations.of(context);
    switch (category) {
      case FoodCategory.fruits:
        return l10n.fruits;
      case FoodCategory.vegetables:
        return l10n.vegetables;
      case FoodCategory.proteins:
        return l10n.proteins;
      case FoodCategory.grains:
        return l10n.grains;
      case FoodCategory.dairy:
        return l10n.dairy;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.newRecord),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(l10n.food),
            const SizedBox(height: 8),
            _buildFoodSelector(l10n),
            const SizedBox(height: 24),
            _buildSectionTitle(l10n.date),
            const SizedBox(height: 8),
            _buildDateSelector(l10n),
            const SizedBox(height: 24),
            _buildSectionTitle(l10n.howWasAcceptance),
            const SizedBox(height: 8),
            _buildAcceptanceSelector(),
            const SizedBox(height: 24),
            _buildSectionTitle(l10n.anyReaction),
            const SizedBox(height: 8),
            _buildReactionSelector(),
            const SizedBox(height: 24),
            _buildSectionTitle(l10n.photos),
            const SizedBox(height: 8),
            _buildPhotoSection(l10n),
            const SizedBox(height: 24),
            _buildSectionTitle(l10n.notesOptional),
            const SizedBox(height: 8),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: l10n.notesHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedFood != null ? () => _saveLog(l10n) : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(l10n.saveRecord),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  Widget _buildFoodSelector(AppLocalizations l10n) {
    final foodName = _selectedFood != null
        ? l10n.getFoodName(_selectedFood!.id)
        : null;

    return InkWell(
      onTap: () => _showFoodPicker(l10n),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            if (_selectedFood != null) ...[
              Text(
                _selectedFood!.icon,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  foodName ?? _selectedFood!.name,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ] else ...[
              Icon(Icons.restaurant_menu, color: Colors.grey[400]),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.selectFood,
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ),
            ],
            Icon(Icons.arrow_drop_down, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(AppLocalizations l10n) {
    return InkWell(
      onTap: _selectDate,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.grey[600]),
            const SizedBox(width: 12),
            Text(
              _formatDate(_selectedDate, l10n),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAcceptanceSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: Acceptance.values.map((acceptance) {
        final isSelected = acceptance == _selectedAcceptance;
        return ChoiceChip(
          label: Text('${acceptance.icon} ${_getAcceptanceName(context, acceptance)}'),
          selected: isSelected,
          onSelected: (_) {
            setState(() => _selectedAcceptance = acceptance);
          },
          selectedColor: Colors.blue[100],
        );
      }).toList(),
    );
  }

  Widget _buildReactionSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: Reaction.values.map((reaction) {
        final isSelected = reaction == _selectedReaction;
        return ChoiceChip(
          label: Text('${reaction.icon} ${_getReactionName(context, reaction)}'),
          selected: isSelected,
          onSelected: (_) {
            setState(() => _selectedReaction = reaction);
          },
          selectedColor: reaction == Reaction.none
              ? Colors.green[100]
              : Colors.orange[100],
        );
      }).toList(),
    );
  }

  Widget _buildPhotoSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_photoPaths.isNotEmpty) ...[
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _photoPaths.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(_photoPaths[index]),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => _removePhoto(index),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
        ],
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _addPhoto(ImageSource.camera, l10n),
                icon: const Icon(Icons.camera_alt),
                label: Text(l10n.takePhoto),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _addPhoto(ImageSource.gallery, l10n),
                icon: const Icon(Icons.photo_library),
                label: Text(l10n.chooseFromGallery),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _addPhoto(ImageSource source, AppLocalizations l10n) async {
    final premiumProvider = context.read<PremiumProvider>();
    final logProvider = context.read<FoodLogProvider>();

    final totalPhotos = logProvider.totalPhotosCount + _photoPaths.length;
    if (!premiumProvider.canAddMorePhotos(totalPhotos)) {
      _showPremiumDialog(l10n);
      return;
    }

    final path = await PhotoService.pickImage(source);
    if (path != null) {
      setState(() {
        _photoPaths.add(path);
      });
    }
  }

  void _removePhoto(int index) {
    setState(() {
      _photoPaths.removeAt(index);
    });
  }

  void _showPremiumDialog(AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.photoLimitReached),
        content: Text(l10n.upgradeToPremium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PremiumScreen()),
              );
            },
            child: Text(l10n.goPremium),
          ),
        ],
      ),
    );
  }

  void _showFoodPicker(AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (sheetContext, scrollController) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    l10n.selectFood,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: allFoods.length,
                    itemBuilder: (listContext, index) {
                      final food = allFoods[index];
                      final foodName = l10n.getFoodName(food.id);
                      return ListTile(
                        leading: Text(
                          food.icon,
                          style: const TextStyle(fontSize: 24),
                        ),
                        title: Text(foodName),
                        subtitle: Text(_getCategoryName(context, food.category)),
                        onTap: () {
                          setState(() => _selectedFood = food);
                          Navigator.pop(sheetContext);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  String _formatDate(DateTime date, AppLocalizations l10n) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return l10n.today;
    } else if (dateOnly == today.subtract(const Duration(days: 1))) {
      return l10n.yesterday;
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _saveLog(AppLocalizations l10n) {
    if (_selectedFood == null) return;

    final foodName = l10n.getFoodName(_selectedFood!.id);

    final log = FoodLog(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      foodId: _selectedFood!.id,
      foodName: foodName.startsWith('food_') ? _selectedFood!.name : foodName,
      date: _selectedDate,
      acceptance: _selectedAcceptance,
      reaction: _selectedReaction,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
      photosPaths: _photoPaths,
    );

    context.read<FoodLogProvider>().addLog(log);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.recordSaved(log.foodName)),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }
}
