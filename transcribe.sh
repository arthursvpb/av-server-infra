#!/bin/bash

BASE_PATH="/media/hdd/your-path-here"

source ~/whisper-env/bin/activate

mkdir -p ./transcription-logs

for MODULE_PATH in "$BASE_PATH"/*/; do
    [ -d "$MODULE_PATH" ] || continue
    MODULE="$(basename "$MODULE_PATH")"

    echo "🔷 Processing module: $MODULE"

    temp_file="${MODULE_PATH}/temp_transcript.txt"
    final_prefix="${MODULE_PATH}/transcript"

    mkdir -p "${MODULE_PATH}/transcripts"

    if ls "${MODULE_PATH}"/transcript*.txt 1>/dev/null 2>&1; then
        echo "🟡 Final transcript exists for $MODULE. Skipping module."
        rm -f "$temp_file"
        continue
    fi

    rm -f "$temp_file"

    find "$MODULE_PATH" -type f -iname "*.mp4" | sort | while read -r video; do
        base_name="$(basename "${video%.*}")"
        out_txt="${MODULE_PATH}/transcripts/${base_name}.txt"

        if [ -f "$out_txt" ]; then
            echo "⏩ Transcript already exists for: $base_name. Skipping."
            cat "$out_txt" >>"$temp_file"
            echo -e "\n\n" >>"$temp_file"
            continue
        fi

        echo "🔸 Transcribing: $video"

        python3 ~/transcribe_with_faster_whisper.py "$video" "$out_txt" pt

        if [ -f "$out_txt" ]; then
            cat "$out_txt" >>"$temp_file"
            echo -e "\n\n" >>"$temp_file"
        else
            echo "❌ Failed: $video"
        fi
    done

    if [ -f "$temp_file" ]; then
        word_count=$(wc -w <"$temp_file")
        if [ "$word_count" -le 10000 ]; then
            mv "$temp_file" "${final_prefix}.txt"
        else
            echo "⚡ Splitting transcript..."
            split -d -C 60000 --additional-suffix=.txt "$temp_file" "${final_prefix}-"
            rm "$temp_file"
        fi
    fi

    echo "✅ Done with module: $MODULE"

done

echo "🎉 All modules processed!"
