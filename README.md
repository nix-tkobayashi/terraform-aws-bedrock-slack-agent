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

## Available Foundation Models

The `bedrock_agent_foundation_model` parameter supports the following models. Note that model availability varies by AWS region.

### Anthropic Claude Models
| Model ID | Model Name | Supported Regions | Notes |
|----------|------------|-------------------|-------|
| `anthropic.claude-3-5-sonnet-20241022-v2:0` | Claude 3.5 Sonnet v2 | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | Latest version (recommended) |
| `anthropic.claude-3-5-sonnet-20240620-v1:0` | Claude 3.5 Sonnet v1 | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | Previous version |
| `anthropic.claude-3-sonnet-20240229-v1:0` | Claude 3 Sonnet | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | Current default |
| `anthropic.claude-3-haiku-20240307-v1:0` | Claude 3 Haiku | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | Fastest, most cost-effective |
| `anthropic.claude-3-opus-20240229-v1:0` | Claude 3 Opus | us-east-1, us-west-2 | Most capable, limited regions |
| `anthropic.claude-v2:1` | Claude 2.1 | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | Legacy model |
| `anthropic.claude-v2` | Claude 2 | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | Legacy model |
| `anthropic.claude-instant-v1` | Claude Instant | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | Legacy model |

### Amazon Titan Models
| Model ID | Model Name | Supported Regions | Notes |
|----------|------------|-------------------|-------|
| `amazon.titan-text-premier-v1:0` | Titan Text Premier | us-east-1, us-west-2, eu-west-1 | Latest text model |
| `amazon.titan-text-express-v1` | Titan Text Express | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | Fast text generation |
| `amazon.titan-text-lite-v1` | Titan Text Lite | us-east-1, us-west-2, eu-west-1, ap-southeast-2 | Lightweight text model |

### Meta Llama Models
| Model ID | Model Name | Supported Regions | Notes |
|----------|------------|-------------------|-------|
| `meta.llama3-2-90b-instruct-v1:0` | Llama 3.2 90B Instruct | us-east-1, us-west-2 | Latest large model |
| `meta.llama3-2-11b-instruct-v1:0` | Llama 3.2 11B Instruct | us-east-1, us-west-2, eu-west-1 | Medium size model |
| `meta.llama3-2-3b-instruct-v1:0` | Llama 3.2 3B Instruct | us-east-1, us-west-2, eu-west-1 | Smaller model |
| `meta.llama3-2-1b-instruct-v1:0` | Llama 3.2 1B Instruct | us-east-1, us-west-2, eu-west-1 | Smallest model |
| `meta.llama3-1-70b-instruct-v1:0` | Llama 3.1 70B Instruct | us-east-1, us-west-2 | Previous generation |
| `meta.llama3-1-8b-instruct-v1:0` | Llama 3.1 8B Instruct | us-east-1, us-west-2, eu-west-1 | Previous generation |

### Mistral AI Models
| Model ID | Model Name | Supported Regions | Notes |
|----------|------------|-------------------|-------|
| `mistral.mistral-large-2407-v1:0` | Mistral Large | us-east-1, us-west-2, eu-west-1 | Latest large model |
| `mistral.mistral-large-2402-v1:0` | Mistral Large (Feb 2024) | us-east-1, us-west-2, eu-west-1 | Previous version |
| `mistral.mistral-small-2402-v1:0` | Mistral Small | us-east-1, us-west-2, eu-west-1 | Smaller, faster model |

### Cohere Models
| Model ID | Model Name | Supported Regions | Notes |
|----------|------------|-------------------|-------|
| `cohere.command-r-plus-v1:0` | Command R Plus | us-east-1, us-west-2, eu-west-1 | Latest large model |
| `cohere.command-r-v1:0` | Command R | us-east-1, us-west-2, eu-west-1 | Standard model |
| `cohere.command-text-v14` | Command (Legacy) | us-east-1, us-west-2, eu-west-1 | Legacy model |

### Region Notes
- **us-east-1 (N. Virginia)**: Supports the widest range of models
- **us-west-2 (Oregon)**: Second-best model availability
- **eu-west-1 (Ireland)**: Good coverage for European users
- **ap-southeast-2 (Sydney)**: Limited to some models for Asia-Pacific users

For the most up-to-date model availability, check the [AWS Bedrock documentation](https://docs.aws.amazon.com/bedrock/latest/userguide/model-ids.html).

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
| bedrock_agent_foundation_model | 使用する基盤モデル。利用可能なモデルのリストについては上記の「Available Foundation Models」セクションを参照してください | `string` | `"anthropic.claude-3-sonnet-20240229-v1:0"` | no |
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

## Acknowledgments

このモジュールの作成にあたり、以下の記事を参考にさせていただきました：

- [ついにBedrockとSlackがノーコードで連携できるようになったよ！](https://qiita.com/moritalous/items/b63d976c2c40af1c39e5) by [@moritalous](https://qiita.com/moritalous)

## License

MIT Licensed. See [LICENSE](LICENSE) for full details.

## Author

nix-tkobayashi - [GitHub](https://github.com/nix-tkobayashi) 