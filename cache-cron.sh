#!/bin/bash
export PATH="/opt/homebrew/bin:$PATH"

brew update
brew upgrade
brew autoremove
brew cleanup

# macOS 캐시/로그 정리 
rm -rf ~/Library/Caches/*
rm -rf ~/Library/Logs/*

# Xcode 빌드 캐시 정리 
rm -rf ~/Library/Developer/Xcode/DerivedData/*

# pip 캐시 정리 
rm -rf ~/Library/Caches/pip/*

# npm 캐시 정리 
npm cache clean --force
pnpm store prune
