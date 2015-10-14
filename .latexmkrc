$pdflatex = 'xelatex --synctex=1 -shell-escape %O %S';
$pdf_previewer = 'open -a /Applications/Skim.app';

# Glossaries support based on <http://tex.stackexchange.com/a/44316/42>
add_cus_dep('glo', 'gls', 0, 'makeglo2gls');
sub makeglo2gls {
    if ( $silent ) {
        system "makeglossaries -q '$_[0]'";
    }
    else {
        system "makeglossaries '$_[0]'";
    };
}

push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';
$clean_ext .= ' %R.ist %R.xdy';

# vim: ft=perl
