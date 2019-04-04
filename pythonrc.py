# -*- coding: utf-8 -*-
""" This file is executed when the Python interactive shell is started if
$PYTHONSTARTUP is in your environment and points to this file. It's just
regular Python commands, so do what you will. Your ~/.inputrc file can greatly
complement this file.
This began with dotfiles from Seth House <seth@eseth.com> (whiteinge)
then continued with Benjamin (Cometsong).
"""
# Imports we need
from __future__ import print_function, unicode_literals
import sys
import os
import site
import atexit
import pprint
from tempfile import mkstemp
from code import InteractiveConsole

# Imports we want
import datetime
import pdb

# from: http://jedi.jedidjah.ch/en/latest/docs/usage.html#repl-completion
try:
    from jedi.utils import setup_readline
    setup_readline()
except ImportError:
    # Fallback to the stdlib readline completer if it is installed.
    # Taken from http://docs.python.org/2/library/rlcompleter.html
    print("Jedi is not installed, falling back to readline")
    try:
        import readline
        import rlcompleter
        readline.parse_and_bind("tab: complete")
    except ImportError:
        print("Readline is not installed either. No tab completion enabled.")


AUTHOR = 'Benjamin Leopold <benjamin@cometsong.net>'

# Color Support
###############
class TermColors(dict):
    """Gives easy access to ANSI color codes. Attempts to fall back to no color
    for certain TERM values. (Mostly stolen from IPython.)"""

    COLOR_TEMPLATES = (
        ("Black"       , "0;30"),
        ("Red"         , "0;31"),
        ("Green"       , "0;32"),
        ("Brown"       , "0;33"),
        ("Blue"        , "0;34"),
        ("Purple"      , "0;35"),
        ("Cyan"        , "0;36"),
        ("LightGray"   , "0;37"),
        ("DarkGray"    , "1;30"),
        ("LightRed"    , "1;31"),
        ("LightGreen"  , "1;32"),
        ("Yellow"      , "1;33"),
        ("LightBlue"   , "1;34"),
        ("LightPurple" , "1;35"),
        ("LightCyan"   , "1;36"),
        ("White"       , "1;37"),
        ("Normal"      , "0"),
    )

    NoColor = ''
    _base = '\033[%sm'

    def __init__(self):
        PRE = '\001'
        SUF = '\002'
        if os.environ.get('TERM') in ('xterm', 'xterm-color', 'xterm-256color',
                                      'linux', 'screen', 'screen-256color',
                                      'screen-bce'):
            self.update(dict([(k, ''.join([PRE, self._base, SUF]) % v)
                              for k, v in self.COLOR_TEMPLATES]))
        else:
            self.update(dict([(k, self.NoColor)
                              for k, v in self.COLOR_TEMPLATES]))
_c = TermColors()


# Enable a History
##################
HISTFILE = "%s/.pyhistory" % os.environ["HOME"]

# Read the existing history if there is one
if os.path.exists(HISTFILE):
    import readline
    readline.read_history_file(HISTFILE)

# Set maximum number of items that will be written to the history file
readline.set_history_length(3000)


def savehist(histfile=HISTFILE):
    readline.write_history_file(histfile)

atexit.register(savehist)

# Enable Color Prompts
######################
sys.ps1 = '%s>>> %s' % (_c['Green'], _c['Normal'])
sys.ps2 = '%s... %s' % (_c['Red'], _c['Normal'])


# Enable Pretty Printing for stdout
###################################
def my_displayhook(value):
    """Enable Pretty Printing for stdout"""
    if value is not None:
        pprint.pprint(value)

sys.displayhook = my_displayhook

# Enable Pretty Printing for dicts
##################################
# orig from http://code.activestate.com/recipes/327142/
# mods from http://www.pixelbeat.org/scripts/inpy
# combined into this by Cometsong:
def ppdict(d):
    """Pretty Print for Dicts"""
    print('{')
    keys = d.keys()
    keys.sort()
    maxKeyLen = max([len(str(x)) for x in keys])
    for k in keys:
        spacing = " " * (maxKeyLen-(len(repr(k))-3)) # -3 for "'' "
        print("  {}{}: {},".format(repr(k), spacing, repr(d[k])) )
    print('}')


# Welcome message
#################
WELCOME = """\
%(LightBlue)sHere be dragons, \
%(LightRed)sc%(Green)so%(LightGray)sl%(Purple)so%(Yellow)sr%(DarkGray)ss, \
%(LightBlue)shistory, (and with .inputrc:) completion, vi-keybinds.
%(Brown)sType \e to get an external editor.%(Normal)s""" % _c

atexit.register(lambda: sys.stdout.write("""%(LightGray)s See ya later!
%(Normal)s""" % _c))


# Django Helpers
################
def SECRET_KEY(key_length=50):
    "Generates a new SECRET_KEY that can be used in a project settings file."

    from random import choice
    return ''.join(
        [choice('abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)')
         for i in range(key_length)])


# If we're working with a Django project, set up the environment
if 'DJANGO_SETTINGS_MODULE' in os.environ:
    try:
        from django.db.models.loading import get_models
        from django.test.client import Client
        from django.test.utils import setup_test_environment, \
                                      teardown_test_environment
        from django.conf import settings as S

        class DjangoModels(object):
            """Loop through all the models in INSTALLED_APPS, import them."""
            def __init__(self):
                for m in get_models():
                    setattr(self, m.__name__, m)

        A = DjangoModels()
        C = Client()

        WELCOME += """%(Green)s
            Django environment detected.
            * Your INSTALLED_APPS models are available as `A`.
            * Your project settings are available as `S`.
            * The Django test client is available as `C`.
            %(Normal)s""" % _c

        setup_test_environment()
        S.DEBUG_PROPAGATE_EXCEPTIONS = True

        WELCOME += """%(LightPurple)s
            Warning: the Django test environment has been set up; to restore
            the normal environment call `teardown_test_environment()`.

            Warning: DEBUG_PROPAGATE_EXCEPTIONS has been set to True.
            %(Normal)s""" % _c
    except ImportError as e:
        pass


# Start an external editor with \e
##################################
# http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/438813/
EDITOR = os.environ.get('EDITOR', 'vim')
EDIT_CMD = '\e'


class EditableBufferInteractiveConsole(InteractiveConsole):
    def __init__(self, *args, **kwargs):
        self.last_buffer = []  # This holds the last executed statement
        hist_file = kwargs.pop('history_filename', None)
        InteractiveConsole.__init__(self, *args, **kwargs)
        try:
            from ptpython.repl import embed

        except ImportError:
            print("ptpython is not available: falling back to standard prompt")
        else:
            embed(globals=globals(), locals=locals()
                  , history_filename=hist_file
                  , configure=configure
                  )

    def runsource(self, source, *args):
        self.last_buffer = [source.encode('utf-8')]
        return InteractiveConsole.runsource(self, source, *args)

    def raw_input(self, *args):
        line = InteractiveConsole.raw_input(self, *args)
        if line == EDIT_CMD:
            fd, tmpfl = mkstemp('.py')
            os.write(fd, b'\n'.join(self.last_buffer))
            os.close(fd)
            os.system('%s %s' % (EDITOR, tmpfl))
            line = open(tmpfl).read()
            os.unlink(tmpfl)
            tmpfl = ''
            lines = line.split('\n')
            for i in range(len(lines) - 1):
                self.push(lines[i])
            line = lines[-1]
        return line


# c = EditableBufferInteractiveConsole(locals=locals(), history_filename=HISTFILE)
# c.interact(banner=WELCOME)

# Exit the Python shell on exiting the InteractiveConsole
# sys.exit()

# Embed ptpython REPL
#####################

# PTPython Config:
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


try:
    from ptpython.repl import embed
    from ptpython.layout import CompletionVisualisation
except ImportError:
    print("ptpython is not available: falling back to standard prompt")
except Exception as e:
    raise e
else:
    sys.exit(
        embed(globals(), locals()
              , history_filename=HISTFILE
              , configure=configure
              )
    )
