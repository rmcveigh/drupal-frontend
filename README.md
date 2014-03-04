Drupal-Frontend
===============
The purpose of this cookbook is to allow for an automated frontend spin up
experience to exist.

The goal is to utilize best practices in the community to help speedup and unify
the experience of dev-ing in a Vagrant world.

Requirements
------------

### Platform:

This cookbook is used in conjuction with nedmediadenver/drupal-lamp.git.
Other uses have NOT been formally tested, but submit a pull request. It could be
fun.

### Cookbooks:

This cookbook depends on newmediadenver/drupal.git.

Attributes
----------

Recipes
-------
### Drupal-frontend::default (Default Functionality)
This allows for automatic compilation of scss/sass to css using ruby gems, other
ruby specific settings should work.

Add this below the drupal site, that you would like to use.

```
"drupal-frontend": {
  "default": {
    "css_preprocessor": {
      // Relative to the docroot
      "location": "profiles/jref/themes/jref_bare",
      // Ruby gems needed to compile
      "gems": [
        "bundler"
      ],
      // Commands to run so install can occur.
      "commands": [
        "bundle install && bundle update",
        "bundle exec compass compile"
      ]
    }
  }
},

### Drupal-frontend::bundler
### Drupal-frontend::nodejs (Coming soon)
### Drupal-frontend::grunt (Coming soon)



License and Author
------------------

Author:: Tim Whitney

Copyright:: 2014, Tim Whitney

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.