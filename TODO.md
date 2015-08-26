- Convert all functions in all files to echo the commands that they run before they run it
- Replace all echoes with color echoes
- Introduce a static analyzer to ensure quality of scripts:
http://programmers.stackexchange.com/questions/201924/static-code-analysis-for-bash-scripts
http://www.shellcheck.net/about.html
http://stackoverflow.com/questions/3668665/is-there-a-static-analysis-tool-like-lint-or-perlcritic-for-shell-scripts
http://www.shellcheck.net/#
- Replace all occurences of null check or not empty check with isempty()
- Add parameter guard clauses in all function as in string_trim_all