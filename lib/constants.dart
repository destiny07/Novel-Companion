// Environment
const environmentDev = 'dev';
const environmentRelease = 'release';
const currentEnvironment = environmentRelease;
const functionsEmulatorUrl = '192.168.68.119:5001';
const dictionaryApiUrl =
    'http://10.0.2.2:5001/project-lyca/us-central1/app/words';

// Font Style
const String latoKey = 'lato';
const String notoSansKey = 'notoSans';
const String openSansKey = 'openSans';
const String oswaldKey = 'oswald';
const String poppinsKey = 'poppins';
const String robotoKey = 'roboto';
const Map<String, String> fontNameMap = {
  latoKey: 'Lato',
  notoSansKey: 'Noto Sans',
  openSansKey: 'Open Sans',
  oswaldKey: 'Oswald',
  poppinsKey: 'Poppins',
  robotoKey: 'Roboto',
};

// Theme
const String whiteThemeKey = 'white';
const String darkThemeKey = 'dark';
const String grayThemeKey = 'gray';
const String blueThemeKey = 'blue';
const String pinkThemeKey = 'pink';
const Map<String, String> themeNameMap = {
  whiteThemeKey: 'White',
  darkThemeKey: 'Dark',
  grayThemeKey: 'Gray',
  blueThemeKey: 'Blue',
  pinkThemeKey: 'Pink',
};

// Default Config
const double defaultFontSize = 11;
const String defaultFontStyle = notoSansKey;
const String defaultTheme = whiteThemeKey;
