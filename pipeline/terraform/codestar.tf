resource "aws_codestarconnections_connection" "repository" {
  name          = "${var.project-name}-repository"
  provider_type = "GitHub"
}