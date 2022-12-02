variable "github_org" {
  description = "value"
  type        = string
  default     = "edfenergy"  
}


variable "target_repository_full_name" {
  description = "value"
  type        = string
  default     = "pknw1/tf_target"  
} 

variable "commit_message" {
  description = "value"
  type        = string
  default     = "default commit message"  
}

variable "commit_author" {
  description = "value"
  type        = string
  default     = "default commit author"  
}

variable "commit_email" {
  description = "value"
  type        = string
  default     = "default@commit.email"  
}

variable "overwrite_on_create" {
  description = "value"
  type        = bool
  default     = true  
}

variable "apps" {
  description = "value"
  type        = list(string)
  default     = ["sandbox_workflow", "rover_workflow", "tfsec_workflow"]  
}

