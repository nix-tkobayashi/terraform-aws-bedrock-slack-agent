# Bedrockエージェント設定
variable "bedrock_agent_name" {
  description = "Bedrockエージェントの名前"
  type        = string
  default     = "bedrock-agent"
}

variable "bedrock_agent_instruction" {
  description = "Bedrockエージェントの指示"
  type        = string
  default     = "あなたはAWS Bedrockを使用したAIアシスタントです。ユーザーの質問に対して、正確で分かりやすい回答を提供してください。技術的な質問には特に詳しく説明し、必要に応じてコード例も示してください。"
}

variable "bedrock_agent_foundation_model" {
  description = "使用する基盤モデル。利用可能なモデルのリストについてはREADME.mdを参照してください。"
  type        = string
  default     = "anthropic.claude-3-sonnet-20240229-v1:0"
  
  validation {
    condition = can(regex("^(anthropic\\.|amazon\\.|meta\\.|mistral\\.|cohere\\.).+", var.bedrock_agent_foundation_model))
    error_message = "foundation_model must be a valid Bedrock model ID (starting with anthropic., amazon., meta., mistral., or cohere.). See README.md for available models."
  }
}

variable "bedrock_agent_idle_session_ttl_in_seconds" {
  description = "アイドルセッションのTTL（秒）"
  type        = number
  default     = 600
}

variable "bedrock_agent_description" {
  description = "Bedrockエージェントの説明"
  type        = string
  default     = "AWS Bedrockを使用したAIアシスタント"
}

# エージェントエイリアス設定
variable "bedrock_agent_alias_name" {
  description = "エージェントエイリアスの名前"
  type        = string
  default     = "default"
}

variable "bedrock_agent_alias_description" {
  description = "エージェントエイリアスの説明"
  type        = string
  default     = "デフォルトエイリアス"
}

# AWS Chatbot設定
variable "chatbot_configuration_name" {
  description = "Chatbot設定の名前"
  type        = string
  default     = "bedrock-chatbot"
}

variable "chatbot_slack_channel_id" {
  description = "SlackチャンネルID"
  type        = string
}

variable "chatbot_slack_team_id" {
  description = "SlackチームID"
  type        = string
}

variable "chatbot_logging_level" {
  description = "ログレベル"
  type        = string
  default     = "INFO"
}

# IAM設定
variable "bedrock_agent_role_name" {
  description = "Bedrockエージェント用IAMロール名"
  type        = string
  default     = "bedrock-agent-invoke-role"
}

variable "chatbot_role_name" {
  description = "Chatbot用IAMロール名"
  type        = string
  default     = "aws-chatbot-role"
}

variable "bedrock_agent_policy_name" {
  description = "Bedrockエージェント用IAMポリシー名"
  type        = string
  default     = "bedrock-agent-invoke-policy"
}

variable "chatbot_policy_name" {
  description = "Chatbot用IAMポリシー名"
  type        = string
  default     = "aws-chatbot-policy"
} 