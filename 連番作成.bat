ECHO OFF

setlocal enabledelayedexpansion
chcp 65001

cd ~dp0

ffmpeg -i "%~nx1" -compression_level 10 -pred mixed -pix_fmt rgb24 -sws_flags +accurate_rnd+full_chroma_int input_frames/%%06d.png

pause
 
echo 終了しました。