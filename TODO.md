# Flutter Analyze Issues Fix Plan

## Summary

- Total issues: 174
- Main categories: deprecations, style warnings, file naming

## Tasks

- [ ] Replace all .withOpacity() with .withValues(alpha: ) (115 instances)
- [ ] Update constructors to use super parameters
- [ ] Rename files to lower_case_with_underscores
- [ ] Replace 'value' with 'initialValue' in TextFormField
- [ ] Replace MaterialStateProperty with WidgetStateProperty
- [ ] Fix deprecated icons (exchangeAlt -> rightLeft, cog -> gear, checkCircle -> circleCheck)
- [ ] Fix Table.fromTextArray deprecation
- [ ] Fix use_build_context_synchronously warnings
- [ ] Remove unnecessary underscores
- [ ] Fix unused variables
- [ ] Fix unnecessary toList in spreads
- [ ] Run flutter analyze to verify fixes
