import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';
import '../localization/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.get('settings')),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle(theme, loc.get('language')),
          const SizedBox(height: 8),
          _buildLanguageSection(context, theme, loc),
          const SizedBox(height: 24),
          _buildSectionTitle(theme, loc.get('theme')),
          const SizedBox(height: 8),
          _buildThemeSection(context, theme, loc),
          const SizedBox(height: 24),
          _buildSectionTitle(theme, loc.get('about')),
          const SizedBox(height: 8),
          _buildAboutSection(context, theme, loc),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildLanguageSection(BuildContext context, ThemeData theme, AppLocalizations loc) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Card(
          child: Column(
            children: [
              RadioListTile<String>(
                title: Text(loc.get('english')),
                subtitle: const Text('English'),
                value: 'en',
                groupValue: languageProvider.locale.languageCode,
                onChanged: (value) {
                  if (value != null) languageProvider.setLanguage(value);
                },
              ),
              const Divider(height: 1),
              RadioListTile<String>(
                title: Text(loc.get('kurdish')),
                subtitle: const Text('سۆرانی'),
                value: 'ku',
                groupValue: languageProvider.locale.languageCode,
                onChanged: (value) {
                  if (value != null) languageProvider.setLanguage(value);
                },
              ),
              const Divider(height: 1),
               RadioListTile<String>(
                title: Text(loc.get('arabic')),
                subtitle: const Text('العربية'),
                value: 'ar',
                groupValue: languageProvider.locale.languageCode,
                onChanged: (value) {
                  if (value != null) languageProvider.setLanguage(value);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeSection(BuildContext context, ThemeData theme, AppLocalizations loc) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Card(
          child: Column(
            children: [
              RadioListTile<ThemeMode>(
                title: Text(loc.get('lightMode')),
                secondary: const Icon(Icons.light_mode),
                value: ThemeMode.light,
                groupValue: themeProvider.themeMode,
                onChanged: (value) {
                  if (value != null) themeProvider.setThemeMode(value);
                },
              ),
              const Divider(height: 1),
              RadioListTile<ThemeMode>(
                title: Text(loc.get('darkMode')),
                secondary: const Icon(Icons.dark_mode),
                value: ThemeMode.dark,
                groupValue: themeProvider.themeMode,
                onChanged: (value) {
                  if (value != null) themeProvider.setThemeMode(value);
                },
              ),
              const Divider(height: 1),
              RadioListTile<ThemeMode>(
                title: Text(loc.get('systemDefault')),
                secondary: const Icon(Icons.settings_brightness),
                value: ThemeMode.system,
                groupValue: themeProvider.themeMode,
                onChanged: (value) {
                  if (value != null) themeProvider.setThemeMode(value);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAboutSection(BuildContext context, ThemeData theme, AppLocalizations loc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.restaurant_menu,
                    color: theme.colorScheme.primary,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.get('appTitle'),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${loc.get('version')} 1.0.0',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              loc.get('appDescription'),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildProviderChip('Talabat', Colors.orange),
                const SizedBox(width: 8),
                _buildProviderChip('Toters', Colors.green),
                const SizedBox(width: 8),
                _buildProviderChip('Lezzo', Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderChip(String name, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        name,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
