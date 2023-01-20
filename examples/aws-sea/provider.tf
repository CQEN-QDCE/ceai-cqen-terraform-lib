provider "aws" {
    region = "ca-central-1"
    profile = var.aws_profile

    default_tags {
        tags = {
            system = var.system
            environment = var.environment
        }
    }
}