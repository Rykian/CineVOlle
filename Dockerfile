FROM rails:4.2

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ADD . /usr/src/app/
RUN bundle install

CMD ["rails", "server", "-b", "0.0.0.0"]
