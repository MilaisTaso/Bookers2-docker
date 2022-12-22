# ベースとなるイメージの指定（rubyのバージョン3.0.3を指定）
FROM ruby:3.1.0

# ビルド時に実行するコマンドの指定
# インストール可能なパッケージの一覧の更新
RUN apt-get update -qq \
# パッケージのインストール（nodejs、postgresql-client、npmを指定）
&& apt-get install -y nodejs mariadb-client npm \
&& rm -rf /var/lib/apt/lists/* \
&& npm install --global yarn

# 作業ディレクトリの指定
WORKDIR /bookers2
COPY Gemfile /bookers2/Gemfile
COPY Gemfile.lock /bookers2/Gemfile.lock

# Bundlerの不具合対策
RUN gem update --system
RUN bundle update --bundler

RUN bundle install
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
