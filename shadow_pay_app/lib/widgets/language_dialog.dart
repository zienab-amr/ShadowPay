import 'package:shadow_pay_app/l10n/app_localizations.dart';
import 'package:shadow_pay_app/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  


class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Dialog(
      backgroundColor: const Color(0xFF141A2B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localizations.select_language,  
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            _LanguageOption(
              language: 'English',
              code: 'en',
              icon: Icons.language,
            ),
            const SizedBox(height: 10),
            _LanguageOption(
              language: 'العربية',
              code: 'ar',
              icon: Icons.language,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF00D8A2),
              ),
              child: Text(
                localizations.cancel,  // 👈 "إلغاء" أو "Cancel"
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String language;
  final String code;
  final IconData icon;

  const _LanguageOption({
    required this.language,
    required this.code,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isSelected = languageProvider.locale.languageCode == code;

    return InkWell(
      onTap: () {
        languageProvider.changeLanguage(code);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected 
              ? const Color(0xFF00D8A2).withOpacity(0.1)
              : Colors.transparent,
          border: Border.all(
            color: isSelected 
                ? const Color(0xFF00D8A2)
                : Colors.white24,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon, 
              color: isSelected 
                  ? const Color(0xFF00D8A2)
                  : Colors.white70,
            ),
            const SizedBox(width: 12),
            Text(
              language,
              style: TextStyle(
                fontSize: 16,
                color: isSelected 
                    ? Colors.white
                    : Colors.white70,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isSelected) ...[
              const Spacer(),
              const Icon(
                Icons.check_circle,
                color: Color(0xFF00D8A2),
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}