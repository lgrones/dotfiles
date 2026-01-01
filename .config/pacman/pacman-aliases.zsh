#!/usr/bin/env zsh

pacman() {
  case "$1" in
    rm)
      shift
      command sudo pacman -Rs "$@"
      ;;
    i)
      shift
      command sudo pacman -S "$@"
      ;; 
	up)
      shift
      command sudo pacman -Syu && pacman -Qdtq | pacman -Rns -
      ;;
	check)
      shift
      command checkupdates
      ;;
	clean)
      shift
      command pacman -Qdtq | pacman -Rns -
      ;;
	search)
      shift
      command pacman -Ss "$@"
      ;;
	ls)
      shift
      command pacman -Qs "$@"
      ;;
	help)
      echo "pacman aliases:"
      echo "  i       : install packages"
      echo "  rm      : remove packages"
      echo "  up      : update system and remove orphans"
      echo "  check   : list available updates"
      echo "  clean   : remove orphaned packages"
      echo "  search  : search packages"
      echo "  ls      : list installed packages"
      echo "  *       : fallback to regular pacman"
      ;;
    *)
      command pacman "$@"
      ;;
  esac
}