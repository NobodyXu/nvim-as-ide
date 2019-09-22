#!/bin/sh

echo Please make sure there is no error in all non-optional section
exec nvim -c ":checkhealth"
