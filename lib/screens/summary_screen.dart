import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/platform_webview.dart';

class YoutubeVideo {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;
  final String duration;
  final String views;

  YoutubeVideo({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.channelTitle,
    required this.duration,
    required this.views,
  });

  String get videoUrl => 'https://www.youtube.com/watch?v=$id';
}

class SummaryScreen extends StatefulWidget {
  final Book book;
  final ValueNotifier<int>? activeModule;
  final ValueNotifier<int>? activeSection;

  const SummaryScreen({
    super.key,
    required this.book,
    this.activeModule,
    this.activeSection,
  });

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final Map<String, List<YoutubeVideo>> _cachedVideos = {};
  final Map<String, bool> _loadingUnits = {};
  final Map<String, String?> _errorUnits = {};

  // Track search text controllers for each unit
  final Map<String, TextEditingController> _searchControllers = {};

  int _activeModuleIdx = 0;
  int _activeSectionIdx = 0;
  bool _preferencesLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    widget.activeModule?.addListener(_onActiveModuleOrSectionChanged);
    widget.activeSection?.addListener(_onActiveModuleOrSectionChanged);
  }

  @override
  void didUpdateWidget(SummaryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activeModule != widget.activeModule) {
      oldWidget.activeModule?.removeListener(_onActiveModuleOrSectionChanged);
      widget.activeModule?.addListener(_onActiveModuleOrSectionChanged);
    }
    if (oldWidget.activeSection != widget.activeSection) {
      oldWidget.activeSection?.removeListener(_onActiveModuleOrSectionChanged);
      widget.activeSection?.addListener(_onActiveModuleOrSectionChanged);
    }
    _onActiveModuleOrSectionChanged();
  }

  @override
  void dispose() {
    widget.activeModule?.removeListener(_onActiveModuleOrSectionChanged);
    widget.activeSection?.removeListener(_onActiveModuleOrSectionChanged);
    for (final controller in _searchControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onActiveModuleOrSectionChanged() {
    final modIdx = widget.activeModule?.value ?? _activeModuleIdx;
    final secIdx = widget.activeSection?.value ?? _activeSectionIdx;
    _updateActiveSection(modIdx, secIdx);
  }

  void _updateActiveSection(int modIdx, int secIdx) {
    if (modIdx >= 0 && modIdx < widget.book.modules.length) {
      final module = widget.book.modules[modIdx];
      if (secIdx >= 0 && secIdx < module.sections.length) {
        final section = module.sections[secIdx];
        for (final unit in section.units) {
          if (!_searchControllers.containsKey(unit.id)) {
            _searchControllers[unit.id] = TextEditingController(
              text: "${widget.book.title} ${unit.title} class lecture",
            );
          }
        }
      }
    }
    if (mounted) {
      setState(() {
        _activeModuleIdx = modIdx;
        _activeSectionIdx = secIdx;
      });
    }
  }

  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final modIdx = widget.activeModule?.value ?? (prefs.getInt('last_mod_idx_${widget.book.id}') ?? 0);
      final secIdx = widget.activeSection?.value ?? (prefs.getInt('last_sec_idx_${widget.book.id}') ?? 0);
      
      // Initialize text controllers for units in the current section
      if (modIdx >= 0 && modIdx < widget.book.modules.length) {
        final module = widget.book.modules[modIdx];
        if (secIdx >= 0 && secIdx < module.sections.length) {
          final section = module.sections[secIdx];
          for (final unit in section.units) {
            if (!_searchControllers.containsKey(unit.id)) {
              _searchControllers[unit.id] = TextEditingController(
                text: "${widget.book.title} ${unit.title} class lecture",
              );
            }
          }
        }
      }

      if (mounted) {
        setState(() {
          _activeModuleIdx = modIdx;
          _activeSectionIdx = secIdx;
          _preferencesLoaded = true;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _preferencesLoaded = true;
        });
      }
    }
  }

  Future<void> _searchVideosForUnit(Unit unit) async {
    final unitId = unit.id;
    final controller = _searchControllers[unitId];
    if (controller == null) return;

    final query = controller.text.trim();
    if (query.isEmpty) return;

    if (mounted) {
      setState(() {
        _loadingUnits[unitId] = true;
        _errorUnits[unitId] = null;
      });
    }

    try {
      final videos = await _searchYouTube(query);
      _sortVideosByPriority(videos);
      
      if (mounted) {
        setState(() {
          _cachedVideos[unitId] = videos;
          _loadingUnits[unitId] = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorUnits[unitId] = e.toString();
          _loadingUnits[unitId] = false;
        });
      }
    }
  }

  void _sortVideosByPriority(List<YoutubeVideo> videos) {
    final List<String> priorities = [
      'mit',
      'ocw',
      'cambridge',
      'stanford',
      'nptel',
      'harvard',
      'yale',
      'berkeley',
      'khan academy',
      'crashcourse',
    ];

    videos.sort((a, b) {
      final aChannel = a.channelTitle.toLowerCase();
      final bChannel = b.channelTitle.toLowerCase();

      bool aHasPriority = priorities.any((p) => aChannel.contains(p));
      bool bHasPriority = priorities.any((p) => bChannel.contains(p));

      if (aHasPriority && !bHasPriority) {
        return -1;
      } else if (!aHasPriority && bHasPriority) {
        return 1;
      }
      return 0;
    });
  }

  Future<List<YoutubeVideo>> _searchYouTube(String query) async {
    final searchUrl = Uri.parse('https://www.youtube.com/results?search_query=${Uri.encodeComponent(query)}');
    final response = await http.get(
      searchUrl,
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'Accept-Language': 'en-US,en;q=0.9',
      },
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch YouTube search results. Status: ${response.statusCode}');
    }

    final html = response.body;
    final jsonStart = html.indexOf('var ytInitialData = ');
    if (jsonStart == -1) {
      throw Exception('Could not parse search metadata.');
    }

    final dataOffset = jsonStart + 'var ytInitialData = '.length;
    final jsonEnd = html.indexOf('};', dataOffset);
    if (jsonEnd == -1) {
      throw Exception('Failed to read search data block.');
    }

    final jsonStr = html.substring(dataOffset, jsonEnd + 1);
    final Map<String, dynamic> data = jsonDecode(jsonStr);

    final List<YoutubeVideo> videos = [];
    try {
      final contents = data['contents']?['twoColumnSearchResultsRenderer']?['primaryContents']?['sectionListRenderer']?['contents'];
      if (contents == null || contents.isEmpty) {
        return _searchFallbackRegex(html);
      }

      for (final section in contents) {
        final itemSection = section['itemSectionRenderer'];
        if (itemSection == null) continue;
        final items = itemSection['contents'];
        if (items == null) continue;

        for (final item in items) {
          final video = item['videoRenderer'];
          if (video == null) continue;

          final videoId = video['videoId'] as String?;
          if (videoId == null || videoId.isEmpty) continue;

          final titleText = video['title']?['runs']?[0]?['text'] as String? ?? 'No Title';
          final channelText = video['ownerText']?['runs']?[0]?['text'] as String? ?? 'Unknown Channel';
          final durationText = video['lengthText']?['simpleText'] as String? ?? 'N/A';
          final viewsText = video['viewCountText']?['simpleText'] as String? ?? 'N/A';

          final thumbnails = video['thumbnail']?['thumbnails'] as List?;
          final thumbUrl = thumbnails != null && thumbnails.isNotEmpty
              ? thumbnails.last['url'] as String?
              : 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';

          videos.add(YoutubeVideo(
            id: videoId,
            title: titleText,
            thumbnailUrl: thumbUrl ?? 'https://img.youtube.com/vi/$videoId/hqdefault.jpg',
            channelTitle: channelText,
            duration: durationText,
            views: viewsText,
          ));

          if (videos.length >= 8) break;
        }
        if (videos.isNotEmpty) break;
      }
    } catch (e) {
      debugPrint('Error parsing YouTube JSON: $e');
      return _searchFallbackRegex(html);
    }

    if (videos.isEmpty) {
      return _searchFallbackRegex(html);
    }

    return videos;
  }

  List<YoutubeVideo> _searchFallbackRegex(String html) {
    final List<YoutubeVideo> videos = [];
    final regExp = RegExp(r'"videoRenderer":\s*\{"videoId":\s*"([^"]+)"');
    final matches = regExp.allMatches(html);
    
    final Set<String> seenIds = {};
    for (final match in matches) {
      if (match.groupCount >= 1) {
        final videoId = match.group(1);
        if (videoId != null && !seenIds.contains(videoId)) {
          seenIds.add(videoId);
          
          String title = 'YouTube Lecture';
          final titleRegex = RegExp('"videoId":\\s*"$videoId"[^}]+?"title":\\s*\\{\\s*"runs":\\s*\\[\\s*\\{\\s*"text":\\s*"([^"]+)"');
          final titleMatch = titleRegex.firstMatch(html);
          if (titleMatch != null && titleMatch.groupCount >= 1) {
            title = titleMatch.group(1) ?? 'YouTube Lecture';
          }

          videos.add(YoutubeVideo(
            id: videoId,
            title: title,
            thumbnailUrl: 'https://img.youtube.com/vi/$videoId/hqdefault.jpg',
            channelTitle: 'YouTube Channel',
            duration: 'Class',
            views: 'N/A',
          ));

          if (videos.length >= 6) break;
        }
      }
    }
    return videos;
  }

  Future<void> _playVideo(BuildContext context, YoutubeVideo video) async {
    final videoUrl = 'https://www.youtube.com/watch?v=${video.id}';
    final uri = Uri.parse(videoUrl);

    try {
      if (Platform.isAndroid) {
        final appUri = Uri.parse('vnd.youtube:${video.id}');
        if (await canLaunchUrl(appUri)) {
          await launchUrl(appUri);
          return;
        }
      }
      
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch browser for URL: $videoUrl');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to open video: $e'),
            backgroundColor: AppTheme.duoRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_preferencesLoaded) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.duoBlue),
          ),
        ),
      );
    }

    Module? currentModule;
    Section? currentSection;

    if (_activeModuleIdx >= 0 && _activeModuleIdx < widget.book.modules.length) {
      currentModule = widget.book.modules[_activeModuleIdx];
      if (_activeSectionIdx >= 0 && _activeSectionIdx < currentModule.sections.length) {
        currentSection = currentModule.sections[_activeSectionIdx];
      }
    }

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [

            if (currentModule == null || currentSection == null)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text(
                      'No active section selected.\nGo to the Learning Path tab and open a section first.',
                      style: TextStyle(color: Colors.white54, height: 1.4),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            else ...[
              // Current section indicator header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: AppTheme.glassDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.duoBlue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(LucideIcons.bookOpen, color: AppTheme.duoBlue, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'MODULE ${_activeModuleIdx + 1} • SECTION ${_activeSectionIdx + 1}',
                                    style: const TextStyle(
                                      color: AppTheme.duoBlue,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 10,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    currentSection.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (currentSection.description.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(
                            currentSection.description,
                            style: const TextStyle(color: Colors.white54, fontSize: 12, height: 1.4),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),

              // Title for search listings
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  child: Text(
                    'Search Classes by Unit'.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      letterSpacing: 1.0,
                      color: Colors.white38,
                    ),
                  ),
                ),
              ),

              // Unit searches listing
              currentSection.units.isEmpty
                  ? const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          'No units available in this section.',
                          style: TextStyle(color: Colors.white38),
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final unit = currentSection!.units[index];
                            final controller = _searchControllers[unit.id];
                            final isLoading = _loadingUnits[unit.id] ?? false;
                            final String? error = _errorUnits[unit.id];
                            final List<YoutubeVideo>? videos = _cachedVideos[unit.id];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: AppTheme.glassDecoration,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Unit details
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.05),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(LucideIcons.playCircle, color: Colors.white70, size: 20),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              unit.title,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                fontFamily: 'Nunito',
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              unit.description,
                                              style: const TextStyle(color: Colors.white54, fontSize: 11),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),

                                  // Search Control Row
                                  if (controller != null)
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 42,
                                            padding: const EdgeInsets.symmetric(horizontal: 12),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.04),
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: Colors.white.withOpacity(0.08)),
                                            ),
                                            child: TextField(
                                              controller: controller,
                                              style: const TextStyle(color: Colors.white, fontSize: 12),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Enter search keywords...',
                                                hintStyle: TextStyle(color: Colors.white30, fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppTheme.duoBlue,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            minimumSize: const Size(0, 42),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            elevation: 0,
                                          ),
                                          onPressed: isLoading ? null : () => _searchVideosForUnit(unit),
                                          child: isLoading
                                              ? const SizedBox(
                                                  width: 16,
                                                  height: 16,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                  ),
                                                )
                                              : const Icon(LucideIcons.search, size: 16),
                                        ),
                                      ],
                                    ),
                                  
                                  // Results Area
                                  if (isLoading)
                                    const Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: Center(
                                        child: Text(
                                          'Searching YouTube...',
                                          style: TextStyle(color: Colors.white30, fontSize: 12),
                                        ),
                                      ),
                                    )
                                  else if (error != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: Text(
                                        'Error: $error',
                                        style: const TextStyle(color: AppTheme.duoRed, fontSize: 11),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  else if (videos != null && videos.isNotEmpty) ...[
                                    const SizedBox(height: 16),
                                    const Divider(color: Colors.white10, height: 1),
                                    const SizedBox(height: 12),
                                    ...videos.map((video) => _buildVideoCard(context, video)),
                                  ] else if (videos != null)
                                    const Padding(
                                      padding: EdgeInsets.only(top: 16.0),
                                      child: Text(
                                        'No lectures found for this query.',
                                        style: TextStyle(color: Colors.white30, fontSize: 11),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                          childCount: currentSection.units.length,
                        ),
                      ),
                    ),
            ],
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCard(BuildContext context, YoutubeVideo video) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => _playVideo(context, video),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 90,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          video.thumbnailUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(LucideIcons.video, color: Colors.white24, size: 16),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(LucideIcons.play, color: Colors.white, size: 10),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 3,
                      right: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 0.5),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          video.duration,
                          style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          fontFamily: 'Nunito',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              video.channelTitle,
                              style: const TextStyle(color: Colors.white54, fontSize: 10),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            video.views,
                            style: const TextStyle(color: Colors.white30, fontSize: 9),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
