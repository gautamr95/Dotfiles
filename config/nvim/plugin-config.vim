""" ruby config
let ruby_operators = 1


""" editorconfig
let g:EditorConfig_core_mode = 'external_command'


""" ctrlp config
let g:ctrlp_map = '<leader>t'
" Use <leader>f to open MRU files
nmap <leader>f :CtrlPMRUFiles<cr>
" Ignores should be handled by .agignore
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""' " Use silver searcher
let g:ctrlp_working_path_mode = 0

""" Indent guides
let g:indentLine_char = '┆'


""" neomake configuration
" Use <leader>e to go to the next error
nnoremap <leader>e :call LocationNext()<cr>


""" deoplete configuration
let g:deoplete#enable_at_startup = 1
" Improve ultisnips and deoplete integration
call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])


""" NERDCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1


""" NERDTree
let NERDTreeIgnore = ['node_modules', 'tmp', 'bower_components']
" Don't want to see the extra text
let NERDTreeMinimalUI = 1
" Close NERDTree after reading file
autocmd BufReadPre,FileReadPre * :NERDTreeClose
map <silent> <leader>n :NERDTreeToggle<CR>

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction


""" Custom Javascript configuration
let g:javascript_plugin_jsdoc = 1    " Highlight JSDoc


let g:lightline = {
      \ 'colorscheme': 'wal',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste'  ],
      \             [ 'gitbranch', 'neomake', 'readonly', 'filename', 'modified'  ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'neomake': 'Neomakelightline',
      \   'filetype': 'MyFiletype'
      \ },
      \ }

function! NeomakeLightlineStatus()
    if !exists('*neomake#statusline#LoclistCounts')
        return ''
    endif

    " Count all the errors, warnings
    let total = 0

    for v in values(neomake#statusline#LoclistCounts())
        let total += v
    endfor

    for v in items(neomake#statusline#QflistCounts())
        let total += v
    endfor

    if total == 0
        return ''
    endif

    return 'line '.getloclist(0)[0].lnum. ', 1 of '.total
endfunction

function! LocationNext()
  try
    lnext
  catch
    try | lfirst | catch | endtry
  endtry
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

""" Rust Auto Formatting
let g:rustfmt_autosave = 1
