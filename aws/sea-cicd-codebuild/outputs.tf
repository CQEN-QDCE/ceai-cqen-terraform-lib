output "aws_codecommit_repository_name" {
    value = aws_codecommit_repository.img_definition_repository.repository_name
    description = "Nom du repo AWS CodeCommit de la définition de l'image docker de l'application."
}

output "aws_codecommit_repository_default_branch" {
    value = aws_codecommit_repository.img_definition_repository.default_branch
    description = "Branch du repo AWS CodeCommit de la définition de l'image docker de l'application."  
}