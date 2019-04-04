"""
Configuration example for ``ptpython``.
"""
from __future__ import unicode_literals
import os

from ptpython.layout import CompletionVisualisation

__all__ = (
    'configure',
)

def configure(repl, config_file=None):
    """
    Configuration method. This is called during the start-up of ptpython.
    Default configuration settings are here, and can be modified by entries
    in a TOML file if desired for local or general use.

    :param repl: `PythonRepl` instance.
    :config_file: TOML text file with configuration
    """

    def read_config_file(toml_file):
        """read config settings from TOML file"""
        try:
            from toml import load
        except ImportError:
            return {"config_file_error":
                    "'toml' module must be installed to use config file"}
        else:
            return load(toml_file)

    if not config_file: # use default config.toml path:
        config_file = '~/.ptpython/config.toml'
        config_file = os.path.expanduser(config_file)

    if os.path.exists(config_file):
        configs = read_config_file(config_file)

        comp_vis = configs.get('completion_visualisation', 'POP_UP')
        configs['completion_visualisation'] = \
            getattr(CompletionVisualisation, comp_vis)

        code_colorscheme = configs.pop('use_code_colorscheme', None)
        if code_colorscheme:
            repl.use_code_colorscheme(code_colorscheme)

        # Set all the  other attributes:
        for opt, val in configs.items():
            setattr(repl, opt, val)
    else:
        print('Impossible to read %r' % config_file)
        return
