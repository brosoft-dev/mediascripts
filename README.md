# mediascripts

## Scripts for managing media files.

These scripts are made superfluous by many downloaders' in-built rename functions.

### _flatten.sh

Gets all the files in 2nd-tier subdirectories and puts them in the immediate sub-directory from the current path.
Example:
./dir1/subdirA/file.txt is moved to ./dir1/file.txt
* Files in ./dir1/ are not altered.
* "some" conflict checking
* Useful for some media players / library software (kodi) to correctly identify the containing title.

### _namefix.sh

Will scan current directory (./) for movie folders like:
  A.movie.title.2010.mkv.720p.grouptag
and...
  A Title almost perfect 2010
And will show you what it would rename it as:
  A Movie Title (2010)
  A Title Almost Perfect (2010)

* No action is performed unless specific arguments are given.
* Works reasonably well
* Useful for some media players / library software (kodi) to correctly identify the containing title (and
  also looks a hell of a lot neater).

