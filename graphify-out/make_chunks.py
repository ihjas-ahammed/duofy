import json
from pathlib import Path

# Load uncached files
uncached = Path("graphify-out/.graphify_uncached.txt").read_text(encoding="utf-8-sig").splitlines()
uncached = [f.strip() for f in uncached if f.strip()]

text_files = []
image_files = []

for f in uncached:
    path = Path(f)
    ext = path.suffix.lower()
    if ext in ['.png', '.jpg', '.jpeg', '.gif', '.ico', '.bmp', '.webp']:
        image_files.append(f)
    else:
        text_files.append(f)

# Sort text files by directory to keep related files together
text_files.sort(key=lambda x: str(Path(x).parent))

# Split text files into chunks of 25
chunk_size = 25
text_chunks = [text_files[i:i + chunk_size] for i in range(0, len(text_files), chunk_size)]

print(f"Total text files: {len(text_files)} -> split into {len(text_chunks)} chunks.")
print(f"Total image files: {len(image_files)} -> will pre-populate with empty chunks.")

# Write text chunks manifest
with open("graphify-out/text_chunks.json", "w", encoding="utf-8") as f:
    json.dump(text_chunks, f, indent=2, ensure_ascii=False)

# Total chunks count (text chunks + image chunks)
total_chunks = len(text_chunks) + len(image_files)

# Pre-populate empty chunk files for images
for idx, img in enumerate(image_files):
    chunk_num = len(text_chunks) + idx + 1
    chunk_path = Path(f"graphify-out/.graphify_chunk_{chunk_num:02d}.json")
    empty_data = {
        "nodes": [],
        "edges": [],
        "hyperedges": [],
        "input_tokens": 0,
        "output_tokens": 0
    }
    chunk_path.write_text(json.dumps(empty_data), encoding="utf-8")

print(f"Pre-populated {len(image_files)} empty image chunk files starting from chunk {len(text_chunks) + 1} to {total_chunks}.")
