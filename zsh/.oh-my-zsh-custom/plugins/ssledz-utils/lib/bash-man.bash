#!/bin/bash

bashman () {
  man bash | less -p "^       $1 "; 
}
