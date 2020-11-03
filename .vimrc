set syntax=on

autocmd BufNewFile,BufRead CVE-[0-9][0-9][0-9][0-9]-[0-9]\\\{4,\} set syntax=cve
autocmd BufNewFile,BufRead 00boilerplate.* set syntax=cve
