#!/bin/bash

# Create proper directory structure
echo "Creating directory structure..."
mkdir -p client/src/{components/ui,hooks,lib,pages}
mkdir -p server db shared scripts

# Move client files
echo "Moving client files..."
mv index.html client/ 2>/dev/null || true
mv manifest.json client/ 2>/dev/null || true

# Move main React files
mv App.tsx main.tsx index.css client/src/ 2>/dev/null || true

# Move page components
mv auth-page.tsx BloodPressure.tsx BowelMovements.tsx Calendar.tsx DeviceConnections.tsx client/src/pages/ 2>/dev/null || true
mv Doctors.tsx EmergencyInfo.tsx GlucoseInsulin.tsx Home.tsx Meals.tsx client/src/pages/ 2>/dev/null || true
mv Medications.tsx Notes.tsx NotificationSettings.tsx Pharmacies.tsx client/src/pages/ 2>/dev/null || true
mv reset-password.tsx Sleep.tsx not-found.tsx client/src/pages/ 2>/dev/null || true
mv Medications.tsx.fixed client/src/pages/ 2>/dev/null || true

# Move hooks
mv use-*.tsx client/src/hooks/ 2>/dev/null || true
mv use-*.ts client/src/hooks/ 2>/dev/null || true

# Move lib files
mv queryClient.ts pinStorage.ts protected-route.tsx types.ts utils.ts client/src/lib/ 2>/dev/null || true

# Move UI components to ui folder
mv accordion.tsx alert*.tsx aspect-ratio.tsx avatar.tsx badge.tsx client/src/components/ui/ 2>/dev/null || true
mv breadcrumb.tsx button.tsx card.tsx carousel.tsx chart.tsx checkbox.tsx client/src/components/ui/ 2>/dev/null || true
mv collapsible.tsx command.tsx context-menu.tsx dialog.tsx drawer.tsx client/src/components/ui/ 2>/dev/null || true
mv dropdown-menu.tsx form.tsx hover-card.tsx input*.tsx label.tsx client/src/components/ui/ 2>/dev/null || true
mv menubar.tsx navigation-menu.tsx pagination.tsx popover.tsx progress.tsx client/src/components/ui/ 2>/dev/null || true
mv radio-group.tsx resizable.tsx scroll-area.tsx select.tsx separator.tsx client/src/components/ui/ 2>/dev/null || true
mv sheet.tsx sidebar.tsx skeleton.tsx slider.tsx switch.tsx table.tsx client/src/components/ui/ 2>/dev/null || true
mv tabs.tsx textarea.tsx toast*.tsx toggle*.tsx tooltip.tsx client/src/components/ui/ 2>/dev/null || true
mv character-count.tsx client/src/components/ui/ 2>/dev/null || true

# Move custom components
mv *Modal.tsx Dashboard.tsx Header.tsx BottomNavigation.tsx* client/src/components/ 2>/dev/null || true
mv CareRecipientTabs.tsx PageHeader.tsx StatusCard.tsx AddToDesktopButton.tsx client/src/components/ 2>/dev/null || true

# Move server files
mv index.ts vite.ts routes.ts* auth.ts email-service.ts server/ 2>/dev/null || true
mv notification-service.ts storage.ts types.d.ts webauthn.ts medicationService.ts server/ 2>/dev/null || true

# Move shared files
mv schema.ts shared/ 2>/dev/null || true

# Move database files
mv seed*.ts init-database.js db/ 2>/dev/null || true
mv tables.sql scripts/ 2>/dev/null || true

# Check if files are in place
echo "Checking structure..."
ls -la client/
ls -la client/src/
ls -la server/
ls -la shared/
ls -la db/

# Install dependencies and build
echo "Installing dependencies..."
npm install --legacy-peer-deps

echo "Building application..."
npm run build