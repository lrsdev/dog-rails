# See https://github.com/phusion/passenger-docker for base image information
FROM phusion/passenger-ruby22:0.9.17

MAINTAINER Samuel Stewart <samuelcstewart@icloud.com>

# Paperclip (image attachment manager) requires imagemagick.
RUN apt-get -y install imagemagick

WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN bundle install

ENV HOME /root

# Use baseimage-docker's init process
CMD ["/sbin/my_init"]

# Expose Nginx http
EXPOSE 80 443

# Remove Nginx default site, add our app conf
RUN rm /etc/nginx/sites-enabled/default

# Add nginx site config
ADD ./containerconfig/dogbeaches.conf /etc/nginx/sites-enabled/dogbeaches.conf

# Add env configs (required to proprogate envars to nginx child process)
ADD ./containerconfig/rails-env.conf /etc/nginx/main.d/rails-env.conf

# Enable Nginx and Passenger
RUN rm -f /etc/service/nginx/down

# Add rails app
ADD . /home/app/dogbeaches
RUN chown -R app:app /home/app/dogbeaches
WORKDIR /home/app/dogbeaches

# Clean up apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
