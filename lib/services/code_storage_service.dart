import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NotebookCell {
  final String id;
  String cellType; // 'code' or 'markdown'
  String content;
  String? outputStdout;
  String? outputStderr;
  List<String>? graphicsBase64;

  NotebookCell({
    required this.id,
    required this.cellType,
    required this.content,
    this.outputStdout,
    this.outputStderr,
    this.graphicsBase64,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'cellType': cellType,
        'content': content,
        if (outputStdout != null) 'outputStdout': outputStdout,
        if (outputStderr != null) 'outputStderr': outputStderr,
        if (graphicsBase64 != null) 'graphicsBase64': graphicsBase64,
      };

  factory NotebookCell.fromJson(Map<String, dynamic> json) {
    return NotebookCell(
      id: json['id']?.toString() ?? 'cell-${DateTime.now().millisecondsSinceEpoch}',
      cellType: json['cellType']?.toString() ?? 'code',
      content: json['content']?.toString() ?? '',
      outputStdout: json['outputStdout']?.toString(),
      outputStderr: json['outputStderr']?.toString(),
      graphicsBase64: (json['graphicsBase64'] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}

class IdeProject {
  final String id;
  String title;
  String type; // 'python_notebook', 'html_ide', 'latex_ide', 'universal'
  String language; // 'python', 'javascript', 'html', 'latex', 'cpp', 'java', etc.
  String codeContent;
  List<NotebookCell> notebookCells;
  Map<String, String> files;
  String? activeFile;
  int updatedAt;

  IdeProject({
    required this.id,
    required this.title,
    required this.type,
    required this.language,
    required this.codeContent,
    this.notebookCells = const [],
    this.files = const {},
    this.activeFile,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'type': type,
        'language': language,
        'codeContent': codeContent,
        'notebookCells': notebookCells.map((c) => c.toJson()).toList(),
        'files': files,
        'activeFile': activeFile,
        'updatedAt': updatedAt,
      };

  factory IdeProject.fromJson(Map<String, dynamic> json) {
    Map<String, String> parsedFiles = {};
    if (json['files'] is Map) {
      (json['files'] as Map).forEach((k, v) {
        if (k != null && v != null) {
          parsedFiles[k.toString()] = v.toString();
        }
      });
    }

    return IdeProject(
      id: json['id']?.toString() ?? 'proj-${DateTime.now().millisecondsSinceEpoch}',
      title: json['title']?.toString() ?? 'Untitled Project',
      type: json['type']?.toString() ?? 'universal',
      language: json['language']?.toString() ?? 'python',
      codeContent: json['codeContent']?.toString() ?? '',
      notebookCells: (json['notebookCells'] as List?)
              ?.map((c) => NotebookCell.fromJson(Map<String, dynamic>.from(c is Map ? c : {})))
              .toList() ??
          [],
      files: parsedFiles,
      activeFile: json['activeFile']?.toString(),
      updatedAt: json['updatedAt'] is num
          ? (json['updatedAt'] as num).toInt()
          : DateTime.now().millisecondsSinceEpoch,
    );
  }
}

class CodeStorageService {
  static final CodeStorageService _instance = CodeStorageService._internal();
  static CodeStorageService get instance => _instance;
  CodeStorageService._internal();

  static const String _keyProjects = 'user_ide_projects';

  Future<List<IdeProject>> getProjects() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final rawJson = prefs.getString(_keyProjects);
      if (rawJson == null || rawJson.trim().isEmpty) return [];

      final List list = jsonDecode(rawJson);
      final projects = list
          .map((item) => IdeProject.fromJson(Map<String, dynamic>.from(item is Map ? item : {})))
          .toList();
      projects.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return projects;
    } catch (e) {
      print('[CodeStorageService] Error loading projects: $e');
      return [];
    }
  }

  Future<void> saveProject(IdeProject project) async {
    try {
      final projects = await getProjects();
      final idx = projects.indexWhere((p) => p.id == project.id);
      if (idx != -1) {
        projects[idx] = project;
      } else {
        projects.insert(0, project);
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyProjects, jsonEncode(projects.map((p) => p.toJson()).toList()));
    } catch (e) {
      print('[CodeStorageService] Error saving project: $e');
    }
  }

  Future<void> deleteProject(String id) async {
    try {
      final projects = await getProjects();
      projects.removeWhere((p) => p.id == id);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyProjects, jsonEncode(projects.map((p) => p.toJson()).toList()));
    } catch (e) {
      print('[CodeStorageService] Error deleting project: $e');
    }
  }
}
