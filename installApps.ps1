<powershell>

# Install Chrome
Invoke-WebRequest -Uri "https://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile "chrome.exe"
Start-Process -FilePath "chrome.exe" -Args "/silent" -Wait