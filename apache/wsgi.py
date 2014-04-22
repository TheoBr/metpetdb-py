"""
WSGI config for metpetdb project.

This module contains the WSGI application used by Django's development server
and any production WSGI deployments. It should expose a module-level variable
named ``application``. Django's ``runserver`` and ``runfcgi`` commands discover
this application via the ``WSGI_APPLICATION`` setting.

Usually you will have the standard Django WSGI application here, but it also
might make sense to replace the whole Django WSGI application with a custom one
that later delegates to the Django one. For example, you could introduce WSGI
middleware here, or combine a Django application with an application of another
framework.

"""
# Make appropriate changes to the code below to match the folder structure on your server

import os
import sys

path = '/home/metpetdb_py/code'
if path not in sys.path:
    sys.path.append(path)
sys.path.append('/home/metpetdb_py')
sys.path.append('/home/metpetdb_py/.virtualenvs/mpdb/lib/python2.7/site-packages')
os.environ['DJANGO_SETTINGS_MODULE'] = 'metpetdb.settings'

activate_this = '/home/metpetdb_py/.virtualenvs/mpdb/bin/activate_this.py'
execfile(activate_this, dict(__file__=activate_this))

# This application object is used by any WSGI server configured to use this
# file. This includes Django's development server, if the WSGI_APPLICATION
# setting points here.
import django.core.handlers.wsgi
application = django.core.handlers.wsgi.WSGIHandler()

# Apply WSGI middleware here.
# from helloworld.wsgi import HelloWorldApplication
# application = HelloWorldApplication(application)
