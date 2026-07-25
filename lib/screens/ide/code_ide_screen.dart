import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../services/code_storage_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/responsive_center.dart';
import 'python_notebook_screen.dart';
import 'html_ide_screen.dart';
import 'latex_ide_screen.dart';

class CodeIdeScreen extends StatefulWidget {
  const CodeIdeScreen({super.key});

  @override
  State<CodeIdeScreen> createState() => _CodeIdeScreenState();
}

class _CodeIdeScreenState extends State<CodeIdeScreen> {
  List<IdeProject> _projects = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    setState(() {
      _isLoading = true;
    });
    final list = await CodeStorageService.instance.getProjects();
    if (mounted) {
      setState(() {
        _projects = list;
        _isLoading = false;
      });
    }
  }

  void _openProject(IdeProject project) {
    Widget target;
    switch (project.type) {
      case 'python_notebook':
        target = PythonNotebookScreen(existingProject: project);
        break;
      case 'html_ide':
        target = HtmlIdeScreen(existingProject: project);
        break;
      case 'latex_ide':
      default:
        target = LatexIdeScreen(existingProject: project);
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => target),
    ).then((_) => _loadProjects());
  }

  Future<void> _deleteProject(String id) async {
    await CodeStorageService.instance.deleteProject(id);
    _loadProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveCenter(
          maxWidth: ResponsiveMaxWidth.content,
          child: RefreshIndicator(
            onRefresh: _loadProjects,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  Text(
                    'COMPILERS & EDITORS',
                    style: TextStyle(
                      color: context.colors.textFaint,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildToolGrid(),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'RECENT CODE PROJECTS',
                        style: TextStyle(
                          color: context.colors.textFaint,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.1,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.refreshCw, size: 16),
                        onPressed: _loadProjects,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildProjectsList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.duoBlue.withValues(alpha: 0.2),
            AppTheme.duoViolet.withValues(alpha: 0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.duoBlue.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.duoBlue.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.duoBlue),
            ),
            child: Icon(
              LucideIcons.code2,
              color: AppTheme.duoBlue,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PROGRAMMER IDE & TOOLS',
                  style: TextStyle(
                    color: AppTheme.duoBlue,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Code Playgrounds',
                  style: TextStyle(
                    color: context.colors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Try Python notebooks, live HTML/CSS studio, and LaTeX document editor.',
                  style: TextStyle(
                    color: context.colors.textSecondary,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolGrid() {
    final isWide = MediaQuery.of(context).size.width > 600;
    return GridView.count(
      crossAxisCount: isWide ? 3 : 1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      childAspectRatio: isWide ? 1.2 : 2.5,
      children: [
        _buildIdeCard(
          title: 'Python Notebook',
          subtitle: 'Jupyter cells & Matplotlib',
          icon: LucideIcons.terminal,
          color: AppTheme.duoGreen,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PythonNotebookScreen()),
            ).then((_) => _loadProjects());
          },
        ),
        _buildIdeCard(
          title: 'HTML & CSS IDE',
          subtitle: 'Live webview preview',
          icon: LucideIcons.layout,
          color: AppTheme.duoBlue,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HtmlIdeScreen()),
            ).then((_) => _loadProjects());
          },
        ),
        _buildIdeCard(
          title: 'LaTeX Editor',
          subtitle: 'Math & doc renderer',
          icon: LucideIcons.fileCode,
          color: AppTheme.duoViolet,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LatexIdeScreen()),
            ).then((_) => _loadProjects());
          },
        ),
      ],
    );
  }

  Widget _buildIdeCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.colors.outline),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: context.colors.textFaint,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsList() {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_projects.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.colors.outline),
        ),
        child: Column(
          children: [
            Icon(LucideIcons.code, size: 36, color: context.colors.textFaint),
            const SizedBox(height: 10),
            Text(
              'No Saved Code Projects Yet',
              style: TextStyle(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tap any compiler above to create Python notebooks, HTML layouts, or LaTeX documents!',
              style: TextStyle(
                color: context.colors.textFaint,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _projects.length,
      itemBuilder: (ctx, i) {
        final p = _projects[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          color: context.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: context.colors.outline),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppTheme.duoBlue.withValues(alpha: 0.15),
              child: Icon(
                _getProjectIcon(p.type),
                color: AppTheme.duoBlue,
                size: 20,
              ),
            ),
            title: Text(
              p.title,
              style: TextStyle(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${p.type.replaceAll('_', ' ').toUpperCase()} • ${p.language.toUpperCase()}',
              style: TextStyle(
                color: context.colors.textFaint,
                fontSize: 11,
              ),
            ),
            trailing: IconButton(
              icon: Icon(LucideIcons.trash2, color: AppTheme.duoRed, size: 18),
              onPressed: () => _deleteProject(p.id),
            ),
            onTap: () => _openProject(p),
          ),
        );
      },
    );
  }

  IconData _getProjectIcon(String type) {
    switch (type) {
      case 'python_notebook':
        return LucideIcons.terminal;
      case 'html_ide':
        return LucideIcons.layout;
      case 'latex_ide':
        return LucideIcons.fileCode;
      case 'universal':
      default:
        return LucideIcons.cpu;
    }
  }
}
