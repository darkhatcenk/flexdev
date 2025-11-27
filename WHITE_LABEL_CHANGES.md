# CloudFlex White-Label Changes

This document tracks UI and branding modifications made for the CloudFlex white-label version of FlexDEV.

## 2025-11-27 - Sidebar Branding Cleanup

### Changes Made

**UI: Hide sidebar version label and remove Upgrade/Sponsor/Feedback links**

Modified `resources/views/components/navbar.blade.php`:

1. **Removed Version Label**
   - Removed `<x-version />` component from under the FlexDEV logo
   - The logo remains visible, but the version number (e.g., "v4.0.0-beta.448") is no longer displayed

2. **Removed Bottom-Left Links**
   - Removed "Upgrade" section (`livewire:upgrade` component)
   - Removed "Sponsor us" link (pointing to flexdev.io/sponsorships)
   - Removed "Feedback" modal (help/feedback form)

### Rationale

These changes support CloudFlex's white-label requirements by:
- Removing version information that may not be relevant to end users
- Removing upstream project sponsorship/funding links
- Streamlining the sidebar to focus on core functionality

### Files Modified

- `resources/views/components/navbar.blade.php` - Main sidebar navigation component

### Navigation Preserved

All core navigation items remain functional:
- Dashboard
- Projects
- Servers
- Sources
- Destinations
- S3 Storages
- Shared Variables
- Notifications
- Keys & Tokens
- Tags
- Terminal (if authorized)
- Profile
- Teams
- Subscription (if applicable)
- Settings (if admin)
- Admin (if admin)
- Logout

### Testing

After these changes:
- ✅ Sidebar displays FlexDEV logo without version text
- ✅ All main navigation items work correctly
- ✅ No "Upgrade", "Sponsor us", or "Feedback" links visible
- ✅ No layout glitches or spacing issues
- ✅ Responsive design maintained on mobile and desktop
