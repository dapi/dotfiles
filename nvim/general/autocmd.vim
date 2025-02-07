autocmd FileType gitcommit set textwidth=72
autocmd FileType gitcommit set colorcolumn=73

autocmd VimLeave * set guicursor=a:ver10-blinkon1
"
" autocmd BufRead,BufNewFile */templates/*.yaml,*/templates/*.tpl,*.gotmpl,helmfile*.yaml set ft=helm
autocmd FileType yaml execute  ':silent! %s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab nocindent smartindent
autocmd BufNewFile,BufRead *.yaml,*.yml set ft=yaml
autocmd BufNewFile,BufRead .envrc set ft=sh
autocmd BufReadPost,BufNewFile *.yml.gotmpl set filetype=yaml
autocmd BufReadPost,BufNewFile *.yaml.gotmpl set filetype=yaml

" Use {{/* */}} as comments
autocmd FileType helm setlocal commentstring={{/*\ %s\ */}}

autocmd BufReadPost,BufNewFile {Makefile,*.mk} set filetype=make
autocmd FileType make setlocal noexpandtab shiftwidth=2 softtabstop=2 tabstop=2
autocmd BufRead,BufNewFile *.tsx set filetype=typescript noet ci pi sts=0 sw=2 ts=2
autocmd BufRead,BufNewFile *.hamlc setlocal filetype=haml
autocmd BufRead,BufNewFile *.env.* setlocal filetype=sh
autocmd BufRead,BufNewFile {Guardfile,Gemfile.lock,Procfile,config.ru} set ft=ruby
autocmd BufRead,BufNewFile *.sql setf pgsql
autocmd BufRead,BufNewFile *.cjsx set filetype=coffee
autocmd BufRead,BufNewFile *.md setlocal textwidth=80
autocmd BufRead,BufNewFile *.rb setlocal textwidth=160
autocmd BufRead,BufNewFile *.axlsx set filetype=ruby
autocmd BufReadPost,BufNewFile *.coffee setl foldmethod=indent nofoldenable shiftwidth=2 expandtab
autocmd BufReadPost,BufNewFile *.cljx setfiletype clojure
autocmd BufReadPost,BufNewFile *.php setlocal tabstop=4 softtabstop=4 shiftwidth=4

"autocmd BufNewFile,BufRead *.jsx let b:jsx_ext_found = 1
"autocmd BufNewFile,BufRead *.jsx set filetype=javascript

autocmd BufNewFile,BufRead *.axlsx set filetype=ruby
 
" Remove trailing spaces
" http://www.bestofvim.com/tip/trailing-whitespace/
autocmd FileType ruby,javascript,css
      \ autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd FileType python
      \ setlocal ai si et sta sw=4
      \ textwidth=80 backspace=indent,eol,start fo=croql


autocmd! BufWritePost $MYVIMRC source %
autocmd BufRead *.txt set spell!
autocmd BufNewFile *.txt set spell!

autocmd BufReadPost,BufNewFile */playbooks/*.yml,*/ansible*/*.yml,playbook.yml set filetype=yaml.ansible
"augroup ansible_vim_fthosts
  "autocmd!
  "autocmd BufNewFile,BufRead hosts setfiletype yaml.ansible
"augroup END
" autocmd BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
" let g:ansible_unindent_after_newline = 0


