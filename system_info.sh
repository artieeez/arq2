#!/bin/bash

OUTPUT="system_info.txt"

echo "🔧 System Information" > "$OUTPUT"
echo "=====================" >> "$OUTPUT"

# CPU
echo -e "\n🧠 CPU Info:" >> "$OUTPUT"
lscpu | grep -E 'Model name|Architecture|CPU\(s\)|Thread|Core|Socket' >> "$OUTPUT"

# RAM
echo -e "\n💾 RAM Info:" >> "$OUTPUT"
free -h | grep Mem >> "$OUTPUT"

# OS
echo -e "\n🖥️ OS Info:" >> "$OUTPUT"
lsb_release -d >> "$OUTPUT"
echo -n "Kernel: " >> "$OUTPUT"; uname -r >> "$OUTPUT"

# Disk (optional)
echo -e "\n📦 Disk Info:" >> "$OUTPUT"
lsblk -d -o name,model,size >> "$OUTPUT"

echo -e "\n✅ Saved to $OUTPUT"
