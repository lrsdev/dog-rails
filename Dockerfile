# See https://github.com/phusion/passenger-docker for base image information
FROM phusion/passenger-ruby22:0.9.17

MAINTAINER Samuel Stewart <samuelcstewart@icloud.com>

# Paperclip (image attachment manager) requires imagemagick.
RUN apt-get -y install imagemagick

# Cache friendly bundler
# http://ilikestuffblog.com/2014/01/06/how-to-skip-bundle-install-when-deploying-a-rails-app-to-docker/
WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

# Add nginx site config
ADD ./containerconfig/dogbeaches.conf /etc/nginx/sites-enabled/dogbeaches.conf

# Add env configs (required to proprogate envars to nginx child process)
ADD ./containerconfig/rails-env.conf /etc/nginx/main.d/rails-env.conf

# Add rails app
ADD . /home/app/dogbeaches
RUN chown -R app:app /home/app/dogbeaches
WORKDIR /home/app/dogbeaches

# Remove Nginx default site
RUN rm /etc/nginx/sites-enabled/default

# Expose Nginx http
EXPOSE 80 443

# Clean up apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Enable Nginx and Passenger
RUN rm -f /etc/service/nginx/down

# Use baseimage-docker's init process
CMD ["/sbin/my_init"]
