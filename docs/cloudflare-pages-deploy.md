# Cloudflare Pages デプロイ手順

GitHub Actionsを使用してCloudflare Pagesに自動デプロイする設定手順です。

## 1. Cloudflareにサインアップ

1. https://dash.cloudflare.com/sign-up にアクセス
2. メールアドレスとパスワードを入力してアカウント作成
3. メール認証を完了

## 2. API Token作成

1. https://dash.cloudflare.com/profile/api-tokens にアクセス
2. **Create Token** をクリック
3. **Edit Cloudflare Pages** テンプレートを選択（推奨）
   - または **Create Custom Token** で以下の権限を設定：
     - Account > Cloudflare Pages > Edit
4. **Account Resources** で対象アカウントを選択
5. **Continue to summary** → **Create Token**
6. 表示されたトークンをコピーして保存（再表示不可）

### アカウントIDの確認

- Cloudflareダッシュボードで任意のドメインを選択
- 右サイドバーの「API」セクションに **アカウントID** が表示される
- またはダッシュボードURLの `https://dash.cloudflare.com/{アカウントID}/...` から確認

## 3. GitHub Secrets作成

リポジトリの Settings > Secrets and variables > Actions で設定します。

### Repository secretsに追加

| Name | Value |
|------|-------|
| `CLOUDFLARE_API_TOKEN` | 作成したAPIトークン |
| `CLOUDFLARE_ACCOUNT_ID` | CloudflareアカウントID |

### 設定時の注意

- **Repository secrets** を使用（Environment secretsではない）
- Secret名は大文字・アンダースコアで正確に入力
- 値のみをペースト（`KEY=value`の`=`以降の部分のみ）

## 4. Actions実行

### 自動実行

`master`ブランチにpushすると自動的にデプロイが実行されます。

```bash
git add .
git commit -m "変更内容"
git push origin master
```

### 手動実行

1. GitHubリポジトリの **Actions** タブを開く
2. **Deploy to Cloudflare Pages** ワークフローを選択
3. **Run workflow** をクリック

### 実行結果の確認

- GitHub Actions: リポジトリの Actions タブ
- デプロイURL: `https://{プロジェクト名}.pages.dev/`

## トラブルシューティング

### Authentication error [code: 10000]

- APIトークンの権限が不足している
- Account Resourcesで対象アカウントが選択されていない
- CLOUDFLARE_ACCOUNT_IDが間違っている

### Project not found [code: 8000007]

- Cloudflare Pagesにプロジェクトが存在しない
- 初回デプロイ時は自動でプロジェクトが作成される（ワークフローで設定済み）

### Secretsが認識されない

- Secret名が正確か確認（大文字・アンダースコア）
- Repository secretsに設定したか確認
- 値に余分な空白や改行が含まれていないか確認
