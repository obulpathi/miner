# Copyright 2013 Google Inc. All Rights Reserved.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Bitified Image Entry Model and helper functions."""

import cgi

from google.appengine.ext import db

# Datetime string format
DATETIME_FORMAT = '%Y-%m-%d %H:%M:%S'


class Miner(db.Model):
  """Main Miner model."""
  user = db.StringProperty(required=True)
  timestamp = db.DateTimeProperty(auto_now_add=True)
  miner = db.StringProperty(required=True)
  speed = db.StringProperty(required=True)

  @property
  def timestamp_strsafe(self):
    if self.timestamp:
      return self.timestamp.strftime(DATETIME_FORMAT)
    return None
