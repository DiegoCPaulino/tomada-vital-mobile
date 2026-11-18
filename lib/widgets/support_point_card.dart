import 'package:flutter/material.dart';

import '../models/support_point.dart';
import '../theme/app_colors.dart';
import 'app_card.dart';

/// A place with backup power, with a button to mark it as favorite.
class SupportPointCard extends StatelessWidget {
  const SupportPointCard({
    super.key,
    required this.point,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  final SupportPoint point;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.fromLTRB(14, 6, 6, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.bolt, color: AppColors.primary, size: 20),
              ),
              const Spacer(),
              IconButton(
                onPressed: onToggleFavorite,
                tooltip: isFavorite ? 'Remover dos favoritos' : 'Favoritar',
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: AppColors.critical,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            point.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(point.resource, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const Spacer(),
          Text(
            '${point.distance} · ${point.slots} vagas',
            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
