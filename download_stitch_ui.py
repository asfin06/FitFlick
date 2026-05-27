import json
import urllib.request
import os

input_file = r"C:\Users\ACER\.gemini\antigravity\brain\79ef0117-0ecc-48c8-a573-f2334dfacc31\.system_generated\steps\25\output.txt"
out_dir = r"c:\Users\ACER\OneDrive\Desktop\Project\fitflick\stitch_ui"
os.makedirs(out_dir, exist_ok=True)

with open(input_file, "r", encoding="utf-8") as f:
    data = json.load(f)

for screen in data.get("screens", []):
    title = screen.get("title", "Unnamed_Screen").replace(" ", "_")
    
    html_code = screen.get("htmlCode", {})
    url = html_code.get("downloadUrl")
    if not url:
        print(f"Skipping {title}, no htmlCode or downloadUrl present.")
        continue
        
    out_file = os.path.join(out_dir, f"{title}.html")
    print(f"Downloading {title}...")
    
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    try:
        with urllib.request.urlopen(req) as response:
            html_content = response.read()
            with open(out_file, "wb") as html_f:
                html_f.write(html_content)
        print(f"Saved to {out_file}")
    except Exception as e:
        print(f"Failed to download {title}: {e}")
