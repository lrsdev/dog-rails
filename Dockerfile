# See https://github.com/phusion/passenger-docker for base image information
FROM phusion/passenger-ruby22:0.9.17

MAINTAINER Samuel Stewart <samuelcstewart@icloud.com>

# Paperclip (image attachment manager) requires imagemagick.
RUN apt-get -y install imagemagick

ENV HOME /root

# Use baseimage-docker's init process
CMD ["/sbin/my_init"]

# Expose Nginx http
EXPOSE 80 443

# Remove Nginx default site, add our app conf
RUN rm /etc/nginx/sites-enabled/default

# Add nginx site config
ADD ./.dockerconfig/dogbeaches.conf /etc/nginx/sites-enabled/dogbeaches.conf

# Add env configs (required to proprogate envars to nginx child process)
ADD ./.dockerconfig/database.conf /etc/nginx/main.d/database.conf
ADD ./.dockerconfig/secret_key.conf /etc/nginx/main.d/secret_key.conf
ADD ./.dockerconfig/aws.conf /etc/nginx/main.d/aws.conf

# Add SSL certs (travis ci decrypts at build time)
#ADD ./.dockerconfig/certs/dogbeaches.crt /etc/nginx/ssl/dogbeaches.crt
#ADD ./.dockerconfig/certs/dogbeaches.key /etc/nginx/ssl/dogbeaches.key
WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN bundle install

# Add env file, execute (decrpyted by travis ci)
ADD ./.dockerconfig/env.sh /home/app/env.sh
RUN chown -R app:app /home/app/env.sh
RUN sudo -u app source /home/app/env.sh
RUN rm /home/app/env.sh

# Enable Nginx and Passenger
RUN rm -f /etc/service/nginx/down

# Add rails app
ADD . /home/app/dogbeaches
RUN chown -R app:app /home/app/dogbeaches

# Clean up apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

