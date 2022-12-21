# Simple Dart Theme Controller

Theme manager that allows you to switch css styles.

Read in other languages: [English](README.md), [Russian](README.ru.md).

## ThemeController

ThemeController - controller for managing Themes. Like all controllers, it is created and initialized during application
startup.
Essentially, ThemeController simply adds or replaces a style reference.

### Initialization

You can configure the theme manager by passing settings on initialization.

- defaultTheme - default theme name. Default: 'default';
- localSettingsTheme - a variable in LocalStorage where the name of the selected theme will be stored. Default: 'theme';
- localSettingsMonoSpaceFont - variable in LocalStorage where the monospaced font will be stored. Default: '
  monoSpaceFont'.
- themeFileSuffix - end of files with themes. Default: '_theme.css';
- monoSpaceFontFile - the name of the file where the monospace font style is defined. Default: 'mono_space_font.css'

After initialization, the theme is loaded from LocalStorage. If the theme is not found, then the default theme is
loaded.

### Properties and methods

- themeList - list of topics passed during initialization
- theme - current theme
- monoSpaceFont - current monospace font

## CSS styles

It is expected that for each theme there is a separate file with css-styles. The file name must be in the
format: `theme_name_theme_sufix`. For example: `dark_theme.css`.
Also, when using the monoSpaceFont option, a style for a monospaced font must be specified.