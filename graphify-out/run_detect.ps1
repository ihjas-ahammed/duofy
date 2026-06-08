$py = Get-Content graphify-out\.graphify_python
& $py graphify-out\detect.py | Out-File -FilePath graphify-out\.graphify_detect.json -Encoding utf8
