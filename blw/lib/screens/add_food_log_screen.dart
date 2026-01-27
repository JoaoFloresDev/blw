import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../models/food.dart';
import '../models/food_log.dart';
import '../data/foods_data.dart';
import '../providers/food_log_provider.dart';
import '../services/photo_service.dart';
import '../widgets/celebration_overlay.dart';

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
  final _searchController = TextEditingController();
  final List<String> _photoPaths = [];
  bool _showFoodList = false;
  String _searchQuery = '';
  FoodCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedFood = widget.preselectedFood;
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Food> get _filteredFoods {
    final l10n = AppLocalizations.of(context);
    var foods = allFoods.toList();

    if (_selectedCategory != null) {
      foods = foods.where((f) => f.category == _selectedCategory).toList();
    }

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      foods = foods.where((f) {
        final name = l10n.getFoodName(f.id).toLowerCase();
        return name.contains(query) || f.name.toLowerCase().contains(query);
      }).toList();
    }

    return foods;
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

  IconData _getCategoryIcon(FoodCategory category) {
    switch (category) {
      case FoodCategory.fruits:
        return CupertinoIcons.sun_max_fill;
      case FoodCategory.vegetables:
        return CupertinoIcons.leaf_arrow_circlepath;
      case FoodCategory.proteins:
        return CupertinoIcons.flame_fill;
      case FoodCategory.grains:
        return CupertinoIcons.circle_grid_3x3_fill;
      case FoodCategory.dairy:
        return CupertinoIcons.drop_fill;
    }
  }

  Color _getCategoryColor(FoodCategory category) {
    switch (category) {
      case FoodCategory.fruits:
        return const Color(0xFFFF9500);
      case FoodCategory.vegetables:
        return const Color(0xFF34C759);
      case FoodCategory.proteins:
        return const Color(0xFFFF3B30);
      case FoodCategory.grains:
        return const Color(0xFFFFCC00);
      case FoodCategory.dairy:
        return const Color(0xFF007AFF);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F7),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Icon(
            CupertinoIcons.chevron_back,
            color: AppColors.primary,
          ),
        ),
        title: Text(
          l10n.newRecord,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C1C1E),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(l10n.food),
                  const SizedBox(height: 12),
                  _buildFoodSelector(l10n),
                  if (_showFoodList) ...[
                    const SizedBox(height: 12),
                    _buildFoodSearchAndList(l10n),
                  ],
                  const SizedBox(height: 28),
                  _buildSectionTitle(l10n.date),
                  const SizedBox(height: 12),
                  _buildDateSelector(l10n),
                  const SizedBox(height: 28),
                  _buildSectionTitle(l10n.howWasAcceptance),
                  const SizedBox(height: 12),
                  _buildAcceptanceSelector(),
                  const SizedBox(height: 28),
                  _buildSectionTitle(l10n.anyReaction),
                  const SizedBox(height: 12),
                  _buildReactionSelector(),
                  const SizedBox(height: 28),
                  _buildSectionTitle(l10n.photos),
                  const SizedBox(height: 12),
                  _buildPhotoSection(l10n),
                  const SizedBox(height: 28),
                  _buildSectionTitle(l10n.notesOptional),
                  const SizedBox(height: 12),
                  _buildNotesField(l10n),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          _buildSaveButton(l10n),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: Color(0xFF8E8E93),
        letterSpacing: -0.1,
      ),
    );
  }

  Widget _buildFoodSelector(AppLocalizations l10n) {
    final foodName = _selectedFood != null
        ? l10n.getFoodName(_selectedFood!.id)
        : null;

    return GestureDetector(
      onTap: () {
        setState(() {
          _showFoodList = !_showFoodList;
          if (!_showFoodList) {
            _searchController.clear();
            _selectedCategory = null;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            if (_selectedFood != null) ...[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _getCategoryColor(_selectedFood!.category).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    _selectedFood!.icon,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      foodName ?? _selectedFood!.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1C1C1E),
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _getCategoryName(context, _selectedFood!.category),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8E8E93),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  CupertinoIcons.leaf_arrow_circlepath,
                  color: Color(0xFFC7C7CC),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  l10n.selectFood,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color(0xFFC7C7CC),
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ],
            Icon(
              _showFoodList ? CupertinoIcons.chevron_up : CupertinoIcons.chevron_down,
              color: const Color(0xFFC7C7CC),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodSearchAndList(AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: CupertinoSearchTextField(
              controller: _searchController,
              placeholder: l10n.selectFood,
              backgroundColor: const Color(0xFFF2F2F7),
              borderRadius: BorderRadius.circular(10),
              prefixInsets: const EdgeInsets.only(left: 10),
              style: const TextStyle(
                fontSize: 17,
                color: Color(0xFF1C1C1E),
              ),
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildCategoryChip(null, l10n.all),
                ...FoodCategory.values.map((cat) => _buildCategoryChip(cat, _getCategoryName(context, cat))),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 280),
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 12),
              itemCount: _filteredFoods.length,
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                indent: 70,
                color: Color(0xFFE5E5EA),
              ),
              itemBuilder: (context, index) {
                final food = _filteredFoods[index];
                final foodName = l10n.getFoodName(food.id);
                final isSelected = _selectedFood?.id == food.id;

                return CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      _selectedFood = food;
                      _showFoodList = false;
                      _searchController.clear();
                      _selectedCategory = null;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    color: isSelected ? AppColors.primary.withValues(alpha: 0.08) : Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _getCategoryColor(food.category).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              food.icon,
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            foodName,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              color: const Color(0xFF1C1C1E),
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            CupertinoIcons.checkmark,
                            color: AppColors.primary,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(FoodCategory? category, String label) {
    final isSelected = _selectedCategory == category;
    final color = category != null ? _getCategoryColor(category) : AppColors.primary;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedCategory = category;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? color : const Color(0xFFE5E5EA),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (category != null) ...[
                Icon(
                  _getCategoryIcon(category),
                  size: 14,
                  color: isSelected ? Colors.white : color,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF1C1C1E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector(AppLocalizations l10n) {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF007AFF).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                CupertinoIcons.calendar,
                color: Color(0xFF007AFF),
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Text(
              _formatDate(_selectedDate, l10n),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1C1C1E),
                letterSpacing: -0.3,
              ),
            ),
            const Spacer(),
            const Icon(
              CupertinoIcons.chevron_right,
              color: Color(0xFFC7C7CC),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAcceptanceSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 10,
      children: Acceptance.values.map((acceptance) {
        final isSelected = acceptance == _selectedAcceptance;
        return GestureDetector(
          onTap: () => setState(() => _selectedAcceptance = acceptance),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.25)
                      : Colors.black.withValues(alpha: 0.04),
                  blurRadius: isSelected ? 12 : 8,
                  offset: Offset(0, isSelected ? 4 : 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  acceptance.icon,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 8),
                Text(
                  _getAcceptanceName(context, acceptance),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF1C1C1E),
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildReactionSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 10,
      children: Reaction.values.map((reaction) {
        final isSelected = reaction == _selectedReaction;
        final reactionColor = reaction == Reaction.none
            ? const Color(0xFF34C759)
            : reaction == Reaction.mild
                ? const Color(0xFFFF9500)
                : reaction == Reaction.moderate
                    ? const Color(0xFFFF6B00)
                    : const Color(0xFFFF3B30);

        return GestureDetector(
          onTap: () => setState(() => _selectedReaction = reaction),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? reactionColor : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? reactionColor.withValues(alpha: 0.25)
                      : Colors.black.withValues(alpha: 0.04),
                  blurRadius: isSelected ? 12 : 8,
                  offset: Offset(0, isSelected ? 4 : 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  reaction.icon,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 8),
                Text(
                  _getReactionName(context, reaction),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF1C1C1E),
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
          ),
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
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _photoPaths.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Stack(
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.file(
                            File(_photoPaths[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 6,
                        right: 6,
                        child: GestureDetector(
                          onTap: () => _removePhoto(index),
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.6),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              CupertinoIcons.xmark,
                              size: 14,
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
          const SizedBox(height: 16),
        ],
        Column(
          children: [
            _buildPhotoButton(
              icon: CupertinoIcons.camera_fill,
              label: l10n.takePhoto,
              onTap: () => _addPhoto(ImageSource.camera, l10n),
            ),
            const SizedBox(height: 10),
            _buildPhotoButton(
              icon: CupertinoIcons.photo_fill,
              label: l10n.chooseFromGallery,
              onTap: () => _addPhoto(ImageSource.gallery, l10n),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhotoButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesField(AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _notesController,
        maxLines: 4,
        style: const TextStyle(
          fontSize: 17,
          color: Color(0xFF1C1C1E),
          letterSpacing: -0.3,
        ),
        decoration: InputDecoration(
          hintText: l10n.notesHint,
          hintStyle: const TextStyle(
            color: Color(0xFFC7C7CC),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildSaveButton(AppLocalizations l10n) {
    final canSave = _selectedFood != null;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 34),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F7),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          color: canSave ? AppColors.primary : const Color(0xFFE5E5EA),
          borderRadius: BorderRadius.circular(14),
          onPressed: canSave ? () => _saveLog(l10n) : null,
          child: Text(
            l10n.saveRecord,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: canSave ? Colors.white : const Color(0xFFC7C7CC),
              letterSpacing: -0.3,
            ),
          ),
        ),
      ),
    );
  }

  void _addPhoto(ImageSource source, AppLocalizations l10n) async {
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

  Future<void> _selectDate() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 280,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      AppLocalizations.of(context).cancel,
                      style: const TextStyle(
                        color: Color(0xFF8E8E93),
                        fontSize: 17,
                      ),
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                maximumDate: DateTime.now(),
                minimumDate: DateTime(2020),
                onDateTimeChanged: (date) {
                  setState(() => _selectedDate = date);
                },
              ),
            ),
          ],
        ),
      ),
    );
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

  void _saveLog(AppLocalizations l10n) async {
    if (_selectedFood == null) return;

    final foodName = l10n.getFoodName(_selectedFood!.id);
    final displayName = foodName.startsWith('food_') ? _selectedFood!.name : foodName;

    final log = FoodLog(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      foodId: _selectedFood!.id,
      foodName: displayName,
      date: _selectedDate,
      acceptance: _selectedAcceptance,
      reaction: _selectedReaction,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
      photosPaths: _photoPaths,
    );

    final isFirstTime = await context.read<FoodLogProvider>().addLog(log);

    if (!mounted) return;

    if (isFirstTime) {
      // Show celebration overlay for first time foods
      _showCelebration(displayName, _selectedFood!.icon);
    } else {
      // Show regular snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.recordSaved(log.foodName)),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(16),
        ),
      );
      Navigator.pop(context);
    }
  }

  void _showCelebration(String foodName, String foodIcon) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Celebration',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return CelebrationOverlay(
          foodName: foodName,
          foodIcon: foodIcon,
          onDismiss: () {
            Navigator.of(context).pop();
            Navigator.of(this.context).pop();
          },
        );
      },
    );
  }
}
