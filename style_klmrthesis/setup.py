from setuptools import setup

'''
A syntax stylesheet for my thesis
'''

setup(
        name = 'klmrthesis',
        version = '0.1',
        description = __doc__,
        author = 'Konrad Rudolph',
        install_requries = ['pygments'],
        packages = ['klmrthesis'],
        entry_points = '''
        [pygments.styles]
        klmrthesis = klmrthesis:KlmrThesisStyle
        '''
)
