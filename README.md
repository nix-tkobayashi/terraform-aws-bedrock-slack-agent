# Terraform AWS Bedrock Slack Agent

Terraform module for creating and managing AWS Bedrock agents with Slack integration. This module enables you to deploy AI assistants powered by Amazon Bedrock and connect them to your Slack workspace for seamless interaction.

## Features

- Create and configure AWS Bedrock agents
- Set up Slack integration using AWS Chatbot
- Manage IAM roles and policies for secure access
- Configure agent aliases for different environments
- Support for Claude 3 Sonnet model

## Setup Instructions

1. **Slack Channel Preparation**
   - Determine the Slack channel to use
   - Get the channel ID (right-click channel name → "View channel details" → "Copy channel ID")
   - Get the team ID from the workspace URL (e.g., `T0123456789` from `https://app.slack.com/client/T0123456789`)

2. **Run Terraform**
   ```bash
   terraform init
   terraform apply
   ```

3. **AWS Chatbot and Slack Integration**
   - Set up integration with Slack workspace in the AWS Chatbot console
   - Grant necessary permissions (AmazonBedrockFullAccess)

4. **Slack Channel Configuration**
   - Add the AWS Chatbot app to the target Slack channel
   - Run `/invite @AWS Chatbot` in the channel

5. **Connect Bedrock Agent**
   - Run the following command in the channel:
   ```
   @aws connector add {connector-name} {Bedrock agent ARN} {Bedrock agent alias ID}
   ```
   - Connector name can be any name (shorter is recommended)
   - Bedrock agent ARN and alias ID can be found with `terraform output`:
     ```bash
     terraform output bedrock_agent_arn
     terraform output bedrock_agent_alias_id
     ```

6. **Start Using the Agent**
   - Ask questions in the format `@aws ask {connector-name} {prompt}`
   - Example: `@aws ask bedrock-agent Tell me about AWS services`

## Usage

```hcl
module "aws_bedrock_slack_agent" {
  source = "github.com/nix-tkobayashi/terraform-aws-bedrock-slack-agent"

  # Required parameters
  chatbot_slack_channel_id = "C0123456789"
  chatbot_slack_team_id    = "T0123456789"

  # Optional parameters
  bedrock_agent_name        = "my-bedrock-agent"
  bedrock_agent_instruction = "You are an AI assistant using AWS Bedrock..."
  bedrock_agent_description = "Custom AI Assistant"
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
| bedrock_agent_name | Name of the Bedrock agent | `string` | `"bedrock-agent"` | no |
| bedrock_agent_instruction | Instructions for the Bedrock agent | `string` | `"You are an AI assistant using AWS Bedrock..."` | no |
| bedrock_agent_foundation_model | Foundation model to use. See the "Available Foundation Models" section above for a list of available models | `string` | `"anthropic.claude-3-sonnet-20240229-v1:0"` | no |
| bedrock_agent_idle_session_ttl_in_seconds | Idle session TTL in seconds | `number` | `600` | no |
| bedrock_agent_description | Description of the Bedrock agent | `string` | `"AI assistant using AWS Bedrock"` | no |
| bedrock_agent_alias_name | Name of the agent alias | `string` | `"default"` | no |
| bedrock_agent_alias_description | Description of the agent alias | `string` | `"Default alias"` | no |
| chatbot_configuration_name | Name of the Chatbot configuration | `string` | `"bedrock-chatbot"` | no |
| chatbot_slack_channel_id | Slack channel ID | `string` | n/a | yes |
| chatbot_slack_team_id | Slack team ID | `string` | n/a | yes |
| chatbot_logging_level | Logging level | `string` | `"INFO"` | no |

## Outputs

| Name | Description |
|------|-------------|
| bedrock_agent_connection_command | Command to connect the Bedrock agent in Slack |
| bedrock_agent_arn | ARN of the Bedrock agent |
| bedrock_agent_alias_id | ID of the Bedrock agent alias |
| bedrock_agent_role_arn | ARN of the IAM role for the Bedrock agent |
| chatbot_role_arn | ARN of the IAM role for Chatbot |

## Examples

### Basic Usage

```hcl
module "aws_bedrock_slack_agent" {
  source = "./modules/aws-bedrock-slack-agent"

  chatbot_slack_channel_id = "C0123456789"
  chatbot_slack_team_id    = "T0123456789"
}
```

### Custom Configuration

```hcl
module "aws_bedrock_slack_agent" {
  source = "./modules/aws-bedrock-slack-agent"

  bedrock_agent_name        = "custom-agent"
  bedrock_agent_instruction = "Custom instructions..."
  bedrock_agent_description = "Custom AI Assistant"
  
  chatbot_slack_channel_id = "C0123456789"
  chatbot_slack_team_id    = "T0123456789"
  chatbot_logging_level    = "DEBUG"
}
```

## Acknowledgments

This module was inspired by the following article:

- [ついにBedrockとSlackがノーコードで連携できるようになったよ！](https://qiita.com/moritalous/items/b63d976c2c40af1c39e5) by [@moritalous](https://qiita.com/moritalous)

## License

MIT Licensed. See [LICENSE](LICENSE) for full details.

## Author

nix-tkobayashi - [GitHub](https://github.com/nix-tkobayashi)