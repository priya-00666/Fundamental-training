# Note, this contains some advanced info.

# Import Cloudify's context object.
# This provides several useful functions as well as allowing to pass
# contextual information of an application.
from cloudify import ctx



# Get the port from the blueprint. We're running this script in the context of
# the `http_web_server` node so we can read its `port` property.
PORT = ctx.node.properties['port']
DEFAULT_IP = ctx.node.properties['ip']

ctx.logger.info('hello from cloudify on {0}:{1}'.format(DEFAULT_IP,PORT))
