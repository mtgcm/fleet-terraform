data "aws_region" "current" {}

resource "null_resource" "main" {
  triggers = {
    task_definition_revision = var.task_definition_revision
  }
  provisioner "local-exec" {
    command = "/bin/bash ${path.module}/migrate.sh REGION=${data.aws_region.current.region} VULN_SERVICE=${var.vuln_service} ECS_CLUSTER=${var.ecs_cluster} TASK_DEFINITION=${var.task_definition} TASK_DEFINITION_REVISION=${var.task_definition_revision} SUBNETS=${jsonencode(var.subnets)} SECURITY_GROUPS=${jsonencode(var.security_groups)} ECS_SERVICE=${var.ecs_service} MIN_CAPACITY=${var.min_capacity} DESIRED_COUNT=${var.desired_count} ASSUME_ROLE_ARN=${var.assume_role_arn} ASSUME_ROLE_SESSION_NAME=${var.assume_role_session_name}"
  }
}
