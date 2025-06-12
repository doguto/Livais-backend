# Livais-Backend
AI×SNS
### Status
[![deploy to dev](https://github.com/doguto/Livais-backend/actions/workflows/deploy.yml/badge.svg)](https://github.com/doguto/Livais-backend/actions/workflows/deploy.yml)

## External Links
X: https://x.com/livaisapp

## Licens

## Front End
https://github.com/tsukuneA1/procon-frontend


# > Develop
## Develop Rules
### Branch
Gitのブランチを作成する際の命名規則は以下に従ってください。
```
backend-{issueの番号}-{自分の名前}
```
### Commit
コミットメッセージは以下のフォーマットに従ってください。
```
"{変更の種類を示すPrefix}: {簡単に変更の理由と内容（日本語可）}" 
```
### PullRequest
GitでPullRequestを出す場合は、必ずコメントに関連するissueの番号を必ず記載してください。issueと関連付けるためです。

また、Assignに自分のアカウントを設定してください。

### Package manager
新規にライブラリを追加した際は以下のコマンドの打ち忘れに注意。
```
bundle install
```
### Linter
GitHubへとPushする前に必ず以下のコマンドを実行し、Linterを通しましょう。
```
bundle exec rubocop -A
```
Linterでoffenseが出た場合は修正してからPushするようにしてください。

また、GitHubのプルリクエスト時にActionがFailした場合は大抵Linterに引っかかってます。その場合も再度確認してください。

## DeveloperList
* @doguto
* @tsukuneA1
* @tytdroid
