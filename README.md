```sh
find ./* -maxdepth 0 -type d  -printf "%f\n" | xargs stow
```
