#!/usr/bin/env zsh

pm() {
  case "$1" in
    i)
      shift
      command yay -S "$@"
      ;; 
    rm)
      shift
      command yay -Rns "$@"
      ;;
	up)
      shift
      command yay -Syu && pm cln
      ;;
	chk)
      shift
      command checkupdates && yay -Qua
      ;;
	cln)
      shift
      command yay -Qdtq | ifne yay -Rns -
      ;;
	fnd)
      shift
      command yay -Ss "$@"
      ;;
	ls)
      shift
      command yay -Qe
      ;;
	help)
      echo "yay aliases:"
      echo "  i       : install packages"
      echo "  rm      : remove packages"
      echo "  up      : update system and remove orphans"
      echo "  chk     : list available updates"
      echo "  cln     : remove orphaned packages"
      echo "  fnd     : search packages"
      echo "  ls      : list installed packages"
      echo "fallback to regular yay otherwise"
      ;;
    *)
      command yay "$@"
      ;;
  esac
}