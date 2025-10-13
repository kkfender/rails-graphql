# Makefile for Docker Rails environment

APP=app

# ------------------------------------------
# 基本コマンド
# ------------------------------------------

# コンテナに入る（bash）
bash:
	docker compose run --rm $(APP) bash

# Railsコマンドを実行（例: make rails ARGS="db:migrate"）
rails:
	docker compose run --rm $(APP) rails $(ARGS)

# bundleコマンドを実行（例: make bundle ARGS="install"）
bundle:
	docker compose run --rm $(APP) bundle $(ARGS)

# RSpecテスト実行
test:
	docker compose run --rm $(APP) bundle exec rspec

# ------------------------------------------
# Docker管理コマンド
# ------------------------------------------

# コンテナ起動
up:
	docker compose up

# コンテナ停止
down:
	docker compose down

# ビルド
build:
	docker compose build

# クリーンビルド
rebuild:
	docker compose down --rmi all --volumes --remove-orphans
	docker compose build --no-cache
