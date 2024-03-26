# 要将变量传递到 Terraform 模块中，你需要做两件事情：

# 1.在模块中定义变量。
# 2.在调用模块时传递变量值。

以下是具体步骤：

在模块中定义变量：
假设你有一个名为 example 的模块，它位于 ./modules/example 目录下。你可以在该模块中创建一个 variables.tf 文件来定义变量，例如：
variable "example_var" {
  description = "An example variable"
  type        = string
}

在调用模块时传递变量值：
在使用模块的 Terraform 配置文件中，你可以通过指定模块块中的变量来传递值。例如：
module "example_module" {
  source      = "./modules/example"
  example_var = "some_value"
}

在这个例子中，example_var 变量的值被设置为 "some_value"。

当 Terraform 执行时，它将使用提供的值来实例化模块中的变量。在模块内部，你可以通过 ${var.example_var} 来访问该变量的值，例如，在资源定义中使用它。
