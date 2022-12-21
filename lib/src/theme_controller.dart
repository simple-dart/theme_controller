import 'dart:async';
import 'dart:html';

ThemeController themeController = ThemeController();

class ThemeController {
  String _theme = '';
  bool _monoSpaceFont = false;

  String _defaultTheme = '';
  String _localSettingsTheme = '';
  String _localSettingsMonoSpaceFont = '';
  String _themeFileSuffix = '';
  String _monoSpaceFontFile = '';

  late List<String> _themeList;

  final StreamController<String> _onThemeChange = StreamController<String>.broadcast(sync: true);

  final StreamController<bool> _onMonoSpaceFontChange = StreamController<bool>.broadcast(sync: true);

  Stream<String> get onThemeChange => _onThemeChange.stream;

  Stream<bool> get onMonoSpaceFontChange => _onMonoSpaceFontChange.stream;

  void init(List<String> themes,
      {String defaultTheme = 'Default',
      String localSettingsTheme = 'theme',
      String localSettingsMonoSpaceFont = 'monoSpaceFont',
      String themeFileSuffix = '_theme.css',
      String monoSpaceFontFile = 'mono_space_font.css'}) {
    _themeList = themes;
    _defaultTheme = defaultTheme;
    _localSettingsTheme = localSettingsTheme;
    _localSettingsMonoSpaceFont = localSettingsMonoSpaceFont;
    _monoSpaceFontFile = monoSpaceFontFile;
    _themeFileSuffix = themeFileSuffix;
    _load();
  }

  void _load() {
    final newTheme = window.localStorage[_localSettingsTheme];
    if (newTheme != null) {
      theme = newTheme;
    } else {
      theme = _defaultTheme;
    }
    final newMonoSpaceFont = window.localStorage[_localSettingsMonoSpaceFont];
    if (newMonoSpaceFont != null) {
      monoSpaceFont = newMonoSpaceFont == 'true';
    }
  }

  String get theme => _theme;

  set theme(String themeName) {
    if (_theme == themeName) {
      return;
    }
    _theme = themeName;
    window.localStorage[_localSettingsTheme] = _theme;
    final linkElements = querySelectorAll('link');
    final headElement = querySelector('head')!;
    final themeElement = linkElements.singleWhere((element) {
      if (element is LinkElement) {
        if (element.href.endsWith(_themeFileSuffix)) {
          return true;
        }
      }
      return false;
    }, orElse: () {
      final newElem = LinkElement()..rel = 'stylesheet';
      headElement.children.add(newElem);
      return newElem;
    });
    if (themeElement is LinkElement) {
      themeElement.href = '${_theme.toLowerCase()}$_themeFileSuffix';
      _onThemeChange.sink.add(_theme);
    }
  }

  bool get monoSpaceFont => _monoSpaceFont;

  set monoSpaceFont(bool value) {
    if (_monoSpaceFont == value) {
      return;
    }
    _monoSpaceFont = value;
    window.localStorage[_localSettingsMonoSpaceFont] = value.toString();
    final linkElements = querySelectorAll('link');
    final headElement = querySelector('head')!;
    final monoSpaceFontElement = linkElements.singleWhere((element) {
      if (element is LinkElement) {
        if (element.href.endsWith(_monoSpaceFontFile)) {
          return true;
        }
      }
      return false;
    }, orElse: () {
      final newElem = LinkElement()..rel = 'stylesheet';
      headElement.children.add(newElem);
      return newElem;
    });

    if (monoSpaceFontElement is LinkElement) {
      if (value) {
        monoSpaceFontElement.href = _monoSpaceFontFile;
      } else {
        monoSpaceFontElement.remove();
      }
    }
  }

  List<String> get themeList => _themeList;

  void dispose() {
    _onThemeChange.close();
    _onMonoSpaceFontChange.close();
  }
}
