# Terraform AWS Bedrock Slack Agent

AWS BedrockエージェントとSlack連携を作成・管理するためのTerraformモジュール。このモジュールを使用することで、Amazon Bedrockによって動力を供給されたAIアシスタントをデプロイし、シームレスな相互作用のためにSlackワークスペースに接続できます。

## 機能

- AWS Bedrockエージェントの作成と設定
- AWS Chatbotを使用したSlack連携の設定
- セキュアアクセスのためのIAMロールとポリシーの管理
- 異なる環境のためのエージェントエイリアスの設定
- Claude 3 Sonnetモデルのサポート

## セットアップ手順

1. **Slackチャンネルの準備**
   - 使用するSlackチャンネルを決定
   - チャンネルIDを取得（チャンネル名を右クリック → 「チャンネルの詳細を表示」→ 「チャンネルIDをコピー」）
   - チームIDを取得（ワークスペースのURLから取得、例：`https://app.slack.com/client/T0123456789`の`T0123456789`部分）

2. **Terraformの実行**
   ```bash
   terraform init
   terraform apply
   ```

3. **AWS ChatbotとSlackの連携**
   - AWS ChatbotコンソールでSlackワークスペースとの連携を設定
   - 必要な権限を付与（AmazonBedrockFullAccess）

4. **Slackチャンネルの設定**
   - 対象のSlackチャンネルにAWS Chatbotアプリを追加
   - チャンネルで`/invite @AWS Chatbot`を実行

5. **Bedrockエージェントの接続**
   - チャンネルで以下のコマンドを実行：
   ```
   @aws connector add {コネクター名} {Bedrock agentのARN} {Bedrock agentのエイリアスID}
   ```
   - コネクター名は任意の名前（短めが推奨）
   - Bedrock agentのARNとエイリアスIDは`terraform output`で確認可能：
     ```bash
     terraform output bedrock_agent_arn
     terraform output bedrock_agent_alias_id
     ```

6. **エージェントの利用開始**
   - チャンネルで`@aws ask {コネクター名} {プロンプト}`の形式で質問
   - 例：`@aws ask bedrock-agent AWSのサービスについて教えて`

## 使用方法

```hcl
module "aws_bedrock_slack_agent" {
  source = "github.com/nix-tkobayashi/terraform-aws-bedrock-slack-agent"

  # 必須パラメータ
  chatbot_slack_channel_id = "C0123456789"
  chatbot_slack_team_id    = "T0123456789"

  # オプションパラメータ
  bedrock_agent_name        = "my-bedrock-agent"
  bedrock_agent_instruction = "あなたはAWS Bedrockを使用したAIアシスタントです..."
  bedrock_agent_description = "カスタムAIアシスタント"
}
```

## 利用可能な基盤モデル

`bedrock_agent_foundation_model`パラメータは以下のモデルをサポートしています。モデルの可用性はAWSリージョンによって異なることに注意してください。

### Anthropic Claude モデル
| モデルID | モデル名 | サポートリージョン | 備考 |
|----------|----------|------------------|------|
| `anthropic.claude-3-5-sonnet-20241022-v2:0` | Claude 3.5 Sonnet v2 | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | 最新版（推奨） |
| `anthropic.claude-3-5-sonnet-20240620-v1:0` | Claude 3.5 Sonnet v1 | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | 前版 |
| `anthropic.claude-3-sonnet-20240229-v1:0` | Claude 3 Sonnet | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | 現在のデフォルト |
| `anthropic.claude-3-haiku-20240307-v1:0` | Claude 3 Haiku | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | 最も高速で費用対効果が高い |
| `anthropic.claude-3-opus-20240229-v1:0` | Claude 3 Opus | us-east-1, us-west-2 | 最も高性能、利用可能リージョンが限定的 |
| `anthropic.claude-v2:1` | Claude 2.1 | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | レガシーモデル |
| `anthropic.claude-v2` | Claude 2 | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | レガシーモデル |
| `anthropic.claude-instant-v1` | Claude Instant | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | レガシーモデル |

### Amazon Titan モデル
| モデルID | モデル名 | サポートリージョン | 備考 |
|----------|----------|------------------|------|
| `amazon.titan-text-premier-v1:0` | Titan Text Premier | us-east-1, us-west-2, eu-west-1 | 最新テキストモデル |
| `amazon.titan-text-express-v1` | Titan Text Express | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | 高速テキスト生成 |
| `amazon.titan-text-lite-v1` | Titan Text Lite | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | 軽量テキストモデル |

### Meta Llama モデル
| モデルID | モデル名 | サポートリージョン | 備考 |
|----------|----------|------------------|------|
| `meta.llama3-2-90b-instruct-v1:0` | Llama 3.2 90B Instruct | us-east-1, us-west-2 | 最新大型モデル |
| `meta.llama3-2-11b-instruct-v1:0` | Llama 3.2 11B Instruct | us-east-1, us-west-2, eu-west-1 | 中型モデル |
| `meta.llama3-2-3b-instruct-v1:0` | Llama 3.2 3B Instruct | us-east-1, us-west-2, eu-west-1 | 小型モデル |
| `meta.llama3-2-1b-instruct-v1:0` | Llama 3.2 1B Instruct | us-east-1, us-west-2, eu-west-1 | 最小モデル |
| `meta.llama3-1-70b-instruct-v1:0` | Llama 3.1 70B Instruct | us-east-1, us-west-2 | 前世代 |
| `meta.llama3-1-8b-instruct-v1:0` | Llama 3.1 8B Instruct | us-east-1, us-west-2, eu-west-1 | 前世代 |

### Mistral AI モデル
| モデルID | モデル名 | サポートリージョン | 備考 |
|----------|----------|------------------|------|
| `mistral.mistral-large-2407-v1:0` | Mistral Large | us-east-1, us-west-2, eu-west-1 | 最新大型モデル |
| `mistral.mistral-large-2402-v1:0` | Mistral Large (Feb 2024) | us-east-1, us-west-2, eu-west-1 | 前版 |
| `mistral.mistral-small-2402-v1:0` | Mistral Small | us-east-1, us-west-2, eu-west-1 | より小さく高速なモデル |

### Cohere モデル
| モデルID | モデル名 | サポートリージョン | 備考 |
|----------|----------|------------------|------|
| `cohere.command-r-plus-v1:0` | Command R Plus | us-east-1, us-west-2, eu-west-1 | 最新大型モデル |
| `cohere.command-r-v1:0` | Command R | us-east-1, us-west-2, eu-west-1 | 標準モデル |
| `cohere.command-text-v14` | Command (Legacy) | us-east-1, us-west-2, eu-west-1 | レガシーモデル |

### リージョンに関する注意事項
- **us-east-1 (N. Virginia)**: 最も幅広いモデルをサポート
- **us-west-2 (Oregon)**: 2番目に良いモデル可用性
- **eu-west-1 (Ireland)**: ヨーロッパユーザー向けの良いカバレッジ
- **ap-southeast-2 (Sydney)**: アジア太平洋ユーザー向けの一部モデルに限定

最新のモデル可用性については、[AWS Bedrockドキュメント](https://docs.aws.amazon.com/bedrock/latest/userguide/model-ids.html)を確認してください。

## 要件

| 名前 | バージョン |
|------|----------|
| terraform | >= 1.11.4 |
| aws | >= 5.96.0 |

## 入力

| 名前 | 説明 | タイプ | デフォルト | 必須 |
|------|-----|------|----------|:----:|
| bedrock_agent_name | Bedrockエージェントの名前 | `string` | `"bedrock-agent"` | no |
| bedrock_agent_instruction | Bedrockエージェントの指示 | `string` | `"あなたはAWS Bedrockを使用したAIアシスタントです..."` | no |
| bedrock_agent_foundation_model | 使用する基盤モデル。利用可能なモデルのリストについては上記の「利用可能な基盤モデル」セクションを参照してください | `string` | `"anthropic.claude-3-sonnet-20240229-v1:0"` | no |
| bedrock_agent_idle_session_ttl_in_seconds | アイドルセッションのTTL（秒） | `number` | `600` | no |
| bedrock_agent_description | Bedrockエージェントの説明 | `string` | `"AWS Bedrockを使用したAIアシスタント"` | no |
| bedrock_agent_alias_name | エージェントエイリアスの名前 | `string` | `"default"` | no |
| bedrock_agent_alias_description | エージェントエイリアスの説明 | `string` | `"デフォルトエイリアス"` | no |
| chatbot_configuration_name | Chatbot設定の名前 | `string` | `"bedrock-chatbot"` | no |
| chatbot_slack_channel_id | SlackチャンネルID | `string` | n/a | yes |
| chatbot_slack_team_id | SlackチームID | `string` | n/a | yes |
| chatbot_logging_level | ログレベル | `string` | `"INFO"` | no |

## 出力

| 名前 | 説明 |
|------|-----|
| bedrock_agent_connection_command | SlackでBedrockエージェントを接続するためのコマンド |
| bedrock_agent_arn | BedrockエージェントのARN |
| bedrock_agent_alias_id | BedrockエージェントエイリアスのID |
| bedrock_agent_role_arn | Bedrockエージェント用IAMロールのARN |
| chatbot_role_arn | Chatbot用IAMロールのARN |

## 例

### 基本的な使用例

```hcl
module "aws_bedrock_slack_agent" {
  source = "./modules/aws-bedrock-slack-agent"

  chatbot_slack_channel_id = "C0123456789"
  chatbot_slack_team_id    = "T0123456789"
}
```

### カスタム設定の使用例

```hcl
module "aws_bedrock_slack_agent" {
  source = "./modules/aws-bedrock-slack-agent"

  bedrock_agent_name        = "custom-agent"
  bedrock_agent_instruction = "カスタム指示..."
  bedrock_agent_description = "カスタムAIアシスタント"
  
  chatbot_slack_channel_id = "C0123456789"
  chatbot_slack_team_id    = "T0123456789"
  chatbot_logging_level    = "DEBUG"
}
```

## 謝辞

このモジュールの作成にあたり、以下の記事を参考にさせていただきました：

- [ついにBedrockとSlackがノーコードで連携できるようになったよ！](https://qiita.com/moritalous/items/b63d976c2c40af1c39e5) by [@moritalous](https://qiita.com/moritalous)

## ライセンス

MITライセンス。詳細については[LICENSE](LICENSE)を参照してください。

## 作者

nix-tkobayashi - [GitHub](https://github.com/nix-tkobayashi)