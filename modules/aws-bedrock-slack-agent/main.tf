# AWSプロバイダーの設定
provider "aws" {
  region = "us-east-1" # バージニアリージョン
}

# Bedrockエージェントの作成
resource "aws_bedrockagent_agent" "example" {
  agent_name                  = var.bedrock_agent_name
  instruction                 = var.bedrock_agent_instruction
  foundation_model            = var.bedrock_agent_foundation_model
  idle_session_ttl_in_seconds = var.bedrock_agent_idle_session_ttl_in_seconds
  agent_resource_role_arn     = aws_iam_role.bedrock_agent_role.arn
  description                 = var.bedrock_agent_description
}

# エージェントエイリアスの作成
resource "aws_bedrockagent_agent_alias" "example" {
  agent_id         = aws_bedrockagent_agent.example.id
  agent_alias_name = var.bedrock_agent_alias_name
  description      = var.bedrock_agent_alias_description
}

# IAMポリシー（Bedrockエージェントの呼び出し権限）
resource "aws_iam_policy" "bedrock_agent_invoke_policy" {
  name        = var.bedrock_agent_policy_name
  description = "Bedrockエージェントの呼び出しを許可するポリシー"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "bedrock:InvokeAgent",
          "bedrock:InvokeModel",
          "bedrock:ListFoundationModels",
          "bedrock:GetFoundationModel"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

# IAMロール（Bedrockエージェント実行用）
resource "aws_iam_role" "bedrock_agent_role" {
  name = var.bedrock_agent_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "bedrock.amazonaws.com"
      },
      Effect = "Allow",
    }]
  })
}

# IAMロールにポリシーをアタッチ
resource "aws_iam_role_policy_attachment" "bedrock_agent_policy_attachment" {
  policy_arn = aws_iam_policy.bedrock_agent_invoke_policy.arn
  role       = aws_iam_role.bedrock_agent_role.name
}

# AWS Chatbot用のIAMロール
resource "aws_iam_role" "chatbot_role" {
  name = var.chatbot_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "chatbot.amazonaws.com"
      },
      Effect = "Allow",
    }]
  })
}

# AWS Chatbot用のIAMポリシー
resource "aws_iam_policy" "chatbot_policy" {
  name        = var.chatbot_policy_name
  description = "AWS Chatbot用のポリシー"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "bedrock:InvokeAgent",
          "bedrock:InvokeModel",
          "bedrock:ListFoundationModels",
          "bedrock:GetFoundationModel",
          "bedrock:ListAgents",
          "bedrock:ListAgentAliases"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

# AWS Chatbot用のIAMロールにポリシーをアタッチ
resource "aws_iam_role_policy_attachment" "chatbot_policy_attachment" {
  policy_arn = aws_iam_policy.chatbot_policy.arn
  role       = aws_iam_role.chatbot_role.name
}

# AWS Chatbotの設定
resource "aws_chatbot_slack_channel_configuration" "example" {
  configuration_name = var.chatbot_configuration_name
  iam_role_arn       = aws_iam_role.chatbot_role.arn
  slack_channel_id   = var.chatbot_slack_channel_id
  slack_team_id      = var.chatbot_slack_team_id
  logging_level      = var.chatbot_logging_level
  sns_topic_arns     = []
} 