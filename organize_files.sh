#!/bin/bash

# Verzeichnis, in dem die Dateien liegen
SOURCE_DIR="./"  # Passe dies an, falls die Dateien in einem anderen Verzeichnis liegen
TARGET_DIR="./entry"  # Zielverzeichnis für die neue Struktur

# Schleife über alle Markdown-Dateien im Quellverzeichnis
for file in "$SOURCE_DIR"*.md; do
  # Überprüfen, ob Dateien existieren
  [ -e "$file" ] || continue

  # Extrahiere den Zeitstempel (Format: YYYY-MM-DD) aus dem Dateinamen
  filename=$(basename "$file")
  date=$(echo "$filename" | grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2}')

  # Wenn kein Datum gefunden wurde, überspringe diese Datei
  if [ -z "$date" ]; then
    echo "Kein Datum gefunden in: $filename"
    continue
  fi

  # Extrahiere Jahr, Monat und Tag aus dem Zeitstempel
  year=$(echo "$date" | cut -d'-' -f1)
  month=$(echo "$date" | cut -d'-' -f2)
  day=$(echo "$date" | cut -d'-' -f3)

  # Entferne den Zeitstempel aus dem Dateinamen
  new_filename=$(echo "$filename" | sed "s/^$date-//")

  # Erstelle das Zielverzeichnis (Jahr/Monat/Tag), falls es nicht existiert
  target_path="$TARGET_DIR/$year/$month/$day"
  mkdir -p "$target_path"

  # Verschiebe die Datei in das Zielverzeichnis mit dem neuen Namen
  mv "$file" "$target_path/$new_filename"

  echo "Verschoben: $filename -> $target_path/$new_filename"
done

echo "Alle Dateien wurden verarbeitet."