#
# Cookbook Name:: drupal-frontend
# Recipe:: default
#
# Copyright (C) 2014 Tim Whitney tim.d.whitney@gmail.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Install/configure tools for frontend

# For each site, run the following commands
node[:drupal][:sites].each do |site_name, site|
  # Only run if the site is active, else no need to compile.
  if site[:active]
    #Use a CSS Preprocessor
    unless site[:drupal_frontend].nil?
      unless site[:drupal_frontend][:default].nil?
        unless site[:drupal_frontend][:default][:css_preprocessor].nil?
          csspre = site[:drupal_frontend][:default][:css_preprocessor]
          release_path = node[:drupal][:server][:base] + '/' + site_name
          Chef::Log.debug('drupal-frontend::default: before_restart: site[:drupal-frontend][:default][:css_preprocessor]' + csspre.inspect)
          # Install each gem
          Chef::Log.debug('drupal-frontend::default: before_restart: site[:drupal-frontend][:default][:css_preprocessor][:gems]' + csspre[:gems].inspect)
          csspre[:gems].each do |g|
            gem_package g do
              not_if 'gem list | grep #{g}'
              action :install
            end
          end
          cmd = ""
          # This allows for the commands to be ran in a single string
          last = csspre[:commands].last
          Chef::Log.debug('Last '+ last)
          csspre[:commands].each do |c|
            if c == last
              cmd << c
            else
              cmd << c + '; '
            end
          end
          bash 'compile CSS' do
            user 'root'
            cwd release_path + '/current/' + csspre[:location]
            code <<-EOH
              #{cmd}
            EOH
          end
        end
      end
    end
  end
end