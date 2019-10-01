FROM ruby:2.6-alpine as builder
ENV RAILS_ENV production

# 依存関係のあるパッケージのinstall
# gccやgitなど、ビルドに必要なものもすべて含まれている
RUN apk --update --no-cache add shadow sudo busybox-suid mariadb-connector-c-dev tzdata alpine-sdk

WORKDIR /rails

COPY Gemfile Gemfile.lock ./

# bundle installした後、makeで発生した不要なファイルは削除。
RUN gem install bundler && \
    bundle install --without development test --path vendor/bundle

FROM ruby:2.6-alpine
ENV RAILS_ENV production

# パッケージ全体を軽量化して、railsが起動する最低限のものにする
RUN apk --update --no-cache add shadow sudo busybox-suid execline tzdata mariadb-connector-c-dev && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del --purge tzdata

EXPOSE 3000

WORKDIR /rails

# gemやassets:precompileの終わったファイルはbuilderからコピーしてくる
COPY --from=builder /rails/vendor/bundle vendor/bundle
COPY --from=builder /usr/local/bundle /usr/local/bundle

COPY . /rails

CMD ["bundle", "ex", "puma", "-p", "3000", "-C", "config/puma.rb"]
