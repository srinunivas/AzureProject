Add-WindowsFeature Web-Server
Set-Content -Path "C:\\inetpub\\wwwroot\\index.html" -Value "<html><body><h1>Hello, World!</h1></body></html>"
Start-Service W3SVC
Write-Output 'This is some example data for file1.' | Out-File -FilePath C:\file1.txt
Write-Output 'This is some example data for file2.' | Out-File -FilePath C:\file2.txt
Invoke-WebRequest -Uri "https://dlptest.com/sample-data.pdf" -OutFile "C:\PII-sample-data.pdf"