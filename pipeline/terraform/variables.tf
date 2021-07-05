variable "project-name" {
  description = "Project name"
  type        = string
}

variable "repository-path" {
  description = "Repository path. eg: edineipiovesan/codepipeline-sample"
  type        = string
  default     = "main"
}

variable "branch" {
  description = "Branch"
  type        = string
  default     = "main"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "dockerhub-username-arn" {
  description = "Secret manager arn with dockerhub username"
  type        = string
}

variable "dockerhub-password-arn" {
  description = "Secret manager arn with dockerhub password"
  type        = string
}