# variables.tf
variable "ingress_rules" {
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {
    ssh = {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    http = {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

# security_group.tf
resource "aws_security_group" "example" {
  name        = "example"
  description = "Allow inbound traffic"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port   #If omitted the iterator argument, the name of the variable defaults to the label of the dynamic block.
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}

output "ingress_rules_map" {
  value = var.ingress_rules
}
#   + ingress_rules_map       = {
#       + http = {
#           + cidr_blocks = [
#               + "0.0.0.0/0",
#             ]
#           + from_port   = 80
#           + protocol    = "tcp"
#           + to_port     = 80
#         }
#       + ssh  = {
#           + cidr_blocks = [
#               + "0.0.0.0/0",
#             ]
#           + from_port   = 22
#           + protocol    = "tcp"
#           + to_port     = 22
#         }
#     }

output "ingress_from_ports" {
  value = {
    for key, rule in var.ingress_rules:
      key => rule.from_port
  }
}
#   + ingress_from_ports      = {
#       + http = 80
#       + ssh  = 22
#     }

output "values_ingress_rules" {
  value = values(var.ingress_rules)
}
#   + values_ingress_rules    = [
#       + {
#           + cidr_blocks = [
#               + "0.0.0.0/0",
#             ]
#           + from_port   = 80
#           + protocol    = "tcp"
#           + to_port     = 80
#         },
#       + {
#           + cidr_blocks = [
#               + "0.0.0.0/0",
#             ]
#           + from_port   = 22
#           + protocol    = "tcp"
#           + to_port     = 22
#         },
#     ]

output "ingress_from_ports_list" {
  value = [
    for rule in values(var.ingress_rules) : rule.from_port
  ]
}
#   + ingress_from_ports_list = [
#       + 80,
#       + 22,
#     ]






  
