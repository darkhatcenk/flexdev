# FlexDEV Build Instructions

This document provides step-by-step instructions for building and optimizing FlexDEV for production deployment.

## Prerequisites

- Node.js 18+ and npm (or pnpm/yarn)
- PHP 8.2+ with required extensions
- Composer 2.x
- Git

## Build Process

### 1. Frontend Build

The frontend uses Vite for building assets.

```bash
# Install dependencies
npm install

# Build for production
npm run build
```

**Expected Output:**
- Assets generated in `public/build/`
- Manifest file: `public/build/manifest.json`
- CSS and JS bundles with hashed filenames
- Font files copied to build directory

**Build Time:** ~1-2 seconds  
**Status:** ✅ Completed successfully (as of 2025-11-27)

### 2. PHP Dependencies

Install PHP dependencies optimized for production.

```bash
composer install --no-dev --prefer-dist --optimize-autoloader
```

**Flags explained:**
- `--no-dev`: Skip development dependencies
- `--prefer-dist`: Download distribution packages (faster)
- `--optimize-autoloader`: Generate optimized autoloader

### 3. Laravel Optimization

Run Laravel's built-in optimization commands.

```bash
# Clear and optimize all caches
php artisan optimize

# Cache configuration
php artisan config:cache

# Cache routes
php artisan route:cache

# Cache views (Blade templates)
php artisan view:cache
```

**What these commands do:**
- `optimize`: Runs multiple optimization tasks
- `config:cache`: Combines all config files into single cached file
- `route:cache`: Compiles routes for faster lookup
- `view:cache`: Pre-compiles Blade templates

### 4. File Permissions (Production Server)

Ensure proper permissions for Laravel directories:

```bash
# Storage and cache directories
chmod -R 775 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache
```

## Development Build

For local development, use:

```bash
# Frontend dev server with hot reload
npm run dev

# Laravel development server
php artisan serve
```

## Verification

After building, verify:

1. **Frontend Assets:**
   ```bash
   ls -la public/build/
   # Should show manifest.json and asset files
   ```

2. **Laravel Caches:**
   ```bash
   ls -la bootstrap/cache/
   # Should show config.php, routes-v7.php, etc.
   ```

3. **Autoloader:**
   ```bash
   ls -la vendor/composer/
   # Should show autoload_classmap.php with optimized entries
   ```

## Troubleshooting

### Frontend Build Fails

```bash
# Clear node_modules and reinstall
rm -rf node_modules package-lock.json
npm install
npm run build
```

### Laravel Cache Issues

```bash
# Clear all caches
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

# Then rebuild
php artisan optimize
```

### Permission Errors

```bash
# Fix storage permissions
sudo chown -R $USER:www-data storage bootstrap/cache
sudo chmod -R 775 storage bootstrap/cache
```

## Production Deployment Checklist

- [ ] Run `npm run build` (frontend)
- [ ] Run `composer install --no-dev --prefer-dist --optimize-autoloader`
- [ ] Run `php artisan optimize`
- [ ] Run `php artisan config:cache`
- [ ] Run `php artisan route:cache`
- [ ] Run `php artisan view:cache`
- [ ] Set proper file permissions
- [ ] Configure `.env` for production
- [ ] Set `APP_ENV=production` and `APP_DEBUG=false`
- [ ] Configure web server (Nginx/Apache)
- [ ] Set up SSL certificate
- [ ] Configure database connection
- [ ] Run database migrations (if needed): `php artisan migrate --force`
- [ ] Set up queue workers (if using queues)
- [ ] Configure cron for scheduled tasks

## Environment-Specific Notes

### Docker Deployment

If deploying with Docker, these commands should be run:
- During image build (Dockerfile)
- Or as part of container startup script

### CI/CD Pipeline

Include these steps in your CI/CD pipeline:
1. Install dependencies (npm, composer)
2. Run tests
3. Build frontend assets
4. Optimize Laravel
5. Deploy to server

## Build Artifacts

After successful build, these directories contain production-ready files:

- `public/build/` - Frontend assets (CSS, JS, fonts)
- `vendor/` - PHP dependencies
- `bootstrap/cache/` - Laravel cached files
- `storage/framework/cache/` - Application cache

## Version Information

- **FlexDEV Version:** Based on Coolify v4.0.0-beta.448
- **Laravel Version:** Check `composer.json`
- **Node Version:** 18+ recommended
- **PHP Version:** 8.2+ required

## Last Build

- **Date:** 2025-11-27
- **Frontend Build:** ✅ Success (1.40s)
- **Laravel Optimization:** Documented (requires PHP environment)
- **Changes:** Sidebar branding cleanup for CloudFlex white-label

## Support

For build issues:
1. Check this documentation
2. Review error messages carefully
3. Ensure all prerequisites are installed
4. Check file permissions
5. Verify environment configuration

## Related Documentation

- `WHITE_LABEL_CHANGES.md` - UI customization changes
- `SIDEBAR_CLEANUP_SUMMARY.md` - Detailed sidebar modifications
- `README.md` - General project information
- `RELEASE.md` - Release process guide
