output "bedrock_agent_connection_command" {
  description = "SlackでBedrockエージェントを接続するためのコマンド"
  value = format(
    "@Amazon Q connector add %s %s %s",
    var.chatbot_configuration_name,
    aws_bedrockagent_agent.example.agent_arn,
    aws_bedrockagent_agent_alias.example.agent_alias_id
  )
}

output "bedrock_agent_arn" {
  description = "BedrockエージェントのARN"
  value       = aws_bedrockagent_agent.example.agent_arn
}

output "bedrock_agent_alias_id" {
  description = "BedrockエージェントエイリアスのID"
  value       = aws_bedrockagent_agent_alias.example.agent_alias_id
}

output "bedrock_agent_role_arn" {
  description = "Bedrockエージェント用IAMロールのARN"
  value       = aws_iam_role.bedrock_agent_role.arn
}

output "chatbot_role_arn" {
  description = "Chatbot用IAMロールのARN"
  value       = aws_iam_role.chatbot_role.arn
} 