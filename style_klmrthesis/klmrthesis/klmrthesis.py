# A Pygments style for my thesis.

from pygments.style import Style
from pygments.token import Keyword, Name, Comment, String, Error, Number, \
        Operator, Whitespace


class KlmrThesisStyle(Style):
    default_styles = ''
    styles = {
        Keyword: '#FF00FF'
    }
