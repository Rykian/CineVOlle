FROM rails:4.2

RUN mkdir -p /app
WORKDIR /app
ADD ./Gemfile /app/
ADD ./Gemfile.lock /app/
RUN bundle install

CMD ["rails", "server", "-b", "0.0.0.0"]
