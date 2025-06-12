import fs from 'fs';
import path from 'path';

// Create directory structure
const dirs = [
  'client/src/components/ui',
  'client/src/hooks',
  'client/src/lib',
  'client/src/pages',
  'server',
  'db',
  'shared',
  'scripts'
];

dirs.forEach(dir => {
  fs.mkdirSync(dir, { recursive: true });
});

// Move files to correct locations
const moves = [
  // Client files
  { from: 'index.html', to: 'client/index.html' },
  { from: 'manifest.json', to: 'client/manifest.json' },
  
  // Main React files
  { from: 'App.tsx', to: 'client/src/App.tsx' },
  { from: 'main.tsx', to: 'client/src/main.tsx' },
  { from: 'index.css', to: 'client/src/index.css' },
  
  // Page components
  { from: 'auth-page.tsx', to: 'client/src/pages/auth-page.tsx' },
  { from: 'BloodPressure.tsx', to: 'client/src/pages/BloodPressure.tsx' },
  { from: 'BowelMovements.tsx', to: 'client/src/pages/BowelMovements.tsx' },
  { from: 'Calendar.tsx', to: 'client/src/pages/Calendar.tsx' },
  { from: 'DeviceConnections.tsx', to: 'client/src/pages/DeviceConnections.tsx' },
  { from: 'Doctors.tsx', to: 'client/src/pages/Doctors.tsx' },
  { from: 'EmergencyInfo.tsx', to: 'client/src/pages/EmergencyInfo.tsx' },
  { from: 'GlucoseInsulin.tsx', to: 'client/src/pages/GlucoseInsulin.tsx' },
  { from: 'Home.tsx', to: 'client/src/pages/Home.tsx' },
  { from: 'Meals.tsx', to: 'client/src/pages/Meals.tsx' },
  { from: 'Medications.tsx', to: 'client/src/pages/Medications.tsx' },
  { from: 'Notes.tsx', to: 'client/src/pages/Notes.tsx' },
  { from: 'NotificationSettings.tsx', to: 'client/src/pages/NotificationSettings.tsx' },
  { from: 'Pharmacies.tsx', to: 'client/src/pages/Pharmacies.tsx' },
  { from: 'reset-password.tsx', to: 'client/src/pages/reset-password.tsx' },
  { from: 'Sleep.tsx', to: 'client/src/pages/Sleep.tsx' },
  { from: 'not-found.tsx', to: 'client/src/pages/not-found.tsx' },
  
  // Hooks
  { from: 'use-auth.tsx', to: 'client/src/hooks/use-auth.tsx' },
  { from: 'use-care-recipient.tsx', to: 'client/src/hooks/use-care-recipient.tsx' },
  { from: 'use-emergency-auth.tsx', to: 'client/src/hooks/use-emergency-auth.tsx' },
  { from: 'use-mobile.tsx', to: 'client/src/hooks/use-mobile.tsx' },
  { from: 'use-pin-auth.tsx', to: 'client/src/hooks/use-pin-auth.tsx' },
  { from: 'use-toast.ts', to: 'client/src/hooks/use-toast.ts' },
  
  // Lib files
  { from: 'queryClient.ts', to: 'client/src/lib/queryClient.ts' },
  { from: 'pinStorage.ts', to: 'client/src/lib/pinStorage.ts' },
  { from: 'protected-route.tsx', to: 'client/src/lib/protected-route.tsx' },
  { from: 'types.ts', to: 'client/src/lib/types.ts' },
  { from: 'utils.ts', to: 'client/src/lib/utils.ts' },
  
  // Server files
  { from: 'index.ts', to: 'server/index.ts' },
  { from: 'vite.ts', to: 'server/vite.ts' },
  { from: 'routes.ts', to: 'server/routes.ts' },
  { from: 'auth.ts', to: 'server/auth.ts' },
  { from: 'email-service.ts', to: 'server/email-service.ts' },
  { from: 'notification-service.ts', to: 'server/notification-service.ts' },
  { from: 'storage.ts', to: 'server/storage.ts' },
  { from: 'types.d.ts', to: 'server/types.d.ts' },
  { from: 'webauthn.ts', to: 'server/webauthn.ts' },
  { from: 'medicationService.ts', to: 'server/medicationService.ts' },
  
  // Shared files
  { from: 'schema.ts', to: 'shared/schema.ts' },
  
  // Database files
  { from: 'seed.ts', to: 'db/seed.ts' },
  { from: 'seed-emergency.ts', to: 'db/seed-emergency.ts' },
  { from: 'seed-medications.ts', to: 'db/seed-medications.ts' },
  { from: 'seed-simple.ts', to: 'db/seed-simple.ts' },
  { from: 'init-database.js', to: 'db/init-database.js' },
  
  // Scripts
  { from: 'tables.sql', to: 'scripts/tables.sql' },
  
  // Replace vite config
  { from: 'vite.config.prod.ts', to: 'vite.config.ts' }
];

// UI components to move
const uiComponents = [
  'accordion.tsx', 'alert-dialog.tsx', 'alert.tsx', 'aspect-ratio.tsx', 'avatar.tsx',
  'badge.tsx', 'breadcrumb.tsx', 'button.tsx', 'card.tsx', 'carousel.tsx', 'chart.tsx',
  'checkbox.tsx', 'collapsible.tsx', 'command.tsx', 'context-menu.tsx', 'dialog.tsx',
  'drawer.tsx', 'dropdown-menu.tsx', 'form.tsx', 'hover-card.tsx', 'input-otp.tsx',
  'input.tsx', 'label.tsx', 'menubar.tsx', 'navigation-menu.tsx', 'pagination.tsx',
  'popover.tsx', 'progress.tsx', 'radio-group.tsx', 'resizable.tsx', 'scroll-area.tsx',
  'select.tsx', 'separator.tsx', 'sheet.tsx', 'sidebar.tsx', 'skeleton.tsx', 'slider.tsx',
  'switch.tsx', 'table.tsx', 'tabs.tsx', 'textarea.tsx', 'toast.tsx', 'toaster.tsx',
  'toggle-group.tsx', 'toggle.tsx', 'tooltip.tsx', 'character-count.tsx'
];

uiComponents.forEach(file => {
  moves.push({ from: file, to: `client/src/components/ui/${file}` });
});

// Custom components to move
const customComponents = [
  'AddBowelMovementModal.tsx', 'AddCareEventModal.tsx', 'AddMealModal.tsx', 'AddMedicationModal.tsx',
  'AddSleepModal.tsx', 'AddToDesktopButton.tsx', 'AddUrinationModal.tsx', 'Dashboard.tsx',
  'Header.tsx', 'BottomNavigation.tsx', 'CareRecipientTabs.tsx', 'PageHeader.tsx',
  'StatusCard.tsx', 'EditBowelMovementModal.tsx', 'EditGlucoseInsulinModal.tsx',
  'EditMealModal.tsx', 'EditMedicationModal.tsx', 'EditMedicationSchedulesModal.tsx',
  'EditUrinationModal.tsx', 'MedicationInventoryModal.tsx', 'UserSettingsModal.tsx',
  'PasswordVerificationModal.tsx'
];

customComponents.forEach(file => {
  moves.push({ from: file, to: `client/src/components/${file}` });
});

// Perform moves
moves.forEach(({ from, to }) => {
  try {
    if (fs.existsSync(from)) {
      fs.renameSync(from, to);
      console.log(`Moved ${from} to ${to}`);
    }
  } catch (err) {
    console.log(`Could not move ${from}: ${err.message}`);
  }
});

console.log('File organization complete');