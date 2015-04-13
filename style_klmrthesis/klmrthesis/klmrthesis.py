# A Pygments style for my thesis.

from pygments.style import Style
from pygments.token import Text, Keyword, Name, Comment, String, Error, \
        Number, Operator, Whitespace, Punctuation


class KlmrThesisStyle(Style):
    default_styles = ''
    styles = {
        Text: '#404040',
        Name: '#404040',
        Operator: '#404040',
        Punctuation: '#404040',
        Comment: '#808080',
        Keyword: '#FF0000',
        Number: '#429EB6',
        String: '#DE8950'
    }
