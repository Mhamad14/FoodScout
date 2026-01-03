Write-Host "Starting Backend..."
Start-Process -FilePath "npm" -ArgumentList "start" -WorkingDirectory "backend" -WindowStyle Minimized
Write-Host "Starting Flutter..."
flutter run -d chrome
