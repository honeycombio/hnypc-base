locals {
  ecr_repos = [
    # Terraform we'll need to bootstrap the instance
    "terraform-modules/infra",
    # Tooling we'll need to bootstrap the instance
    "tenant/upgrade-manager",
  ]
}

resource "aws_ecr_repository" "this" {
  for_each = toset(local.ecr_repos)
  name     = each.key

  image_tag_mutability = "MUTABLE"
}
