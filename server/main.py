import os
import json
import logging
from cStringIO import StringIO
from datetime import datetime

import yaml
import jinja2
import webapp2
from PIL import Image

from models import Miner

from google.appengine.api import images
from google.appengine.api import taskqueue
from google.appengine.api import users
from google.appengine.ext import blobstore
from google.appengine.ext import db


# Set up the Jinja templating environment.
jinja_environment = jinja2.Environment(
    loader=jinja2.FileSystemLoader(
        os.path.dirname(__file__)))

# Load configuration options from settings.cfg file.
config = yaml.load(open('settings.cfg', 'r'))
MAIN_BUCKET = config['GCS']['MAIN_BUCKET']
BIT_BUCKET = config['GCS']['BIT_BUCKET']
TASKQUEUE = 'imagetasks'

# Get Task Queue.
processing_task_queue = taskqueue.Queue(TASKQUEUE)


def GetGreeting(user, request):
  if user:
    return ('Logged in as %s. <a href="%s"'
            ' class="button">Log Out</a>') % (user.nickname(),
                                              users.create_logout_url('/'))
  else:
    return ('<a href="%s" class="button">'
            'Please log in.</a>' % users.create_login_url(request.uri))
    
    
class MainPage(webapp2.RequestHandler):
  """List, Create and Delete Miners."""

  def get(self):  # pylint: disable=g-bad-name
    """Returns front page list of miners, only if logged in."""
    user = users.get_current_user()
    greeting = GetGreeting(user, self.request)

    # get current miners
    miners = db.GqlQuery('SELECT * FROM Miner ORDER BY timestamp '
                          'DESC LIMIT 100')

    template = jinja_environment.get_template('index.html')
    template_data = {
        'greeting': greeting,
        'miners': miners
    }

    self.response.write(template.render(template_data))
    
  def post(self):  # pylint: disable=g-bad-name
    """Handles creating new Miner form post."""
    coin = self.request.get('coin')
    if not coin:
      logging.error('No coin selected.')
      self.error(400)

    speed = self.request.get('speed')
    if not speed:
      logging.error('Speed not selected.')
      self.error(400)
      
    # insert into Queue or what ever to create a new miner
    # make the status pending ... like creating new server in Rackspace cloud panel
    logging.info('Creating new mining deployment for %s with a hash rate of %s in the cloud.', coin, speed)


application = webapp2.WSGIApplication([('/', MainPage)
                                      ],
                                      debug=True)
