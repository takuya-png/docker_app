# Node.jsダウンロード用ビルド箇所（使い捨て）
FROM ruby:3.0.1 AS nodejs
WORKDIR /tmp
# Node.jsのダウンロード
RUN curl -LO https://nodejs.org/dist/v12.14.1/node-v12.14.1-linux-x64.tar.xz
RUN tar xvf node-v12.14.1-linux-x64.tar.xz
RUN mv node-v12.14.1-linux-x64 node
# Railsアプリ用ビルド箇所
FROM ruby:3.0.1
# Node.jsダウンロード用ビルド箇所の中からファイル群をコピーして利用可能にする
COPY --from=nodejs /tmp/node /opt/node
ENV PATH /opt/node/bin:$PATH
# yarnのインストール
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH /root/.yarn/bin:/root/.config/yarn/global/node_modules/.bin:$PATH
WORKDIR /app
RUN bundle config set path vendor/bundle
# docker run実行時にコマンド指定が無い場合に実行されるコマンド
CMD ["bash"]