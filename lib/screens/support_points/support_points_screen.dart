import 'package:flutter/material.dart';

import '../../models/support_point.dart';
import '../../repositories/support_point_repository.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/app_header.dart';
import '../../widgets/support_point_card.dart';

/// Places with backup power. Favorites are kept in the screen state.
class SupportPointsScreen extends StatefulWidget {
  const SupportPointsScreen({super.key});

  @override
  State<SupportPointsScreen> createState() => _SupportPointsScreenState();
}

class _SupportPointsScreenState extends State<SupportPointsScreen> {
  final List<SupportPoint> _points = SupportPointRepository.instance.findAll();
  final Set<int> _favoriteIds = {};

  void _toggleFavorite(SupportPoint point) {
    setState(() {
      if (!_favoriteIds.remove(point.id)) {
        _favoriteIds.add(point.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'Pontos de apoio'),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Locais com energia de reserva para onde a família pode levar o paciente.',
              style: TextStyle(fontSize: 14, height: 1.4, color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(AppSpacing.fieldRadius),
              ),
              child: Row(
                children: [
                  const Icon(Icons.favorite, color: AppColors.primary, size: 18),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Favoritos: ${_favoriteIds.length}',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: GridView.builder(
                itemCount: _points.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final point = _points[index];
                  return SupportPointCard(
                    point: point,
                    isFavorite: _favoriteIds.contains(point.id),
                    onToggleFavorite: () => _toggleFavorite(point),
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
