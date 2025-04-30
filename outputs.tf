output "bedrock_agent_connection_command" {
  description = "SlackでBedrockエージェントを接続するためのコマンド"
  value       = module.aws_bedrock_slack_agent.bedrock_agent_connection_command
}

output "bedrock_agent_arn" {
  description = "BedrockエージェントのARN"
  value       = module.aws_bedrock_slack_agent.bedrock_agent_arn
}

output "bedrock_agent_alias_id" {
  description = "BedrockエージェントエイリアスのID"
  value       = module.aws_bedrock_slack_agent.bedrock_agent_alias_id
} 