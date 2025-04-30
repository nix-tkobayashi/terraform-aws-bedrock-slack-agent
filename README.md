# Terraform AWS Bedrock Slack Agent

Terraform module for creating and managing AWS Bedrock agents with Slack integration. This module enables you to deploy AI assistants powered by Amazon Bedrock and connect them to your Slack workspace for seamless interaction.

## Features

- Create and configure AWS Bedrock agents
- Set up Slack integration using AWS Chatbot
- Manage IAM roles and policies for secure access
- Configure agent aliases for different environments
- Support for Claude 3 Sonnet model

## Setup Instructions

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
   - 必要な権限を付与

4. **Slackチャンネルの設定**
   - 対象のSlackチャンネルにAWS Chatbotアプリを追加
   - チャンネルで`/invite @AWS Chatbot`を実行

5. **Bedrockエージェントの接続**
   - チャンネルで`terraform output bedrock_agent_connection_command`の出力を実行
   - 接続が成功すると確認メッセージが表示されます

6. **エージェントの利用開始**
   - チャンネルで`@aws ask {コネクター名} {プロンプト}`の形式で質問
   - 例：`@aws ask bedrock-agent AWSのサービスについて教えて`

## Usage

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

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.4 |
| aws | >= 5.96.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bedrock_agent_name | Bedrockエージェントの名前 | `string` | `"bedrock-agent"` | no |
| bedrock_agent_instruction | Bedrockエージェントの指示 | `string` | `"あなたはAWS Bedrockを使用したAIアシスタントです..."` | no |
| bedrock_agent_foundation_model | 使用する基盤モデル | `string` | `"anthropic.claude-3-sonnet-20240229-v1:0"` | no |
| bedrock_agent_idle_session_ttl_in_seconds | アイドルセッションのTTL（秒） | `number` | `600` | no |
| bedrock_agent_description | Bedrockエージェントの説明 | `string` | `"AWS Bedrockを使用したAIアシスタント"` | no |
| bedrock_agent_alias_name | エージェントエイリアスの名前 | `string` | `"default"` | no |
| bedrock_agent_alias_description | エージェントエイリアスの説明 | `string` | `"デフォルトエイリアス"` | no |
| chatbot_configuration_name | Chatbot設定の名前 | `string` | `"bedrock-chatbot"` | no |
| chatbot_slack_channel_id | SlackチャンネルID | `string` | n/a | yes |
| chatbot_slack_team_id | SlackチームID | `string` | n/a | yes |
| chatbot_logging_level | ログレベル | `string` | `"INFO"` | no |

## Outputs

| Name | Description |
|------|-------------|
| bedrock_agent_connection_command | SlackでBedrockエージェントを接続するためのコマンド |
| bedrock_agent_arn | BedrockエージェントのARN |
| bedrock_agent_alias_id | BedrockエージェントエイリアスのID |
| bedrock_agent_role_arn | Bedrockエージェント用IAMロールのARN |
| chatbot_role_arn | Chatbot用IAMロールのARN |

## Examples

### 基本的な使用例

```hcl
module "aws_bedrock_slack_agent" {
  source = "github.com/nix-tkobayashi/terraform-aws-bedrock-slack-agent"

  chatbot_slack_channel_id = "C0123456789"
  chatbot_slack_team_id    = "T0123456789"
}
```

### カスタム設定の使用例

```hcl
module "aws_bedrock_slack_agent" {
  source = "github.com/nix-tkobayashi/terraform-aws-bedrock-slack-agent"

  bedrock_agent_name        = "custom-agent"
  bedrock_agent_instruction = "カスタム指示..."
  bedrock_agent_description = "カスタムAIアシスタント"
  
  chatbot_slack_channel_id = "C0123456789"
  chatbot_slack_team_id    = "T0123456789"
  chatbot_logging_level    = "DEBUG"
}
```

## License

MIT Licensed. See [LICENSE](LICENSE) for full details.

## Author

nix-tkobayashi - [GitHub](https://github.com/nix-tkobayashi) 