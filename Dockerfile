FROM ruby:2.6.5
ENV LANG C.UTF-8
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       nodejs
##    yarnのセットアップ MySQL

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn


# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs


#RUN curl -o- -L RUN curl -o- -L https://yarnpkg.com/install.sh | bash
#ENV PATH /root/.yarn/bin:/root/.config/yarn/global/node_modules/.bin:\$PATH
#
#RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn chromium-driver
RUN mkdir /Wearing-Connect
# 作業ディレクトリの設定
ENV APP_ROOT /Wearing-Connect
ENV DEBCONF_NOWARNINGS yes
WORKDIR $APP_ROOT

# ローカルのGemfileを追加
COPY ./Gemfile $APP_ROOT/Gemfile
COPY ./Gemfile.lock $APP_ROOT/Gemfile.lock

#RUN /bin/sh -l -c 'gem install bundler'
#RUN /bin/sh -l -c 'bundle install'
RUN gem install bundler
RUN bundle install
COPY . $APP_ROOT
RUN mkdir -p tmp/sockets

##fixme
#
#
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]