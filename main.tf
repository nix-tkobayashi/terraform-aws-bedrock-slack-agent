# AWSプロバイダーの設定
provider "aws" {
  region = "us-east-1" # バージニアリージョン
}

# Bedrockエージェントモジュールの呼び出し
module "aws_bedrock_slack_agent" {
  source = "./modules/aws-bedrock-slack-agent"

  # 必須パラメータ
  chatbot_slack_channel_id = var.chatbot_slack_channel_id
  chatbot_slack_team_id    = var.chatbot_slack_team_id
} 