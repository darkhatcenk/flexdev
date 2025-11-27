#!/bin/bash

###############################################################################
# FlexDEV CloudFlex White-Label Deployment Script
# 
# Bu script production sunucusunda çalıştırılmalıdır.
# Sidebar'dan version, Upgrade, Sponsor us ve Feedback linklerini kaldırır.
###############################################################################

set -e  # Hata durumunda dur

echo "=========================================="
echo "FlexDEV CloudFlex Deployment"
echo "=========================================="
echo ""

# Renk kodları
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Proje dizinini kontrol et
if [ ! -f "composer.json" ]; then
    echo -e "${RED}HATA: Bu script FlexDEV proje dizininde çalıştırılmalıdır!${NC}"
    exit 1
fi

echo -e "${YELLOW}1. Git'ten son değişiklikleri çekiyorum...${NC}"
git fetch origin
git pull origin main
echo -e "${GREEN}✓ Git pull tamamlandı${NC}"
echo ""

echo -e "${YELLOW}2. Değiştirilen dosyalar:${NC}"
echo "   - resources/views/components/navbar.blade.php (UI değişiklikleri)"
echo "   - package-lock.json (npm dependencies)"
echo "   - Yeni dokümantasyon dosyaları"
echo ""

echo -e "${YELLOW}3. Frontend dependencies yükleniyor...${NC}"
if command -v npm &> /dev/null; then
    npm install
    echo -e "${GREEN}✓ npm install tamamlandı${NC}"
else
    echo -e "${RED}⚠ npm bulunamadı, atlanıyor...${NC}"
fi
echo ""

echo -e "${YELLOW}4. Frontend build yapılıyor...${NC}"
if command -v npm &> /dev/null; then
    npm run build
    echo -e "${GREEN}✓ Frontend build tamamlandı${NC}"
else
    echo -e "${RED}⚠ npm bulunamadı, atlanıyor...${NC}"
fi
echo ""

echo -e "${YELLOW}5. PHP dependencies yükleniyor (production mode)...${NC}"
if command -v composer &> /dev/null; then
    composer install --no-dev --prefer-dist --optimize-autoloader --no-interaction
    echo -e "${GREEN}✓ Composer install tamamlandı${NC}"
else
    echo -e "${RED}⚠ composer bulunamadı, atlanıyor...${NC}"
fi
echo ""

echo -e "${YELLOW}6. Laravel cache'leri temizleniyor...${NC}"
if command -v php &> /dev/null; then
    php artisan cache:clear
    php artisan config:clear
    php artisan route:clear
    php artisan view:clear
    echo -e "${GREEN}✓ Cache'ler temizlendi${NC}"
else
    echo -e "${RED}⚠ php bulunamadı, atlanıyor...${NC}"
fi
echo ""

echo -e "${YELLOW}7. Laravel optimize ediliyor...${NC}"
if command -v php &> /dev/null; then
    php artisan optimize
    php artisan config:cache
    php artisan route:cache
    php artisan view:cache
    echo -e "${GREEN}✓ Laravel optimize tamamlandı${NC}"
else
    echo -e "${RED}⚠ php bulunamadı, atlanıyor...${NC}"
fi
echo ""

echo -e "${YELLOW}8. Dosya izinleri ayarlanıyor...${NC}"
if [ -d "storage" ] && [ -d "bootstrap/cache" ]; then
    chmod -R 775 storage bootstrap/cache
    echo -e "${GREEN}✓ İzinler ayarlandı${NC}"
else
    echo -e "${RED}⚠ storage veya bootstrap/cache dizini bulunamadı${NC}"
fi
echo ""

echo -e "${YELLOW}9. Web server restart (opsiyonel)...${NC}"
echo "   Aşağıdaki komutlardan uygun olanını manuel çalıştırın:"
echo "   - sudo systemctl restart php8.2-fpm"
echo "   - sudo systemctl restart php8.3-fpm"
echo "   - sudo systemctl reload nginx"
echo "   - sudo systemctl reload apache2"
echo ""

echo "=========================================="
echo -e "${GREEN}✓ DEPLOYMENT TAMAMLANDI!${NC}"
echo "=========================================="
echo ""
echo "Yapılan değişiklikler:"
echo "  ✓ Sidebar'dan version numarası kaldırıldı"
echo "  ✓ 'Upgrade' linki kaldırıldı"
echo "  ✓ 'Sponsor us' linki kaldırıldı"
echo "  ✓ 'Feedback' modal kaldırıldı"
echo "  ✓ Frontend assets build edildi"
echo "  ✓ Laravel optimize edildi"
echo ""
echo "Test etmeniz gerekenler:"
echo "  1. Sidebar'da version numarası görünmemeli"
echo "  2. Sidebar'da Upgrade/Sponsor/Feedback linkleri olmamalı"
echo "  3. Tüm menü itemları çalışmalı"
echo "  4. Dark mode çalışmalı"
echo "  5. Responsive tasarım çalışmalı"
echo ""
echo "Dokümantasyon:"
echo "  - BUILD_INSTRUCTIONS.md"
echo "  - SIDEBAR_CLEANUP_SUMMARY.md"
echo "  - WHITE_LABEL_CHANGES.md"
echo "  - FINAL_BUILD_SUMMARY.md"
echo ""
