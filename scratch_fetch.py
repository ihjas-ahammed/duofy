import urllib.request

url = "https://raw.githubusercontent.com/hlwhl/webview_cef/master/third/download.cmake"
try:
    response = urllib.request.urlopen(url)
    content = response.read().decode('utf-8')
    print(f"Length of content: {len(content)}")
    with open("download.cmake", "w", encoding="utf-8") as f:
        f.write(content)
    print("Success")
except Exception as e:
    print(f"Error: {e}")
