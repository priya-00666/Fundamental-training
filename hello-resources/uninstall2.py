import os
import signal

from cloudify import ctx

# Here, we read the `pid` runtime property which we previously
# saved when running `install.py`

ctx.logger.info('Webserver not running.')
