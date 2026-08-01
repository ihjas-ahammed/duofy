import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DailyGoal {
  final String id;
  final String title;
  final String description;
  final String category; // 'lesson', 'xp', 'perfect', 'unit', 'section', 'module', 'practice', 'time', 'accuracy'
  final int target;
  int current;
  final int rewardXp;
  final String iconName;
  bool isClaimed;
  final bool isBonus;

  DailyGoal({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.target,
    this.current = 0,
    required this.rewardXp,
    required this.iconName,
    this.isClaimed = false,
    this.isBonus = false,
  });

  bool get isCompleted => current >= target;

  double get progressRatio => target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;

  IconData get icon {
    switch (iconName) {
      case 'bookOpen':
        return LucideIcons.bookOpen;
      case 'flame':
        return LucideIcons.flame;
      case 'zap':
        return LucideIcons.zap;
      case 'star':
        return LucideIcons.star;
      case 'award':
        return LucideIcons.award;
      case 'layers':
        return LucideIcons.layers;
      case 'clock':
        return LucideIcons.clock;
      case 'target':
        return LucideIcons.target;
      case 'helpCircle':
        return LucideIcons.helpCircle;
      case 'checkCircle2':
        return LucideIcons.checkCircle2;
      case 'trophy':
        return LucideIcons.trophy;
      case 'shieldCheck':
        return LucideIcons.shieldCheck;
      default:
        return LucideIcons.target;
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'target': target,
        'current': current,
        'rewardXp': rewardXp,
        'iconName': iconName,
        'isClaimed': isClaimed,
        'isBonus': isBonus,
      };

  factory DailyGoal.fromJson(Map<String, dynamic> json) => DailyGoal(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        category: json['category'] as String,
        target: json['target'] as int,
        current: json['current'] as int? ?? 0,
        rewardXp: json['rewardXp'] as int,
        iconName: json['iconName'] as String? ?? 'target',
        isClaimed: json['isClaimed'] as bool? ?? false,
        isBonus: json['isBonus'] as bool? ?? false,
      );

  DailyGoal copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    int? target,
    int? current,
    int? rewardXp,
    String? iconName,
    bool? isClaimed,
    bool? isBonus,
  }) {
    return DailyGoal(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      target: target ?? this.target,
      current: current ?? this.current,
      rewardXp: rewardXp ?? this.rewardXp,
      iconName: iconName ?? this.iconName,
      isClaimed: isClaimed ?? this.isClaimed,
      isBonus: isBonus ?? this.isBonus,
    );
  }
}

class DailyGoalUpdateEvent {
  final DailyGoal goal;
  final int previousCurrent;
  final int newCurrent;
  final bool justCompleted;

  DailyGoalUpdateEvent({
    required this.goal,
    required this.previousCurrent,
    required this.newCurrent,
    required this.justCompleted,
  });
}
