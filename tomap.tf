
# tomap函数在Terraform中用于将其他数据类型（如列表）转换为字典。

# 将列表转换为字典:
variable "example_list" {
  type    = list(object({
    key   = string
    value = string
  }))
  default = [
    { key = "key1", value = "value1" },
    { key = "key2", value = "value2" }
  ]
}

locals {
  example_map = tomap({
    for item in var.example_list :
    item.key => item.value
  })
}

output "obj" {
  value = var.example_list
}

output "map" {
  value = local.example_map
}

# $ terraform plan

# Changes to Outputs:
#   + map = {
#       + key1 = "value1"
#       + key2 = "value2"
#     }
#   + obj = [
#       + {
#           + key   = "key1"
#           + value = "value1"
#         },
#       + {
#           + key   = "key2"
#           + value = "value2"
#         },
#     ]
