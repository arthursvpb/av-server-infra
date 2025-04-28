import sys
from pathlib import Path
from faster_whisper import WhisperModel

if len(sys.argv) < 4:
    print("Usage: transcribe_with_faster_whisper.py <video_path> <output_path> <language>")
    sys.exit(1)

video_path = sys.argv[1]
output_path = sys.argv[2]
language = sys.argv[3]

model = WhisperModel("tiny", device="cpu", compute_type="int8")

segments, _ = model.transcribe(video_path, language=language, beam_size=5, vad_filter=True)

output_file = Path(output_path)
output_file.parent.mkdir(parents=True, exist_ok=True)

with open(output_file, "w", encoding="utf-8") as f:
    for segment in segments:
        f.write(f"{segment.text.strip()}\n")
