#!/usr/bin/env bash
# img2webp.sh <src> <out.webp> [quality]
#
# 이미지를 색 관리(color-managed)된 webp로 변환한다.
# - macOS: sips(Apple ImageIO)로 HDR/Display P3 -> sRGB 톤매핑 후 cwebp.
#          HEIC의 PQ + gain map을 제대로 처리해서 색빠짐을 막는다.
# - 그 외: ImageMagick으로 임베드 프로파일을 sRGB로 변환.
set -euo pipefail

src="${1:?src 인자 필요}"
out="${2:?out 인자 필요}"
q="${3:-80}"

os="$(uname -s)"

convert_macos() {
  local srgb="/System/Library/ColorSync/Profiles/sRGB Profile.icc"
  local tmp
  tmp="$(mktemp -t img2webp).png"
  # -m: matchToProfile = 임베드 프로파일을 읽어 sRGB로 실제 색 변환(톤매핑 포함)
  if sips -m "$srgb" -s format png "$src" --out "$tmp" >/dev/null 2>&1; then
    if command -v cwebp >/dev/null 2>&1; then
      cwebp -quiet -q "$q" -metadata icc "$tmp" -o "$out"
    else
      magick "$tmp" -quality "$q" "webp:$out"
    fi
    rm -f "$tmp"
    return 0
  fi
  rm -f "$tmp"
  return 1
}

convert_other() {
  # 임베드 프로파일이 있으면 sRGB로 변환, 없으면 sRGB로 간주.
  # -strip 으로 떼지 말고 실제 변환을 수행하는 것이 핵심.
  magick "$src" -colorspace sRGB -quality "$q" "webp:$out"
}

if [ "$os" = "Darwin" ] && command -v sips >/dev/null 2>&1; then
  convert_macos || convert_other
else
  convert_other
fi
