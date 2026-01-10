#!/usr/bin/env zsh

pm() {
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
      command sudo pacman -Syu && pm clean
      ;;
	check)
      shift
      command checkupdates
      ;;
	clean)
      shift
      command sudo pacman -Qdtq | ifne sudo pacman -Rns -
      ;;
	search)
      shift
      command pacman -Ss "$@"
      ;;
	ls)
      shift
      command pacman -Qe
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